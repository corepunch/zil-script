-- Expression form handlers for ZIL compiler
-- Each handler is responsible for emitting code for a specific ZIL form
--
-- Pattern Note: These handlers receive (buf, node, indent) and use:
-- - buf.write() for output (dot notation, not colon)
-- - node[i].value for direct property access (like TypeScript)
-- - compiler.value(node) for value conversion (helper function pattern)
--
-- This follows TypeScript's emitter pattern where specialized functions
-- handle different node types, rather than having nodes emit themselves.
local utils = require 'zilscript.compiler.utils'

local Forms = {}

-- Helper: Generate error return with specified value
local function writeErrorReturn(buf, error_value)
  buf.write("\terror(%s)", error_value)
end

-- Helper: Generate a function call with string arguments from node values
local function writeStringCall(buf, name, node)
  buf.write("%s(", name)
  for i = 1, #node do
    if i > 1 then buf.write(", ") end
    buf.write('"%s"', node[i].value)
  end
  buf.writeln(")")
end

-- Helper: Generate a table constructor call (LTABLE, TABLE share same pattern)
local function writeTableCall(buf, name, node, printNode)
  local start = utils.safeget(node[1], 'type') == "list" and 2 or 1
  buf.write("%s(", name)
  for i = start, #node do
    printNode(buf, node[i], 0)
    if i < #node then buf.write(",") end
  end
  buf.write(")")
end

-- Helper: Increment/decrement with comparison (IGRTR?, DLESS? share pattern)
local function writeModifyCompare(buf, node, op, cmp, compiler)
  local target = compiler.localVarName(node[1])
  buf.write("APPLY(function() %s = %s %s 1", target, target, op)
  buf.write(" return %s %s %s end)", target, cmp, compiler.value(node[2]))
end

local __again = 0xDEADBEEF

-- Helper: Generate pcall-wrapped prog block (PROG and REPEAT share structure)
local function writeProgBlock(buf, node, indent, is_repeat, compiler, printNode)
  local p = compiler.prog
  compiler.prog = compiler.prog + 1
  buf.writeln()
  buf.indent(indent)
  buf.writeln("local __prog%d = function()", p)
  for i = 2, #node do
    buf.indent(indent + 1)
    printNode(buf, node[i], indent + 1)
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
local function compileSet(buf, node, indent, compiler, printNode)
  local target = compiler.localVarName(node[1])
  buf.write("APPLY(function() %s = ", target)
  for i = 2, #node do
    if utils.isCond(node[i]) then
      buf.write("APPLY(function()")
      printNode(buf, node[i], indent + 1)
      buf.write(" return __tmp end)")
    else
      printNode(buf, node[i], indent + 1)
    end
  end
  buf.write(" return %s end)", target)
end

-- AND/OR implementation
local function compileLogical(buf, node, indent, op, compiler, printNode)
  if indent == 1 then buf.indent(indent) end
  buf.write("PASS(")
  for i = 1, #node do
    if utils.isCond(node[i]) then
      buf.write("APPLY(function() ")
      printNode(buf, node[i], indent + 1)
      buf.write(" end)")
    else
      printNode(buf, node[i], indent + 1)
    end
    if i < #node then buf.write(string.format(" %s ", string.lower(op))) end
  end
  buf.write(")")
end

-- Create form handlers table
function Forms.createHandlers(compiler, printNode)
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
        printNode(buf, clause[1], indent + 1)
        buf.write(" return __tmp end)")
        buf.write(" then ")
      end
      
      -- Then clauses
      for j = 2, #clause do
        buf.writeln()
        buf.indent(indent + 1)
        if utils.needReturn(clause[j]) then buf.write("\t__tmp = ") end
        printNode(buf, clause[j], indent + 1)
      end
    end
    buf.writeln()
    buf.indent(indent)
    buf.writeln("end")
  end

  -- SET/SETG
  form.SET = function(buf, node, indent)
    compileSet(buf, node, indent, compiler, printNode)
  end
  form.SETG = form.SET

  -- IGRTR?, DLESS?
  form["IGRTR?"] = function(buf, node, indent)
    writeModifyCompare(buf, node, "+", ">", compiler)
  end

  form["DLESS?"] = function(buf, node, indent)
    writeModifyCompare(buf, node, "-", "<", compiler)
  end

  -- RETURN
  form.RETURN = function(buf, node, indent)
    if node[1] then
      buf.write("error(")
      printNode(buf, node[1], indent + 1)
      buf.write(")")
    else
      buf.write("return true")
    end
  end

  -- RTRUE, RFALSE, RFATAL
  form.RTRUE = function(buf, node, indent)
    writeErrorReturn(buf, "true")
  end

  form.RFALSE = function(buf, node, indent)
    writeErrorReturn(buf, "false")
  end

  form.RFATAL = function(buf, node, indent)
    writeErrorReturn(buf, "2")
  end

  -- PROG (do block)
  form.PROG = function(buf, node, indent)
    writeProgBlock(buf, node, indent, false, compiler, printNode)
  end

  -- REPEAT (while true loop)
  form.REPEAT = function(buf, node, indent)
    writeProgBlock(buf, node, indent, true, compiler, printNode)
  end

  form.AGAIN = function(buf, node, indent)
    buf.write("\terror(0x%X)", __again)
  end

  -- BUZZ and SYNONYM
  form.BUZZ = function(buf, node, indent)
    writeStringCall(buf, "BUZZ", node)
  end

  form.SYNONYM = function(buf, node, indent)
    writeStringCall(buf, "SYNONYM", node)
  end

  -- GLOBAL and CONSTANT
  form.GLOBAL = function(buf, node, indent)
    buf.write("%s = ", compiler.value(node[1]))
    for i = 2, #node do
      printNode(buf, node[i], 0)
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
      i = compiler.printSyntaxObject(buf, node, i, "OBJECT")
    end
    
    if utils.safeget(node[i], 'value') ~= "OBJECT" and node[i].value ~= "=" then
      buf.writeln('\tJOIN = "%s",', node[i].value)
      i = i + 1
    end
    
    if utils.safeget(node[i], 'value') == "OBJECT" then
      i = compiler.printSyntaxObject(buf, node, i, "SUBJECT")
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
    writeTableCall(buf, "LTABLE", node, printNode)
  end

  form.TABLE = function(buf, node)
    writeTableCall(buf, "TABLE", node, printNode)
  end

  form.ITABLE = function(buf, node)
    local num = node[1].value == "NONE" and node[2].value or node[1].value
    buf.write("ITABLE(%s)", num)
  end

  -- AND/OR
  form.AND = function(buf, node, indent)
    compileLogical(buf, node, indent, "AND", compiler, printNode)
  end

  form.OR = function(buf, node, indent)
    compileLogical(buf, node, indent, "OR", compiler, printNode)
  end

  -- FORM - Construct a form (used in macros)
  form.FORM = function(buf, node, indent)
    -- FORM creates an expression form at compile time
    -- Convert it to the actual form it represents
    if node[1] then
      -- Create a new expression node with the FORM's contents
      local form_name = compiler.value(node[1])
      buf.write("%s(", utils.normalizeFunctionName(form_name))
      for i = 2, #node do
        printNode(buf, node[i], indent)
        if i < #node then buf.write(", ") end
      end
      buf.write(")")
    else
      buf.write("nil")
    end
  end

  -- INSERT-FILE - Include and execute another ZIL file
  form["INSERT-FILE"] = function(buf, node, indent)
    -- Generate INCLUDE_FILE call with the filename
    if node[1] and node[1].type == "string" then
      buf.write('INCLUDE_FILE("%s")', node[1].value)
    else
      buf.write('INCLUDE_FILE("")')
    end
  end

  return form
end

return Forms
