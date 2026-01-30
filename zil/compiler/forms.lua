-- Expression form handlers for ZIL compiler
local utils = require 'zil.compiler.utils'

local Forms = {}

-- Helper: Generate error return with specified value
local function write_error_return(buf, error_value)
  buf.write("\terror(%s)", error_value)
end

-- Helper: Generate a function call with string arguments from node values
local function write_string_call(buf, name, node)
  buf.write("%s(", name)
  for i = 1, #node do
    if i > 1 then buf.write(", ") end
    buf.write('"%s"', node[i].value)
  end
  buf.writeln(")")
end

-- Helper: Generate a table constructor call (LTABLE, TABLE share same pattern)
local function write_table_call(buf, name, node, print_node)
  local start = utils.safeget(node[1], 'type') == "list" and 2 or 1
  buf.write("%s(", name)
  for i = start, #node do
    print_node(buf, node[i], 0)
    if i < #node then buf.write(",") end
  end
  buf.write(")")
end

-- Helper: Increment/decrement with comparison (IGRTR?, DLESS? share pattern)
local function write_modify_compare(buf, node, op, cmp, compiler)
  local target = compiler.local_var_name(node[1])
  buf.write("APPLY(function() %s = %s %s 1", target, target, op)
  buf.write(" return %s %s %s end)", target, cmp, compiler.value(node[2]))
end

local __again = 0xDEADBEEF

-- Helper: Generate pcall-wrapped prog block (PROG and REPEAT share structure)
local function write_prog_block(buf, node, indent, is_repeat, compiler, print_node)
  local p = compiler.prog
  compiler.prog = compiler.prog + 1
  buf.writeln()
  buf.indent(indent)
  buf.writeln("local __prog%d = function()", p)
  for i = 2, #node do
    buf.indent(indent + 1)
    print_node(buf, node[i], indent + 1)
    if is_repeat then buf.writeln() end
  end
  if is_repeat then
    buf.writeln()
    buf.writeln("error(0x%X) end", __again)
  else
    buf.writeln("end")
  end
  buf.writeln("local __ok%d, __res%d", p, p)
  buf.writeln("repeat __ok%d, __res%d = pcall(__prog%d)", p, p, p)
  buf.writeln("until __ok%d or __res%d ~= 0x%X", p, p, __again)
  buf.writeln("if not __ok%d then error(__res%d)", p, p)
  buf.writeln("else __tmp = __res%d or true end", p, p)
end

-- SET/SETG implementation
local function compile_set(buf, node, indent, compiler, print_node)
  local target = compiler.local_var_name(node[1])
  buf.write("APPLY(function() %s = ", target)
  for i = 2, #node do
    if utils.is_cond(node[i]) then
      buf.write("APPLY(function()")
      print_node(buf, node[i], indent + 1)
      buf.write(" return __tmp end)")
    else
      print_node(buf, node[i], indent + 1)
    end
  end
  buf.write(" return %s end)", target)
end

-- AND/OR implementation
local function compile_logical(buf, node, indent, op, compiler, print_node)
  if indent == 1 then buf.indent(indent) end
  buf.write("PASS(")
  for i = 1, #node do
    if utils.is_cond(node[i]) then
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

-- Create form handlers table
function Forms.create_handlers(compiler, print_node)
  local form = {}

  -- COND (if-elseif-else)
  form.COND = function(buf, node, indent)
    for i, clause in ipairs(node) do
      buf.writeln()
      buf.indent(indent)
      if utils.safeget(clause[1], 'value') == "ELSE" then
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
        buf.writeln()
        buf.indent(indent + 1)
        if utils.need_return(clause[j]) then buf.write("\t__tmp = ") end
        print_node(buf, clause[j], indent + 1)
      end
    end
    buf.writeln()
    buf.indent(indent)
    buf.writeln("end")
  end

  -- SET/SETG
  form.SET = function(buf, node, indent)
    compile_set(buf, node, indent, compiler, print_node)
  end
  form.SETG = form.SET

  -- IGRTR?, DLESS?
  form["IGRTR?"] = function(buf, node, indent)
    write_modify_compare(buf, node, "+", ">", compiler)
  end

  form["DLESS?"] = function(buf, node, indent)
    write_modify_compare(buf, node, "-", "<", compiler)
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

  -- RTRUE, RFALSE, RFATAL
  form.RTRUE = function(buf, node, indent)
    write_error_return(buf, "true")
  end

  form.RFALSE = function(buf, node, indent)
    write_error_return(buf, "false")
  end

  form.RFATAL = function(buf, node, indent)
    write_error_return(buf, "2")
  end

  -- PROG (do block)
  form.PROG = function(buf, node, indent)
    write_prog_block(buf, node, indent, false, compiler, print_node)
  end

  -- REPEAT (while true loop)
  form.REPEAT = function(buf, node, indent)
    write_prog_block(buf, node, indent, true, compiler, print_node)
  end

  form.AGAIN = function(buf, node, indent)
    buf.write("\terror(0x%X)", __again)
  end

  -- BUZZ and SYNONYM
  form.BUZZ = function(buf, node, indent)
    write_string_call(buf, "BUZZ", node)
  end

  form.SYNONYM = function(buf, node, indent)
    write_string_call(buf, "SYNONYM", node)
  end

  -- GLOBAL and CONSTANT
  form.GLOBAL = function(buf, node, indent)
    buf.write("%s = ", compiler.value(node[1]))
    for i = 2, #node do
      print_node(buf, node[i], 0)
      buf.writeln()
    end
  end

  form.CONSTANT = form.GLOBAL

  -- SYNTAX
  form.SYNTAX = function(buf, node, indent)
    compiler.current_decl.writeln('_G["NUM_%s"] = (_G["NUM_%s"] or 0) + 1', node[1].value, node[1].value)

    buf.writeln("SYNTAX {")
    buf.writeln('\tVERB = "%s\",', node[1].value)
    
    local i = 2
    while utils.safeget(node[i], 'value') ~= "OBJECT" and node[i].value ~= "=" do
      buf.writeln("\tPREFIX = \"%s\",", node[i].value)
      i = i + 1
    end
    
    if utils.safeget(node[i], 'value') == "OBJECT" then
      i = compiler.print_syntax_object(buf, node, i, "OBJECT")
    end
    
    if utils.safeget(node[i], 'value') ~= "OBJECT" and node[i].value ~= "=" then
      buf.writeln('\tJOIN = "%s",', node[i].value)
      i = i + 1
    end
    
    if utils.safeget(node[i], 'value') == "OBJECT" then
      i = compiler.print_syntax_object(buf, node, i, "SUBJECT")
    end
    
    if utils.safeget(node[i], 'value') == "=" then
      buf.writeln("\tACTION = \"%s\",", compiler.value(node[i + 1]))

      if utils.safeget(node[i+2], 'value') then
        buf.writeln("\tPREACTION = \"%s\",", compiler.value(node[i+2]))
      end

    end

    buf.writeln("}")
  end

  -- LTABLE, TABLE, ITABLE
  form.LTABLE = function(buf, node)
    write_table_call(buf, "LTABLE", node, print_node)
  end

  form.TABLE = function(buf, node)
    write_table_call(buf, "TABLE", node, print_node)
  end

  form.ITABLE = function(buf, node)
    local num = node[1].value == "NONE" and node[2].value or node[1].value
    buf.write("ITABLE(%s)", num)
  end

  -- AND/OR
  form.AND = function(buf, node, indent)
    compile_logical(buf, node, indent, "AND", compiler, print_node)
  end

  form.OR = function(buf, node, indent)
    compile_logical(buf, node, indent, "OR", compiler, print_node)
  end

  return form
end

return Forms
