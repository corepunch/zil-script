local evaluate = require "zil-script.evaluate"

local ZIL = {}

-- Source tracking metadata
local function with_source(tbl, line, col, filename)
  return setmetatable(tbl, {
    __fennelview = function(t) 
      return string.format("<%s:%d:%d>", filename or "?", line or 0, col or 0)
    end,
    source = {line = line, col = col, filename = filename}
  })
end

-- Node constructors
local function List(source)
  return with_source({type = "list"}, source.line, source.col, source.file)
end

local function Expr(name, source)
  return with_source({type = "expr", name = name}, source.line, source.col, source.file)
end

local function Symbol(value, source)
  return with_source({type = "symbol", value = value}, source.line, source.col, source.file)
end

local function String(value, source)
  return with_source({type = "string", value = value}, source.line, source.col, source.file)
end

local function Number(value, source)
  return with_source({type = "number", value = tonumber(value)}, source.line, source.col, source.file)
end

local function Ident(value, source)
  return with_source({type = "ident", value = value}, source.line, source.col, source.file)
end

-- String stream
local function string_stream(str, filename)
  local line, col = 1, 0
  local pos = 1
  local len = #str
  
  local function getchar()
    if pos > len then return nil end
    local c = str:sub(pos, pos)
    pos = pos + 1
    col = col + 1
    if c == '\n' then
      line = line + 1
      col = 0
    end
    return c
  end
  
  local function ungetchar()
    if pos > 1 then
      pos = pos - 1
      local c = str:sub(pos, pos)
      col = col - 1
      if c == '\n' then line = line - 1 end
    end
  end
  
  local function peek(offset)
    offset = offset or 0
    return str:sub(pos + offset, pos + offset)
  end
  
  local function source()
    return {line = line, col = col, file = filename}
  end
  
  return {
    getchar = getchar,
    ungetchar = ungetchar,
    peek = peek,
    source = source,
    at_end = function() return pos > len end
  }
end

-- Parser implementation
function ZIL.parser(stream_or_string, filename)
  local stream = type(stream_or_string) == "string" 
    and string_stream(stream_or_string, filename)
    or stream_or_string
  
  -- Helper functions
  local function skip_whitespace()
    while not stream.at_end() and stream.peek():match("%s") do
      stream.getchar()
    end
  end
  
  local function read_while(predicate)
    local chars = {}
    while not stream.at_end() and predicate(stream.peek()) do
      table.insert(chars, stream.getchar())
    end
    return table.concat(chars)
  end
  
  local function classify_atom(text, source)
    if not text or text == "" then return Ident("", source) end
    
    local first = text:sub(1, 1)
    if first:match("[,?.]") then
      return Symbol(text, source)
    elseif text:match("^%-?%d+$") then
      return Number(text, source)
    else
      return Ident(text, source)
    end
  end
  
  -- Forward declaration
  local parse_form
  
  -- Special form parsers (extracted from the giant switch)
  local parsers = {}
  
  -- Comments: ; and #
  parsers[";"] = function(src)
    stream.getchar()
    parse_form() -- skip and continue
    return false
  end
  
  parsers["#"] = function(src)
    stream.getchar()
    parse_form()
    parse_form()
    return false
  end
  
  -- Conditional compilation: %COND
  parsers["%"] = function(src)
    stream.getchar()
    return evaluate(parse_form())
  end
  
  -- Placeholder/quote: '
  parsers["'"] = function(src)
    stream.getchar()
    local form = parse_form()
    local placeholder = List(src)
    placeholder.type = "placeholder"
    if form then table.insert(placeholder, form) end
    return placeholder
  end
  
  -- Escape sequences: \f and \
  parsers["\f"] = function(src)
    stream.getchar()
    return parse_form()
  end
  
  parsers["\\"] = function(src)
    stream.getchar()
    local next_c = stream.peek()
    
    if next_c == '\f' then
      stream.getchar()
      return parse_form()
    end
    
    if next_c and next_c:match("[.,\"#]") then
      stream.getchar()
      return parse_form()
    end
    
    stream.ungetchar()
    return nil -- Continue to atom parsing
  end
  
  -- Angle bracket expressions: <...>
  parsers["<"] = function(src)
    stream.getchar()
    local first = nil
    local items = {}
    
    while true do
      skip_whitespace()
      if stream.at_end() or stream.peek() == '>' then break end
      
      local form = parse_form()
      if form then
        if not first then
          first = form
        else
          table.insert(items, form)
        end
      end
    end
    
    if stream.peek() == '>' then stream.getchar() end
    
    if first then
      local expr = Expr(first.value or "", src)
      for _, item in ipairs(items) do
        table.insert(expr, item)
      end
      return expr
    end
    return Expr("", src)
  end
  
  -- S-expressions: (...)
  parsers["("] = function(src)
    stream.getchar()
    local list = List(src)
    
    while true do
      skip_whitespace()
      if stream.at_end() or stream.peek() == ')' then break end
      
      local form = parse_form()
      if form then table.insert(list, form) end
    end
    
    if stream.peek() == ')' then stream.getchar() end
    return list
  end
  
  -- Error on unmatched closing delimiters
  parsers[">"] = function(src)
    error(("Unexpected '>' at line %d"):format(src.line))
  end
  
  parsers[")"] = function(src)
    error(("Unexpected ')' at line %d"):format(src.line))
  end
  
  -- String literals: "..."
  parsers['"'] = function(src)
    stream.getchar()
    local chars = {}
    
    while not stream.at_end() and stream.peek() ~= '"' do
      local ch = stream.getchar()
      if ch == '\\' then
        local escaped = stream.getchar()
        if escaped then table.insert(chars, escaped) end
      else
        table.insert(chars, ch)
      end
    end
    
    if stream.peek() == '"' then stream.getchar() end
    return String(table.concat(chars), src)
  end
  
  -- Main parsing function
  parse_form = function()
    skip_whitespace()
    if stream.at_end() then return nil end
    
    local c = stream.peek()
    local src = stream.source()
    
    -- Try special form parser
    local parser = parsers[c]
    if parser then
      local result = parser(src)
      if result ~= nil then return result end
      -- If parser returns nil, continue to atom parsing
    end
    
    -- Parse atom (identifier, number, or symbol)
    local atom = read_while(function(ch)
      return not (ch:match("%s") or ch:match("[<>\"();]"))
    end)
    
    return classify_atom(atom, src)
  end
  
  -- Return iterator function
  return function()
    local ok, form = pcall(parse_form)
    if ok and (form or form == false) then
      return true, form
    elseif not ok then
      return false, form -- error message
    end
    return nil -- end of input
  end
end

-- Convenience functions
function ZIL.parse(input, filename)
  local root = List({line = 1, col = 0, file = filename})
  local parse_iter = ZIL.parser(input, filename)
  
  for ok, form in parse_iter do
    if ok and form then
      table.insert(root, form)
    elseif not ok then
      error(form)
    end
  end
  
  return root
end

function ZIL.parse_file(filename)
  local file = io.open(filename, "r")
  if not file then
    return nil, "Cannot open file: " .. filename
  end
  
  local content = file:read("*all")
  file:close()
  
  return ZIL.parse(content, filename)
end

-- Pretty printer
function ZIL.view(node, indent)
  indent = indent or 0
  local prefix = string.rep("  ", indent)
  local lines = {}
  
  if node.type == "expr" then
    table.insert(lines, prefix .. "<" .. (node.name or ""))
    for i = 1, #node do
      table.insert(lines, ZIL.view(node[i], indent + 1))
    end
    table.insert(lines, prefix .. ">")
  elseif node.type == "list" or node.type == "placeholder" then
    local marker = node.type == "placeholder" and "'" or ""
    table.insert(lines, prefix .. marker .. "(")
    for i = 1, #node do
      table.insert(lines, ZIL.view(node[i], indent + 1))
    end
    table.insert(lines, prefix .. ")")
  else
    local type_abbrev = {
      string = "STR",
      ident = "ID",
      number = "NUM",
      symbol = "SYM"
    }
    table.insert(lines, string.format("%s[%s] %s", 
      prefix, 
      type_abbrev[node.type] or node.type,
      tostring(node.value or "")))
  end
  
  return table.concat(lines, "\n")
end

-- Export API
ZIL.list = List
ZIL.expr = Expr
ZIL.sym = Symbol
ZIL.str = String
ZIL.num = Number
ZIL.ident = Ident
ZIL.string_stream = string_stream

return ZIL