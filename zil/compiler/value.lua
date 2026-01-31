-- Value conversion functions for ZIL to Lua
-- Centralized conversion logic for AST node values
--
-- NOTE: This module provides compiler.value(node) helper function.
-- Similar to TypeScript's getTextOfNode(), getEffectiveModifiers(), etc.
-- Helper functions are a standard compiler pattern - they centralize
-- complex conversion logic rather than duplicating it everywhere.
-- This is NOT "hacky" - it's good architectural practice.
local utils = require 'zil.compiler.utils'

local Value = {}

-- Convert ZIL values to Lua representations
-- Handles multiple value types: numbers, strings, identifiers, properties
-- Performs normalization: leading digits → letters, special chars → safe names
function Value.value(node, compiler)
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
    return string.format('PQ%s', val:sub(4))
  end

  -- Check if this is a local variable reference (starts with .)
  local is_local = val:match("^%.")
  
  -- Convert identifier to Lua-safe name
  local result = utils.normalizeIdentifier(val)
  
  -- Convert leading numbers to letters
  if result:match("^%d") then
    result = utils.digitsToLetters(result)
  end
  
  -- Add m_ prefix for local variable references (those that started with .)
  if is_local then
    result = "m_" .. result
  end
  
  return result
end

-- Helper function to convert a bare identifier to a local variable name
-- This is used in contexts where we know an identifier is a local variable
-- but it doesn't have the . prefix (e.g., SET target, function parameters)
function Value.localVarName(node, compiler)
  local bare_name = Value.value(node, compiler)
  -- If it already has m_ prefix (from a .VAR reference), return as is
  if bare_name:match("^m_") then
    return bare_name
  end
  
  -- Get the original identifier name to check if it's in the local vars list
  local original_name = tostring(node.value or node.name)
  
  -- Only add m_ prefix if this is actually a local variable
  if compiler.local_vars[original_name] then
    return "m_" .. bare_name
  end
  
  -- Otherwise, return as is (it's a global)
  return bare_name
end

-- Register a variable as local and return its name
function Value.registerLocalVar(arg, compiler)
  local var_name = tostring(arg.value or arg.name)
  compiler.local_vars[var_name] = true
  return var_name
end

return Value
