-- ZIL to Lua Compiler
-- Main module that coordinates all compiler components

local buffer_module = require 'zil.compiler.buffer'
local utils = require 'zil.compiler.utils'
local value_module = require 'zil.compiler.value'
local forms_module = require 'zil.compiler.forms'
local toplevel = require 'zil.compiler.toplevel'
local print_node_module = require 'zil.compiler.print_node'

local Compiler = {
  flags = {},
  current_flag = 1,
  current_decl = nil,
  current_verbs = {},
  prog = 1,
  current_lua_filename = nil,  -- Track the current output Lua filename
  current_source = nil,          -- Track the current ZIL source location
  local_vars = {}                -- Track local variables in current scope
}

-- AST node iteration helper
function Compiler.iter_children(node, skip)
  skip = skip or 0
  local i = skip + 1
  return function()
    if node[i] then
      local child = node[i]
      i = i + 1
      return child
    end
  end
end

-- Bind value conversion functions to compiler
Compiler.value = function(node)
  return value_module.value(node, Compiler)
end

Compiler.local_var_name = function(node)
  return value_module.local_var_name(node, Compiler)
end

Compiler.register_local_var = function(arg)
  return value_module.register_local_var(arg, Compiler)
end

-- Bind toplevel functions to compiler
Compiler.print_syntax_object = function(buf, nodes, start_idx, field_name)
  return toplevel.print_syntax_object(buf, nodes, start_idx, field_name, Compiler)
end

-- Main compilation entry point
-- lua_filename: the name of the Lua file being generated (for source mapping) - optional
function Compiler.compile(ast, lua_filename)
  local decl = buffer_module.new(Compiler)
  local body = buffer_module.new(Compiler)

  -- Reset compiler state for this compilation
  Compiler.current_decl = decl
  Compiler.current_lua_filename = lua_filename or "unknown.lua"
  Compiler.current_source = nil
  
  -- Create form handlers and print_node function
  -- We need to resolve the circular dependency between forms and print_node
  local form_handlers = {}
  local print_node
  
  -- Create print_node with access to form_handlers (which will be populated below)
  print_node = print_node_module.create_print_node(Compiler, form_handlers)
  
  -- Now populate form_handlers with the actual handlers (which can use print_node)
  local handlers = forms_module.create_handlers(Compiler, print_node)
  for k, v in pairs(handlers) do
    form_handlers[k] = v
  end
  
  for i = 1, #ast do
    local node = ast[i]
    
    if node.type == "expr" then
      local name = node.name or ""
      
      -- Skip forms that don't generate output
      if name == "GDECL" or name == "PROG" then
        -- Skip
      -- Direct statements (print to body directly)
      elseif toplevel.DIRECT_STATEMENTS[name] then
        print_node(body, node, 0, false)
      -- Forms with specialized compilers
      elseif utils.safeget(node[1], 'value') then
        local compiler_fn = toplevel.TOP_LEVEL_COMPILERS[name]
        if compiler_fn then
          compiler_fn(decl, body, node, Compiler, print_node)
        else
          io.stderr:write(string.format("Unknown top-level form: %s on line %d\n", name, utils.get_source_line(node)))
        end
      else
        io.stderr:write(string.format("Expected type in <%s> on line %d\n", name, utils.get_source_line(node)))
      end
    end
  end
  
  return {
    declarations = decl.get(),
    body = body.get(),
    combined = decl.get() .. "\n" .. body.get()
  }
end

return Compiler
