-- AST Visitor Pattern
-- Inspired by TypeScript's forEachChild and visitor pattern
-- Provides a clean, extensible way to traverse and transform the AST

local Visitor = {}

-- Create a new visitor with optional handlers
-- handlers: table of node handlers keyed by node type or name
-- default_handler: optional function to call for unhandled nodes
function Visitor.new(handlers, default_handler)
  handlers = handlers or {}
  
  local visitor = {
    handlers = handlers,
    default_handler = default_handler
  }
  
  -- Visit a single node
  function visitor.visit_node(node, context)
    if not node then return nil end
    
    -- Update context with source information if available
    local meta = getmetatable(node)
    if meta and meta.source and context then
      context.current_source = meta.source
    end
    
    -- Try type-specific handler first
    local handler = handlers[node.type]
    if handler then
      return handler(node, visitor, context)
    end
    
    -- For expressions, try name-specific handler
    if node.type == "expr" and node.name then
      handler = handlers[node.name]
      if handler then
        return handler(node, visitor, context)
      end
    end
    
    -- Fall back to default handler
    if default_handler then
      return default_handler(node, visitor, context)
    end
    
    return nil
  end
  
  -- Visit all children of a node
  function visitor.visit_children(node, context, skip)
    skip = skip or 0
    local results = {}
    
    if not node then return results end
    
    for i = skip + 1, #node do
      local child = node[i]
      if child then
        local result = visitor.visit_node(child, context)
        if result ~= nil then
          table.insert(results, result)
        end
      end
    end
    
    return results
  end
  
  -- Visit each child and call a function with the result
  function visitor.for_each_child(node, fn, context, skip)
    skip = skip or 0
    
    if not node then return end
    
    for i = skip + 1, #node do
      local child = node[i]
      if child then
        local result = visitor.visit_node(child, context)
        fn(child, result, i)
      end
    end
  end
  
  -- Transform a node by visiting it and all its children
  -- Returns a new node or the original node
  function visitor.transform(node, context)
    if not node then return nil end
    
    local result = visitor.visit_node(node, context)
    
    -- If handler returned a value, use it; otherwise keep original
    if result ~= nil then
      return result
    end
    
    return node
  end
  
  -- Walk the entire tree depth-first, calling visitor for each node
  function visitor.walk(node, context)
    if not node then return end
    
    visitor.visit_node(node, context)
    
    -- Recursively walk children
    if type(node) == "table" then
      for i = 1, #node do
        if type(node[i]) == "table" then
          visitor.walk(node[i], context)
        end
      end
    end
  end
  
  return visitor
end

-- Utility: Create a visitor that collects nodes matching a predicate
function Visitor.collector(predicate)
  local collected = {}
  
  local function collect_handler(node)
    if predicate(node) then
      table.insert(collected, node)
    end
  end
  
  local visitor = Visitor.new({}, collect_handler)
  
  visitor.get_collected = function()
    return collected
  end
  
  visitor.clear = function()
    collected = {}
  end
  
  return visitor
end

-- Utility: Create a visitor that counts nodes by type
function Visitor.counter()
  local counts = {}
  
  local function count_handler(node)
    local key = node.type
    if node.type == "expr" and node.name then
      key = node.name
    end
    counts[key] = (counts[key] or 0) + 1
  end
  
  local visitor = Visitor.new({}, count_handler)
  
  visitor.get_counts = function()
    return counts
  end
  
  visitor.clear = function()
    counts = {}
  end
  
  return visitor
end

return Visitor
