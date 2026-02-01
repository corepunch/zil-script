-- Top-level compilation functions (ROUTINE, OBJECT, etc.)
local utils = require 'zilscript.compiler.utils'
local fields = require 'zilscript.compiler.fields'

local TopLevel = {}

-- Location flags for syntax objects
local loc_flags = {
  ["ON-GROUND"] = "SOG",
  ["IN-ROOM"] = "SIR",
  ["CARRIED"] = "SC",
  ["MANY"] = "SMANY",
  ["HAVE"] = "SHAVE",
  ["TAKE"] = "STAKE",
  ["HELD"] = "SH",
}

-- Syntax object helper
function TopLevel.printSyntaxObject(buf, nodes, start_idx, field_name, compiler)
  buf.writeln("\t%s = {", field_name)
  
  local i = start_idx + 1
  while utils.safeget(nodes[i], 'type') == "list" do
    local clause = nodes[i]
    if utils.safeget(clause[1], 'value') == "FIND" then
      buf.writeln("\t\tFIND = %s,", compiler.value(clause[2]))
    else
      buf.write("\t\tWHERE = ")
      for j = 1, #clause do
        buf.write(j == 1 and '%s' or '+%s', loc_flags[clause[j].value])
      end
      buf.writeln(",")
    end
    i = i + 1
  end
  
  buf.writeln("\t},")
  return i
end

-- Function header with locals and optional parameters
function TopLevel.writeFunctionHeader(buf, node, compiler, printNode)
  local params = {}
  local locals = {}
  local optionals = {}
  local mandatory = {}
  local mode = "params" -- params, locals, optional
  
  local args_node = node[2]
  if not args_node or args_node.type ~= "list" then
    buf.writeln(")")
    return
  end

  -- Parse argument list and register local variables
  for i = 1, #args_node do
    local arg = args_node[i]
    if arg.type == "string" then
      if arg.value == "AUX" then
        mode = "locals"
      elseif arg.value == "OPTIONAL" then
        mode = "optional"
      end
    elseif arg.type == "list" then
      local first_elem = arg[1]
      compiler.registerLocalVar(first_elem)
      if mode == "locals" then
        table.insert(locals, arg)
      else
        table.insert(params, compiler.localVarName(first_elem))
        table.insert(optionals, arg)
      end
    elseif arg.type == "ident" then
      compiler.registerLocalVar(arg)
      if mode == "locals" then
        table.insert(locals, arg)
      else
        local param_with_suffix = compiler.localVarName(arg)
        table.insert(params, param_with_suffix)
        if mode == "params" then  -- Only add to mandatory if in params mode, not optional
          table.insert(mandatory, param_with_suffix)
        end
      end
    end
  end
  
  -- Write parameters
  if #params > 0 then
    buf.writeln("\tlocal %s = ...", table.concat(params, ", "))
  end

  -- Write local declarations
  for _, local_node in ipairs(locals) do
    if local_node.type == "list" then
      buf.indent(1)
      buf.write("local %s = ", compiler.localVarName(local_node[1]))
      printNode(buf, local_node[2], 2)
      buf.writeln()
    else
      buf.writeln("\tlocal %s", compiler.localVarName(local_node))
    end
  end
  
  -- Write optional defaults
  for i, opt in ipairs(optionals) do
    buf.write("\tif select('#', ...) < %d then %s = ", #mandatory+i, compiler.localVarName(opt[1]))
    printNode(buf, opt[2], 2)
    buf.writeln(" end")
  end
end

-- Compile a ROUTINE
function TopLevel.compileRoutine(decl, body, node, compiler, printNode)
  local name = compiler.value(node[1])
  compiler.current_verbs = {}
  compiler.local_vars = {}  -- Reset local variables for new routine
  decl.writeln("%s = function(...)", name)
  TopLevel.writeFunctionHeader(decl, node, compiler, printNode)
  decl.writeln("\tlocal __ok, __res = pcall(function()")
  decl.writeln("\tlocal __tmp = nil")
  for i = 3, #node do
    if utils.needReturn(node[i]) then decl.write("\t__tmp = ") end
    printNode(decl, node[i], 1)
    decl.writeln()
  end
  decl.writeln("\t return __tmp end)")
  decl.writeln("\tif __ok or type(__res) ~= 'string' then")
  decl.writeln("return __res")
  decl.writeln(string.format("\telse error(__res and '%s\\n'..__res or '%s') end", name, name))
  decl.writeln("end")

  decl.writeln("_%s = {", name)
  for _, v in ipairs(compiler.current_verbs) do
   decl.writeln("\t'%s',", v)
  end
  decl.writeln("}")
end

-- Normalize property name (IN/LOCATION -> LOC)
local function normalizeProperty(prop)
  if prop == "IN" or prop == "LOCATION" then return "LOC" end
  return prop
end

-- Compile an OBJECT or ROOM
function TopLevel.compileObject(decl, body, node, compiler)
  local name = compiler.value(node[1])

  decl.writeln('%s = DECL_OBJECT("%s")', name, name)
  body.writeln("%s {", node.name)
  body.writeln("\tNAME = \"%s\",", name)
  
  for i = 2, #node do
    local field = node[i]
    if field.type == "list" and utils.safeget(field[1], 'type') == "ident" and field[2] then
      local field_name = compiler.value(field[1])
      local field_value = compiler.value(field[2])
      
      if field_value == "TO" then
        body.write("\t%s = ", field_name)
        fields.writeNav(body, field, compiler)
        body.writeln(",")
      elseif field_value == "PER" then
        body.writeln("\t%s = { per = %s },", field_name, compiler.value(field[3]))
      else
        local prop = normalizeProperty(field_name)
        body.write("\t%s = ", prop)
        fields.writeField(body, field, field[1].value, compiler)
        body.writeln(",")
      end
    end
  end
  body.writeln("}", name)
end

-- Compile a DEFMAC (macro definition)
function TopLevel.compileMacro(decl, body, node, compiler)
  local name = compiler.value(node[1])
  
  -- Store the macro definition in the compiler
  -- Macros are expanded at compile time, not runtime
  compiler.macros[name] = {
    params = node[2],  -- Parameter list (may include quoted params like 'OBJ, "ARGS")
    body = node[3]     -- Macro body (typically a FORM expression)
  }
  
  -- DEFMACs don't generate runtime code, only compile-time definitions
  -- So we don't write anything to decl or body
end

-- Top-level compiler registry
TopLevel.TOP_LEVEL_COMPILERS = {
  ROOM = TopLevel.compileObject,
  OBJECT = TopLevel.compileObject,
  ROUTINE = TopLevel.compileRoutine,
  DEFMAC = TopLevel.compileMacro,
  GDECL = function() end,
  DIRECTIONS = function(_, buf, node)
    buf.write("%s(", node.name)
    for _, dir in ipairs(node) do
      buf.write("\"%s\", ", dir.value)
    end
    buf.writeln("nil)")
  end,
}

-- Top-level statements that should be printed directly
TopLevel.DIRECT_STATEMENTS = {
  COND = true,
  BUZZ = true,
  SYNONYM = true,
  SYNTAX = true,
  GLOBAL = true,
  CONSTANT = true,
  SETG = true,
  ["INSERT-FILE"] = true,
}

return TopLevel
