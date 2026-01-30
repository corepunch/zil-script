-- AST node printing logic
local utils = require 'zil.compiler.utils'

local PrintNode = {}

-- Main code generation function
-- This is the core of the compiler that traverses the AST and generates Lua code
function PrintNode.create_print_node(compiler, form_handlers)
  local function print_node(buf, node, indent)
    indent = indent or 0
    
    -- Update current source location from node metadata
    local meta = getmetatable(node)
    if meta and meta.source then
      compiler.current_source = meta.source
    end

    if node.type == "expr" then
      if #node.name == 0 then buf.write("nil")  return true  end
      local handler = form_handlers[node.name]
      if handler then
        -- Use specialized handler
        handler(buf, node, indent)
      else
        -- Generic function call
        if indent == 1 then buf.indent(indent) end
        if node.name == 'VERB?' then table.insert(compiler.current_verbs, node[1].value) end
        buf.write("%s(", utils.normalize_function_name(node.name))
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
      -- Atoms: ident, string, number, symbol
      buf.write("%s", compiler.value(node))
    end

    return true
  end
  
  return print_node
end

return PrintNode
