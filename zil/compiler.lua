-- ZIL to Lua Compiler
local sourcemap = require 'zil.sourcemap'

local Compiler = {
  flags = {},
  current_flag = 1,
  current_decl = nil,
  current_verbs = {},
  prog = 1,
  current_lua_filename = nil,  -- Track the current output Lua filename
  current_source = nil          -- Track the current ZIL source location
}

-- Output buffers using tables for efficient concatenation
local function Buffer()
  local lines = {}
  local current_line = 1  -- Track current Lua line number
  
  -- Helper to count newlines and record source mapping
  local function count_newlines_and_map(text)
    local newline_count = 0
    for _ in text:gmatch("\n") do
      newline_count = newline_count + 1
      current_line = current_line + 1
      
      -- Record source mapping if we have source info
      if Compiler.current_lua_filename and Compiler.current_source then
        local src = Compiler.current_source
        sourcemap.add_mapping(
          Compiler.current_lua_filename,
          current_line,
          src.filename,
          src.line,
          src.col
        )
      end
    end
    return newline_count
  end
  
  return {
    write = function(fmt, ...)
      local text = string.format(fmt, ...)
      table.insert(lines, text)
      count_newlines_and_map(text)
    end,
    writeln = function(fmt, ...)
      local text = ""
      if fmt then
        text = string.format(fmt, ...)
        table.insert(lines, text)
      end
      table.insert(lines, "\n")
      
      -- Count newlines in the formatted text
      count_newlines_and_map(text)
      
      -- Count the newline we just added
      current_line = current_line + 1
      
      -- Record source mapping if we have source info
      if Compiler.current_lua_filename and Compiler.current_source then
        local src = Compiler.current_source
        sourcemap.add_mapping(
          Compiler.current_lua_filename,
          current_line,
          src.filename,
          src.line,
          src.col
        )
      end
    end,
    indent = function(level)
      table.insert(lines, string.rep("  ", level))
    end,
    get = function()
      return table.concat(lines)
    end,
    clear = function()
      lines = {}
      current_line = 1
    end,
    get_line = function()
      return current_line
    end
  }
end

local function safeget(node, attr)
  return node and node[attr] or nil
end

-- Convert ZIL values to Lua representations
local function value(node)
  -- Handle number nodes (where value is already a number)
  if node.type == "number" then
    return tostring(node.value)
  end

  if not (node.value or node.name) then return "nil" end
  
  local val = tostring(node.value or node.name)
  
  -- Strings
  if node.type == "string" then
    val = val:gsub("\\", "/"):gsub("|\n", "\\n"):gsub("\n", " "):gsub("|", "\\n"):gsub("\"", "\\\"")
    return string.format("\"%s\"", val)
  end
    
  -- Octal numbers (starting with *)
  if val:match("^%*") then
    return tostring(tonumber(val:match("%d+"), 8))
  end
  
  -- Property references (,P?...)
  if val:match("^,P%?") then
    -- return string.format('"PQ%s"', val:sub(4))
    return string.format('PQ%s', val:sub(4))
  end

  -- Convert identifier to Lua-safe name
  local result = val
    :gsub("^[,.]+", "")        -- Remove leading commas/dots
    :gsub("[,.]", "")          -- Remove internal commas/dots
    :gsub("%-", "_") -- Replace - between alphanumeric chars
    :gsub("%?", "Q")           -- Question mark to Q
    :gsub("\\", "/")           -- Backslash to forward slash
  
  -- Convert leading numbers to letters (a-j for 0-9)
  if result:match("^%d") then
    result = result:gsub("^(%d+)", function(digits)
      return digits:gsub("%d", function(d)
        return string.char(string.byte('a') + tonumber(d))
      end)
    end)
  end
  
  return result
end

-- Field writer functions
local function write_list_string(buf, node)
  local list = {}
  buf.write("{")
  for child in Compiler.iter_children(node, 1) do
    table.insert(list, string.format('"%s"', value(child)))
  end
  buf.write(table.concat(list, ", "))
  buf.write("}")
end

local function write_list(buf, node)
  local list = {} 
  buf.write("{")
  for child in Compiler.iter_children(node, 1) do
    table.insert(list, value(child))
  end
  buf.write(table.concat(list, ", "))
  buf.write("}")
end

local function write_string_field(buf, node)
  for child in Compiler.iter_children(node, 1) do
    if child.type ~= "string" then
      buf.write('"%s"', child.value)
    else
      buf.write("%s", value(child))
    end
    break
  end
end

local function write_value_field(buf, node)
  for child in Compiler.iter_children(node, 1) do
    buf.write("%s", value(child))
    break
  end
end

local FIELD_WRITERS = {
  FLAGS = write_list_string,
  SYNONYM = write_list_string,
  ADJECTIVE = write_list_string,
  DESC = write_string_field,
  LDESC = write_string_field,
  FDESC = write_string_field,
  ACTION = write_value_field,
  IN = write_value_field,
  GLOBAL = write_list,
}
-- Navigation direction writer
-- Format: (direction TO room [IF condition [IS flag]] [ELSE say])
local function write_nav(buf, node)
  local parts = {}
  
  -- Collect navigation parts
  for child in Compiler.iter_children(node, 1) do
    table.insert(parts, child)
  end
  
  -- parts[1] = TO
  -- parts[2] = room
  -- parts[3] = IF (optional)
  -- parts[4] = condition (optional)
  -- parts[5] = IS (optional)
  -- parts[6] = flag (optional)
  -- parts[7] = ELSE (optional)
  -- parts[8] = say (optional)
  
  if safeget(parts[3], 'value') == "IF" and parts[4] then
    -- Conditional navigation - use table and/or for short-circuit evaluation
    local cond = value(parts[4])
    
    -- Check for IS flag test
    if safeget(parts[5], 'value') == "IS" and parts[6] then
      cond = "door = "..cond
    else
      cond = "flag = "..cond
    end
    
    local room = value(parts[2])
    
    -- Check for ELSE clause
    local else_idx = safeget(parts[5], 'value') == "ELSE" and 6 or
                     safeget(parts[7], 'value') == "ELSE" and 8 or nil
    local say = else_idx and parts[else_idx] and value(parts[else_idx]) or nil
    
    if say then
      buf.write("{%s, %s, say = %s}", room, cond, say)
    else
      buf.write("{%s, %s}", room, cond)
    end
  elseif parts[2] then
    -- Simple navigation
    buf.write(value(parts[2]))
  elseif safeget(parts[1], 'type') == "string" then
    buf.write("%s", value(parts[1]))
  else
    buf.write("nil")
  end
end

-- Write field using appropriate writer or default
local function write_field(buf, node, field_name)
  local writer = FIELD_WRITERS[field_name] or write_value_field
  writer(buf, node)
end

-- AST node iteration helper
function Compiler.iter_children(node, skip)
  skip = skip or 0
  local i = skip + 1
  return function()
    if node[i] then
      local child = node[i]
      i = i + 1
      return child
    end
  end
end

-- Check node type helpers
local function is_cond(n)
  return n.type == "expr" and n.name == "COND"
end

local nodes = {COND=true,PROG=true,REPEAT=true,AGAIN=true,RETURN=true,RTRUE=true,RFALSE=true,GLOBAL=true}

local function need_return(node)
  return node.value ~= "" and (node.type ~= "expr" or not nodes[node.name])
end

-- Forward declaration
local print_node

-- Function header with locals and optional parameters
local function write_function_header(buf, node)
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

  -- Parse argument list
  for arg in Compiler.iter_children(args_node) do
    if arg.type == "string" then
      if arg.value == "AUX" then
        mode = "locals"
      elseif arg.value == "OPTIONAL" then
        mode = "optional"
      end
    elseif arg.type == "list" then
      if mode == "locals" then
        table.insert(locals, arg)
      else
        table.insert(params, value(arg[1]))
        table.insert(optionals, arg)
      end
    elseif arg.type == "ident" then
      if mode == "locals" then
        table.insert(locals, arg)
      else
        table.insert(params, value(arg))
        table.insert(mandatory, value(arg))
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
      buf.write("local %s = ", value(local_node[1]))
      print_node(buf, local_node[2], 2)
      buf.writeln()
    else
      buf.writeln("\tlocal %s", value(local_node))
    end
  end
  
  -- Write optional defaults
  for i, opt in ipairs(optionals) do
    buf.write("\tif select('#', ...) < %d then %s = ", #mandatory+i, value(opt[1]))
    print_node(buf, opt[2], 2)
    buf.writeln(" end")
  end
end

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
local function print_syntax_object(buf, nodes, start_idx, field_name)
  buf.writeln("\t%s = {", field_name)
  
  local i = start_idx + 1
  while safeget(nodes[i], 'type') == "list" do
    local clause = nodes[i]
    if safeget(clause[1], 'value') == "FIND" then
      buf.writeln("\t\tFIND = %s,", value(clause[2]))
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

-- Expression handlers table
local form = {}

-- COND (if-elseif-else)
form.COND = function(buf, node, indent)
  for i, clause in ipairs(node) do
    buf.writeln()
    buf.indent(indent)
    if safeget(clause[1], 'value') == "ELSE" then
      buf.write("else ")
    else
      buf.write(i == 1 and "if " or "elseif ")
      buf.write("APPLY(function() __tmp = ")
      print_node(buf, clause[1], indent + 1)
      buf.write(" return __tmp end)")
      buf.write(" then ")
    end
    
    -- Then clauses
    for j = 2, #clause do
    -- for j = math.min(#clause, 2), #clause do
      buf.writeln()
      buf.indent(indent + 1)
      if need_return(clause[j]) then buf.write("\t__tmp = ") end
      print_node(buf, clause[j], indent + 1)
    end
  end
  buf.writeln()
  buf.indent(indent)
  buf.writeln("end")
end

-- SET/SETG
local function compile_set(buf, node, indent)
  buf.write("APPLY(function() %s = ", value(node[1]))
  for i = 2, #node do
    if is_cond(node[i]) then
      buf.write("APPLY(function()")
      print_node(buf, node[i], indent + 1)
      buf.write(" return __tmp end)")
    else
      print_node(buf, node[i], indent + 1)
    end
  end
  -- buf.write(" print('\t"..value(node[1]).."', "..value(node[1])..")")
  -- buf.write(" if '"..value(node[1]).."' == 'P_NAM' then print(debug.traceback()) end")
  buf.write(" return %s end)", value(node[1]))
end

form.SET = compile_set
form.SETG = compile_set

form["IGRTR?"] = function(buf, node, indent)
  buf.write("APPLY(function() %s = %s + 1", value(node[1]), value(node[1]))
  buf.write(" return %s > %s end)", value(node[1]), value(node[2]))
end

form["DLESS?"] = function(buf, node, indent)
  buf.write("APPLY(function() %s = %s - 1", value(node[1]), value(node[1]))
  buf.write(" return %s < %s end)", value(node[1]), value(node[2]))
end

-- RETURN
form.RETURN = function(buf, node, indent)
  if node[1] then
    buf.write("error(")
    print_node(buf, node[1], indent + 1)
    buf.write(")")
  else
    buf.write("return true")
  end
end

-- RTRUE
form.RTRUE = function(buf, node, indent)
  buf.write("\terror(true)")
end

-- RFALSE
form.RFALSE = function(buf, node, indent)
  buf.write("\terror(false)")
end

-- RFATAL
form.RFATAL = function(buf, node, indent)
  buf.write("\terror(2)")
end

local __again = 0xDEADBEEF

form.AGAIN = function(buf, node, indent)
  buf.write("\terror(0x%X)", __again)
end

-- PROG (do block)
form.PROG = function(buf, node, indent)
  local p = Compiler.prog
  Compiler.prog = Compiler.prog + 1
  buf.writeln()
  buf.indent(indent)
  buf.writeln("local __prog%d = function()", p)
  for i = 2, #node do
    buf.indent(indent + 1)
    print_node(buf, node[i], indent + 1)--add_return and i == #node)
  end
  buf.writeln("end")
  buf.writeln("local __ok%d, __res%d", p, p)
  buf.writeln("repeat __ok%d, __res%d = pcall(__prog%d)", p, p, p)
  buf.writeln("until __ok%d or __res%d ~= 0x%X", p, p, __again)
  buf.writeln("if not __ok%d then error(__res%d)", p, p)
  buf.writeln("else __tmp = __res%d or true end", p, p)
end

-- REPEAT (while true loop)
form.REPEAT = function(buf, node, indent)
  local p = Compiler.prog
  Compiler.prog = Compiler.prog + 1
  buf.writeln()
  buf.indent(indent)
  buf.writeln("local __prog%d = function()", p)
  for i = 2, #node do
    buf.indent(indent + 1)
    print_node(buf, node[i], indent + 1)
    buf.writeln()
  end
  buf.writeln()
  buf.writeln("error(0x%X) end", __again)
  buf.writeln("local __ok%d, __res%d", p, p)
  buf.writeln("repeat __ok%d, __res%d = pcall(__prog%d)", p, p, p)
  buf.writeln("until __ok%d or __res%d ~= 0x%X", p, p, __again)
  buf.writeln("if not __ok%d then error(__res%d)", p, p)
  buf.writeln("else __tmp = __res%d or true end", p, p)
end

-- BUZZ
form.BUZZ = function(buf, node, indent)
  buf.write("BUZZ(")
  for i = 1, #node do
    if i > 1 then buf.write(", ") end
    buf.write('"%s"', node[i].value)
  end
  buf.writeln(")")
end

-- SYNONYM
form.SYNONYM = function(buf, node, indent)
  buf.write("SYNONYM(")
  for i = 1, #node do
    if i > 1 then buf.write(", ") end
    buf.write('"%s"', node[i].value)
  end
  buf.writeln(")")
end

-- GLOBAL
form.GLOBAL = function(buf, node, indent)
  buf.write("%s = ", value(node[1]))
  for i = 2, #node do
    print_node(buf, node[i], 0 and i == #node)
    buf.writeln()
  end
end

form.CONSTANT = form.GLOBAL

-- SYNTAX
form.SYNTAX = function(buf, node, indent)
  Compiler.current_decl.writeln('_G["NUM_%s"] = (_G["NUM_%s"] or 0) + 1', node[1].value, node[1].value)

  buf.writeln("SYNTAX {")
  buf.writeln('\tVERB = "%s\",', node[1].value)
  
  local i = 2
  while safeget(node[i], 'value') ~= "OBJECT" and node[i].value ~= "=" do
    buf.writeln("\tPREFIX = \"%s\",", node[i].value)
    i = i + 1
  end
  
  if safeget(node[i], 'value') == "OBJECT" then
    i = print_syntax_object(buf, node, i, "OBJECT")
  end
  
  if safeget(node[i], 'value') ~= "OBJECT" and node[i].value ~= "=" then
    buf.writeln('\tJOIN = "%s",', node[i].value)
    i = i + 1
  end
  
  if safeget(node[i], 'value') == "OBJECT" then
    i = print_syntax_object(buf, node, i, "SUBJECT")
  end
  
  if safeget(node[i], 'value') == "=" then
    buf.writeln("\tACTION = \"%s\",", value(node[i + 1]))

    if safeget(node[i+2], 'value') then
      buf.writeln("\tPREACTION = \"%s\",", value(node[i+2]))
    end

  end

  buf.writeln("}")
end

form.LTABLE = function(buf, node)
  local start = safeget(node[1], 'type') == "list" and 2 or 1
  buf.write("LTABLE(")
  for i = start, #node do
    print_node(buf, node[i], 0)
    if i < #node then buf.write(",") end
  end
  buf.write(")")
end
form.ITABLE = function(buf, node)
  local num = node[1].value == "NONE" and node[2].value or node[1].value
  buf.write("ITABLE(%s)", num)
end
form.TABLE = function(buf, node)
  local start = safeget(node[1], 'type') == "list" and 2 or 1
  buf.write("TABLE(")
  for i = start, #node do
    print_node(buf, node[i], 0)
    if i < #node then buf.write(",") end
  end
  buf.write(")")
end

-- AND/OR
local function compile_logical(buf, node, indent, op)
  if indent == 1 then buf.indent(indent) end
  buf.write("PASS(")
  for i = 1, #node do
    if is_cond(node[i]) then
      buf.write("APPLY(function() ")
      print_node(buf, node[i], indent + 1)
      buf.write(" end)")
    else
      print_node(buf, node[i], indent + 1)
    end
    if i < #node then buf.write(string.format(" %s ", string.lower(op))) end
  end
  buf.write(")")
end

form.AND = function(buf, node, indent)
  compile_logical(buf, node, indent, "AND")
end

form.OR = function(buf, node, indent)
  compile_logical(buf, node, indent, "OR")
end

-- Main code generation
function print_node(buf, node, indent)
  indent = indent or 0
  
  -- Update current source location from node metadata
  local meta = getmetatable(node)
  if meta and meta.source then
    Compiler.current_source = meta.source
  end

  if node.type == "expr" then
    if #node.name == 0 then buf.write("nil")  return true  end
    local handler = form[node.name]
    if handler then
      -- Use specialized handler
      handler(buf, node, indent)
    else
      -- Generic function call
      if indent == 1 then buf.indent(indent) end
      local ops = {
        ["+"] = "ADD",
        ["-"] = "SUB",
        ["/"] = "DIV",
        ["*"] = "MULL",
        ["=?"] = "EQUALQ",
        ["==?"] = "EQUALQ",
        ["N=?"] = "NEQUALQ",
        ["N==?"] = "NEQUALQ",
        ["0?"] = "ZEROQ",
        ["1?"] = "ONEQ",
      }
      if node.name == 'VERB?' then table.insert(Compiler.current_verbs, node[1].value) end
      buf.write("%s(", ops[node.name] or node.name:gsub("%-", "_"):gsub("%?", "Q"))
      for i = 1, #node do
        if is_cond(node[i]) then
          buf.write("APPLY(function()")
          print_node(buf, node[i], indent + 1, true)
          buf.write(" end)")
        elseif node.name == 'VERB?' then
          buf.write("VQ%s", value(node[i]))
        else
          print_node(buf, node[i], indent + 1, false)
        end
        if i < #node then buf.write(", ") end
      end
      buf.write(")")
    end
    
  else
    -- Atoms: ident, string, number, symbol
    buf.write("%s", value(node))
  end

  return true
end

-- Top-level compilation functions
local function compile_routine(decl, body, node)
  local name = value(node[1])
  Compiler.current_verbs = {}
  -- decl.writeln("%s = nil", name)
  decl.writeln("%s = function(...)", name)
  write_function_header(decl, node)
  -- decl.writeln("\tprint('\t%s')", name:gsub("_", "-"))
  decl.writeln("\tlocal __ok, __res = pcall(function()")
  decl.writeln("\tlocal __tmp = nil")
  for i = 3, #node do
    if need_return(node[i]) then decl.write("\t__tmp = ") end
    print_node(decl, node[i], 1)
    decl.writeln()
  end
  decl.writeln("\t return __tmp end)")
  -- decl.writeln("\tif __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then")
  decl.writeln("\tif __ok or type(__res) ~= 'string' then")
  -- decl.writeln("print('\t\t(%s) '..tostring(__res))", name:gsub("_", "-"))
  decl.writeln("return __res")
  decl.writeln(string.format("\telse error(__res and '%s\\n'..__res or '%s') end", name, name))
  decl.writeln("end")

  decl.writeln("_%s = {", name)
  for _, v in ipairs(Compiler.current_verbs) do
   decl.writeln("\t'%s',", v)
  end
  decl.writeln("}")
end

local function compile_object(decl, body, node)
  local name = value(node[1])

  -- decl.writeln('%s = setmetatable({}, { __tostring = function(self) return self.DESC or "%s" end })', name, name)
  decl.writeln('%s = DECL_OBJECT("%s")', name, name)
  body.writeln("%s {", node.name)
  body.writeln("\tNAME = \"%s\",", name)
  for i = 2, #node do
    local field = node[i]
    if field.type == "list" and safeget(field[1], 'type') == "ident" and field[2] then
      if value(field[2]) == "TO" then
        body.write("\t%s = ", value(field[1]))
        write_nav(body, field)
        body.writeln(",")
      elseif value(field[2]) == "PER" then
        body.write("\t%s = { per = %s }", value(field[1]), value(field[3]))
        body.writeln(",")
      else
        local prop = value(field[1])
        if prop == "IN" then prop = "LOC" end
        if prop == "LOCATION" then prop = "LOC" end
        body.write("\t%s = ", prop)
        write_field(body, field, field[1].value)
        body.writeln(",")
      end
    end
  end
  body.writeln("}", name)
end

-- Top-level compiler registry
local TOP_LEVEL_COMPILERS = {
  ROOM = compile_object,
  OBJECT = compile_object,
  ROUTINE = compile_routine,
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
local DIRECT_STATEMENTS = {
  COND = true,
  BUZZ = true,
  SYNONYM = true,
  SYNTAX = true,
  GLOBAL = true,
  CONSTANT = true,
  SETG = true,
  -- PROG = true,
}

-- Main compilation entry point
-- lua_filename: the name of the Lua file being generated (for source mapping) - optional
function Compiler.compile(ast, lua_filename)
  local decl = Buffer()
  local body = Buffer()

  -- Reset compiler state for this compilation
  Compiler.current_decl = decl
  Compiler.current_lua_filename = lua_filename or "unknown.lua"
  Compiler.current_source = nil
  
  for i = 1, #ast do
    local node = ast[i]
    
    if node.type == "expr" then
      local name = node.name or ""
      
      -- Skip GDECL
      if name == "GDECL" or name == "PROG" then
        goto continue
      end
      
      -- Direct statements
      if DIRECT_STATEMENTS[name] then
        print_node(body, node, 0, false)
        goto continue
      end
      
      -- Compile with appropriate handler
      if safeget(node[1], 'value') then
        local compiler = TOP_LEVEL_COMPILERS[name]
        if compiler then
          compiler(decl, body, node)
        else
          io.stderr:write(string.format("Unknown top-level form: %s on line %d\n", name, getmetatable(ast).source.line))
        end
      else
        io.stderr:write(string.format("Expected type in <%s> on line %d\n", name, getmetatable(ast).source.line))
      end
    end
    
    ::continue::
  end
  
  return {
    declarations = decl.get(),
    body = body.get(),
    combined = decl.get() .. "\n" .. body.get()
  }
end

return Compiler