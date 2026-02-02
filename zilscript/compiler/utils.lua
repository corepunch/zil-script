-- Utility functions for the ZIL compiler

local Utils = {}

-- Safe node attribute getter
function Utils.safeget(node, attr)
  return node and node[attr] or nil
end

-- Convert leading digits to letters (0-9 -> a-j)
function Utils.digitsToLetters(str)
  return str:gsub("^(%d+)", function(digits)
    return digits:gsub("%d", function(d)
      return string.char(string.byte('a') + tonumber(d))
    end)
  end)
end

-- Normalize identifier to Lua-safe name
function Utils.normalizeIdentifier(str)
  return str
    :gsub("^[,.]+", "")        -- Remove leading commas/dots
    :gsub("[,.]", "")          -- Remove internal commas/dots
    :gsub("%-", "_")           -- Replace - with _
    :gsub("%?", "Q")           -- Question mark to Q
    :gsub("\\", "/")           -- Backslash to forward slash
end

-- Convert ZIL function name to Lua function name
function Utils.normalizeFunctionName(name)
  local OPERATOR_MAP = {
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
  return OPERATOR_MAP[name] or name:gsub("%-", "_"):gsub("%?", "Q")
end

-- Check if node is a COND expression
function Utils.isCond(n)
  return n.type == "expr" and n.name == "COND"
end

-- Check if node needs a return wrapper
function Utils.needReturn(node)
  local nodes = {COND=true,PROG=true,REPEAT=true,AGAIN=true,RETURN=true,RTRUE=true,RFALSE=true,GLOBAL=true,LET=true}
  return node.value ~= "" and (node.type ~= "expr" or not nodes[node.name])
end

-- Get source line number from AST node
function Utils.getSourceLine(node_or_ast)
  local meta = getmetatable(node_or_ast)
  return meta and meta.source and meta.source.line or 0
end

return Utils
