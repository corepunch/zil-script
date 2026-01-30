-- Symbol Table and Semantic Checker for ZIL Compiler
-- Inspired by TypeScript's binder and checker
-- Tracks symbols, scopes, and performs semantic validation

local diagnostics_module = require 'zil.compiler.diagnostics'
local visitor_module = require 'zil.compiler.visitor'

local Checker = {}

-- Symbol kinds
Checker.SymbolKind = {
  ROUTINE = "routine",
  GLOBAL = "global",
  CONSTANT = "constant",
  LOCAL = "local",
  PARAMETER = "parameter",
  OBJECT = "object",
  ROOM = "room"
}

-- Create a new symbol
local function create_symbol(name, kind, declaration, scope)
  return {
    name = name,
    kind = kind,
    declaration = declaration,
    scope = scope,
    references = {}
  }
end

-- Create a new scope
local function create_scope(parent, kind)
  return {
    parent = parent,
    kind = kind or "block",
    symbols = {},
    children = {}
  }
end

-- Create a new checker instance
function Checker.new(diagnostics)
  diagnostics = diagnostics or diagnostics_module.new()
  
  local checker = {
    diagnostics = diagnostics,
    global_scope = create_scope(nil, "global"),
    current_scope = nil,
    symbols = {}  -- All symbols indexed by name
  }
  
  -- Initialize current scope to global
  checker.current_scope = checker.global_scope
  
  -- Enter a new scope
  function checker.enter_scope(kind)
    local new_scope = create_scope(checker.current_scope, kind)
    table.insert(checker.current_scope.children, new_scope)
    checker.current_scope = new_scope
    return new_scope
  end
  
  -- Exit current scope
  function checker.exit_scope()
    if checker.current_scope.parent then
      checker.current_scope = checker.current_scope.parent
    end
  end
  
  -- Declare a symbol in the current scope
  function checker.declare_symbol(name, kind, declaration)
    -- Check for duplicate in current scope
    if checker.current_scope.symbols[name] then
      local existing = checker.current_scope.symbols[name]
      checker.diagnostics.error(
        diagnostics_module.Code.DUPLICATE_DECLARATION,
        string.format("Duplicate declaration of '%s'", name),
        diagnostics_module.get_source_location(declaration),
        declaration
      )
      return existing
    end
    
    local symbol = create_symbol(name, kind, declaration, checker.current_scope)
    checker.current_scope.symbols[name] = symbol
    
    -- Add to global symbol table for lookup
    if not checker.symbols[name] then
      checker.symbols[name] = {}
    end
    table.insert(checker.symbols[name], symbol)
    
    return symbol
  end
  
  -- Look up a symbol by name
  function checker.lookup_symbol(name, current_scope)
    current_scope = current_scope or checker.current_scope
    
    -- Search up the scope chain
    local scope = current_scope
    while scope do
      local symbol = scope.symbols[name]
      if symbol then
        return symbol
      end
      scope = scope.parent
    end
    
    return nil
  end
  
  -- Add a reference to a symbol
  function checker.add_reference(symbol, node)
    if symbol then
      table.insert(symbol.references, node)
    end
  end
  
  -- Check if a symbol is defined
  function checker.check_defined(name, node)
    local symbol = checker.lookup_symbol(name)
    if not symbol then
      checker.diagnostics.error(
        diagnostics_module.Code.UNDEFINED_VARIABLE,
        string.format("Undefined identifier '%s'", name),
        diagnostics_module.get_source_location(node),
        node
      )
      return false
    end
    
    checker.add_reference(symbol, node)
    return true
  end
  
  -- Get all symbols in current scope
  function checker.get_current_symbols()
    local result = {}
    for name, symbol in pairs(checker.current_scope.symbols) do
      table.insert(result, symbol)
    end
    return result
  end
  
  -- Get all symbols globally
  function checker.get_all_symbols()
    local result = {}
    for name, symbol_list in pairs(checker.symbols) do
      for _, symbol in ipairs(symbol_list) do
        table.insert(result, symbol)
      end
    end
    return result
  end
  
  -- Check the entire AST
  function checker.check_ast(ast)
    -- Create visitor to build symbol table
    local handlers = {}
    
    -- Handle ROUTINE declarations
    handlers["ROUTINE"] = function(node, visitor, context)
      if node[1] and node[1].value then
        local name = node[1].value
        checker.declare_symbol(name, Checker.SymbolKind.ROUTINE, node)
        
        -- Enter function scope to check parameters and body
        checker.enter_scope("function")
        
        -- Process parameter list
        local params_node = node[2]
        if params_node and params_node.type == "list" then
          for i = 1, #params_node do
            local param = params_node[i]
            if param.type == "ident" then
              checker.declare_symbol(param.value, Checker.SymbolKind.PARAMETER, param)
            elseif param.type == "list" and param[1] and param[1].type == "ident" then
              checker.declare_symbol(param[1].value, Checker.SymbolKind.PARAMETER, param)
            end
          end
        end
        
        -- Visit body
        for i = 3, #node do
          visitor.visit_node(node[i], context)
        end
        
        checker.exit_scope()
      end
    end
    
    -- Handle GLOBAL declarations
    handlers["GLOBAL"] = function(node)
      if node[1] and node[1].value then
        checker.declare_symbol(node[1].value, Checker.SymbolKind.GLOBAL, node)
      end
    end
    
    -- Handle CONSTANT declarations
    handlers["CONSTANT"] = function(node)
      if node[1] and node[1].value then
        checker.declare_symbol(node[1].value, Checker.SymbolKind.CONSTANT, node)
      end
    end
    
    -- Handle OBJECT/ROOM declarations
    handlers["OBJECT"] = function(node)
      if node[1] and node[1].value then
        checker.declare_symbol(node[1].value, Checker.SymbolKind.OBJECT, node)
      end
    end
    
    handlers["ROOM"] = function(node)
      if node[1] and node[1].value then
        checker.declare_symbol(node[1].value, Checker.SymbolKind.ROOM, node)
      end
    end
    
    -- Handle identifier references
    handlers["ident"] = function(node)
      if node.value then
        -- Check if defined (this will record the reference)
        checker.check_defined(node.value, node)
      end
    end
    
    -- Create and run visitor
    local ast_visitor = visitor_module.new(handlers)
    for i = 1, #ast do
      ast_visitor.walk(ast[i], {})
    end
    
    return checker.diagnostics
  end
  
  return checker
end

return Checker
