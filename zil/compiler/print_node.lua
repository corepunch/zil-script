-- AST node code generation using visitor pattern principles
-- This module provides the print_node function that generates Lua code from ZIL AST
-- It follows visitor pattern principles by delegating to specialized handlers
--
-- Architecture Note: TypeScript uses an external emitter function (emitNode)
-- that walks the AST, rather than having nodes emit themselves.
-- We follow the same pattern:
-- - AST nodes are pure data (no emit methods)
-- - External printNode function traverses and emits code
-- - Separation of concerns: data vs behavior
-- - More flexible and testable than self-emitting nodes
--
-- Node Access Pattern: We use direct property access like node[i].value
-- This matches TypeScript's approach: node.members[0].text
-- Direct access is clear, performant, and standard in both Lua and TypeScript
local utils = require 'zil.compiler.utils'

local PrintNode = {}

-- Expand a macro call by substituting parameters
local function expandMacro(call_node, macro, compiler)
  -- Build a parameter substitution map
  local param_map = {}
  local params = macro.params
  
  if not params or params.type ~= "list" then
    return nil  -- Invalid macro definition
  end
  
  -- Match call arguments to macro parameters
  local call_args = {}
  for i = 1, #call_node do
    call_args[i] = call_node[i]
  end
  
  local arg_idx = 1
  local i = 1
  while i <= #params do
    local param = params[i]
    local param_name = nil
    local is_rest = false
    
    -- Check if next param is a string marker (like "ARGS" or "OPTIONAL")
    if param.type == "string" and i < #params then
      -- String marker followed by the actual parameter name
      local next_param = params[i + 1]
      if next_param.type == "ident" then
        -- The ident after the string is the rest parameter
        param_name = next_param.value
        is_rest = true
        i = i + 1  -- Skip the string marker
      end
    elseif param.type == "placeholder" and param[1] then
      -- Quoted parameter like 'OBJ
      param_name = param[1].value
    elseif param.type == "ident" then
      -- Normal parameter like BITS (without a string marker before it)
      param_name = param.value
    end
    
    if param_name then
      if is_rest then
        -- Collect all remaining args as a list
        local rest_list = {type = "list"}
        while arg_idx <= #call_args do
          table.insert(rest_list, call_args[arg_idx])
          arg_idx = arg_idx + 1
        end
        param_map[param_name] = rest_list
      elseif arg_idx <= #call_args then
        -- Single parameter
        param_map[param_name] = call_args[arg_idx]
        arg_idx = arg_idx + 1
      end
    end
    
    i = i + 1
  end
  
  -- Substitute parameters in the macro body
  local function substitute(node)
    if not node then return node end
    
    if node.type == "symbol" or node.type == "ident" then
      -- Check if this is a parameter reference (starts with .)
      local name = node.value
      if name and name:match("^%.") then
        local param_name = name:sub(2)  -- Remove the dot
        if param_map[param_name] then
          -- Return the actual argument, not a reference
          return param_map[param_name]
        end
      end
      return node
    elseif node.type == "expr" then
      -- Recursively substitute in expressions
      local new_node = {type = "expr", name = node.name}
      for i = 1, #node do
        local subst = substitute(node[i])
        -- If substitution returns a list (rest params), expand it inline
        if subst and subst.type == "list" then
          for j = 1, #subst do
            table.insert(new_node, subst[j])
          end
        else
          table.insert(new_node, subst)
        end
      end
      -- Preserve metadata
      setmetatable(new_node, getmetatable(node))
      return new_node
    elseif node.type == "list" then
      -- Recursively substitute in lists
      local new_node = {type = "list"}
      for i = 1, #node do
        new_node[i] = substitute(node[i])
      end
      setmetatable(new_node, getmetatable(node))
      return new_node
    end
    
    return node
  end
  
  -- Expand the macro body with substitutions
  return substitute(macro.body)
end

-- Main code generation function
-- Implements visitor pattern by traversing AST and delegating to specialized handlers
function PrintNode.createPrintNode(compiler, form_handlers)
  local function printNode(buf, node, indent)
    indent = indent or 0
    
    -- Track source location for diagnostics and source mapping
    local meta = getmetatable(node)
    if meta and meta.source then
      compiler.current_source = meta.source
    end

    if node.type == "expr" then
      if #node.name == 0 then buf.write("nil")  return true  end
      
      -- Check if this is a macro call that needs expansion
      local macro = compiler.macros[node.name]
      if macro then
        -- Expand the macro by substituting parameters and emitting the body
        local expanded = expandMacro(node, macro, compiler)
        if expanded then
          printNode(buf, expanded, indent)
          return true
        end
      end
      
      -- Visitor pattern: check for specialized handler
      local handler = form_handlers[node.name]
      if handler then
        -- Delegate to specialized handler (visitor callback)
        handler(buf, node, indent)
      else
        -- Default handler for generic function calls
        if indent == 1 then buf.indent(indent) end
        if node.name == 'VERB?' then table.insert(compiler.current_verbs, node[1].value) end
        buf.write("%s(", utils.normalizeFunctionName(node.name))
        
        -- Visit children (visitor pattern)
        for i = 1, #node do
          if utils.isCond(node[i]) then
            buf.write("APPLY(function()")
            printNode(buf, node[i], indent + 1, true)
            buf.write(" end) or __tmp")
          elseif node.name == 'VERB?' then
            buf.write("VQ%s", compiler.value(node[i]))
          else
            printNode(buf, node[i], indent + 1, false)
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
  
  return printNode
end

return PrintNode
