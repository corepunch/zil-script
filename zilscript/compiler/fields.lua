-- Field writing functions for ZIL objects
local utils = require 'zilscript.compiler.utils'

local Fields = {}

-- Helper: Write a list with optional formatting function
local function writeFormattedList(buf, node, formatter, compiler)
  local list = {}
  for i = 2, #node do
    local child = node[i]
    table.insert(list, formatter and formatter(child) or compiler.value(child))
  end
  buf.write("{")
  buf.write(table.concat(list, ", "))
  buf.write("}")
end

-- Write list of strings
local function writeListString(buf, node, compiler)
  writeFormattedList(buf, node, function(child)
    return string.format('"%s"', compiler.value(child))
  end, compiler)
end

-- Write plain list
local function writeList(buf, node, compiler)
  writeFormattedList(buf, node, nil, compiler)
end

-- Write first child with optional quoting
local function writeFirstChild(buf, node, quote_non_strings, compiler)
  if #node >= 2 then
    local child = node[2]
    if quote_non_strings and child.type ~= "string" then
      buf.write('"%s"', child.value)
    else
      buf.write("%s", compiler.value(child))
    end
  end
end

-- Write string field (first child, quoted)
local function writeStringField(buf, node, compiler)
  writeFirstChild(buf, node, true, compiler)
end

-- Write value field (first child, unquoted)
local function writeValueField(buf, node, compiler)
  writeFirstChild(buf, node, false, compiler)
end

-- Field writer dispatch table
Fields.FIELD_WRITERS = {
  FLAGS = writeListString,
  SYNONYM = writeListString,
  ADJECTIVE = writeListString,
  DESC = writeStringField,
  LDESC = writeStringField,
  FDESC = writeStringField,
  ACTION = writeValueField,
  IN = writeValueField,
  GLOBAL = writeList,
}

-- Navigation direction writer
-- Format: (direction TO room [IF condition [IS flag]] [ELSE say])
function Fields.writeNav(buf, node, compiler)
  local parts = {}
  
  -- Collect navigation parts
  for i = 2, #node do
    table.insert(parts, node[i])
  end
  
  -- parts[1] = TO
  -- parts[2] = room
  -- parts[3] = IF (optional)
  -- parts[4] = condition (optional)
  -- parts[5] = IS (optional)
  -- parts[6] = flag (optional)
  -- parts[7] = ELSE (optional)
  -- parts[8] = say (optional)
  
  if utils.safeget(parts[3], 'value') == "IF" and parts[4] then
    -- Conditional navigation - use table and/or for short-circuit evaluation
    local cond = compiler.value(parts[4])
    
    -- Check for IS flag test
    if utils.safeget(parts[5], 'value') == "IS" and parts[6] then
      cond = "door = "..cond
    else
      cond = "flag = "..cond
    end
    
    local room = compiler.value(parts[2])
    
    -- Check for ELSE clause
    local else_idx = utils.safeget(parts[5], 'value') == "ELSE" and 6 or
                     utils.safeget(parts[7], 'value') == "ELSE" and 8 or nil
    local say = else_idx and parts[else_idx] and compiler.value(parts[else_idx]) or nil
    
    if say then
      buf.write("{%s, %s, say = %s}", room, cond, say)
    else
      buf.write("{%s, %s}", room, cond)
    end
  elseif parts[2] then
    -- Simple navigation
    buf.write(compiler.value(parts[2]))
  elseif utils.safeget(parts[1], 'type') == "string" then
    buf.write("%s", compiler.value(parts[1]))
  else
    buf.write("nil")
  end
end

-- Write field using appropriate writer or default
function Fields.writeField(buf, node, field_name, compiler)
  local writer = Fields.FIELD_WRITERS[field_name] or writeValueField
  writer(buf, node, compiler)
end

return Fields
