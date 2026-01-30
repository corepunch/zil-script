-- AST node code generation using visitor pattern principles
-- This module provides the print_node function that generates Lua code from ZIL AST
-- It follows visitor pattern principles by delegating to specialized handlers
local utils = require 'zil.compiler.utils'

local PrintNode = {}

-- Main code generation function
-- Implements visitor pattern by traversing AST and delegating to specialized handlers
function PrintNode.create_print_node(compiler, form_handlers)
  local function print_node(buf, node, indent)
    indent = indent or 0
    
    -- Track source location for diagnostics and source mapping
    local meta = getmetatable(node)
    if meta and meta.source then
      compiler.current_source = meta.source
    end

    if node.type == "expr" then
      if #node.name == 0 then buf.write("nil")  return true  end
      
      -- Visitor pattern: check for specialized handler
      local handler = form_handlers[node.name]
      if handler then
        -- Delegate to specialized handler (visitor callback)
        handler(buf, node, indent)
      else
        -- Default handler for generic function calls
        if indent == 1 then buf.indent(indent) end
        if node.name == 'VERB?' then table.insert(compiler.current_verbs, node[1].value) end
        buf.write("%s(", utils.normalize_function_name(node.name))
        
        -- Visit children (visitor pattern)
        for i = 1, #node do
          if utils.is_cond(node[i]) then
            buf.write("APPLY(function()")
            print_node(buf, node[i], indent + 1, true)
            buf.write(" end) or __tmp")
          elseif node.name == 'VERB?' then
            buf.write("VQ%s", compiler.value(node[i]))
          else
            print_node(buf, node[i], indent + 1, false)
          end
          if i < #node then buf.write(", ") end
        end
        buf.write(")")
      end
      
    else
      -- Leaf nodes: ident, string, number, symbol
      buf.write("%s", compiler.value(node))
    end

    return true
  end
  
  return print_node
end

return PrintNode
