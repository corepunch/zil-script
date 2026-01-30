-- ZIL to Lua Compiler
-- Main module that coordinates all compiler components
-- Uses TypeScript-inspired architecture with diagnostics and optional semantic checking

local buffer_module = require 'zil.compiler.buffer'
local utils = require 'zil.compiler.utils'
local value_module = require 'zil.compiler.value'
local forms_module = require 'zil.compiler.forms'
local toplevel = require 'zil.compiler.toplevel'
local print_node_module = require 'zil.compiler.print_node'
local diagnostics_module = require 'zil.compiler.diagnostics'
local checker_module = require 'zil.compiler.checker'

local Compiler = {
  flags = {},
  current_flag = 1,
  current_decl = nil,
  current_verbs = {},
  prog = 1,
  current_lua_filename = nil,  -- Track the current output Lua filename
  current_source = nil,          -- Track the current ZIL source location
  local_vars = {},               -- Track local variables in current scope
  diagnostics = nil,             -- Diagnostic collection for error reporting
  enable_semantic_check = false  -- Enable semantic checking with checker module
}

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
-- options: optional table with compilation options:
--   - enable_semantic_check: boolean, enable semantic analysis (default: false)
function Compiler.compile(ast, lua_filename, options)
  options = options or {}
  
  -- Create diagnostic collection for better error reporting
  local diagnostics = diagnostics_module.new()
  
  local decl = buffer_module.new(Compiler)
  local body = buffer_module.new(Compiler)

  -- Reset compiler state for this compilation
  Compiler.current_decl = decl
  Compiler.current_lua_filename = lua_filename or "unknown.lua"
  Compiler.current_source = nil
  Compiler.diagnostics = diagnostics
  Compiler.enable_semantic_check = options.enable_semantic_check or false
  
  -- Optional: Run semantic analysis first
  if Compiler.enable_semantic_check then
    local checker = checker_module.new(diagnostics)
    checker.check_ast(ast)
    
    -- If there are semantic errors, report them but continue compilation
    if diagnostics.has_errors() then
      -- Errors are in diagnostics, no need for stderr output
      -- Users can access via result.diagnostics
    end
  end
  
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
          -- Use diagnostics for error reporting (no stderr)
          local source_loc = diagnostics_module.get_source_location(node)
          diagnostics.error(
            diagnostics_module.Code.UNKNOWN_FORM,
            string.format("Unknown top-level form: %s", name),
            source_loc,
            node
          )
        end
      else
        -- Use diagnostics for error reporting (no stderr)
        local source_loc = diagnostics_module.get_source_location(node)
        diagnostics.error(
          diagnostics_module.Code.EXPECTED_TYPE,
          string.format("Expected type in <%s>", name),
          source_loc,
          node
        )
      end
    end
  end
  
  return {
    declarations = decl.get(),
    body = body.get(),
    combined = decl.get() .. "\n" .. body.get(),
    diagnostics = diagnostics  -- Provide access to diagnostics for advanced usage
  }
end

return Compiler
