-- Code Emitter for ZIL Compiler
-- Inspired by TypeScript's emitter architecture
-- Separates code generation from AST traversal

local buffer_module = require 'zil.compiler.buffer'

local Emitter = {}

-- Create a new emitter instance
function Emitter.new(compiler)
  local emitter = {
    compiler = compiler,
    output = buffer_module.new(compiler),
    indent_level = 0,
    options = {
      source_maps = true,
      preserve_newlines = true,
      indent_string = "  "
    }
  }
  
  -- Write text to output
  function emitter.write(fmt, ...)
    emitter.output.write(fmt, ...)
  end
  
  -- Write line to output
  function emitter.writeln(fmt, ...)
    emitter.output.writeln(fmt, ...)
  end
  
  -- Write indentation
  function emitter.indent()
    emitter.output.indent(emitter.indent_level)
  end
  
  -- Increase indentation level
  function emitter.increase_indent()
    emitter.indent_level = emitter.indent_level + 1
  end
  
  -- Decrease indentation level
  function emitter.decrease_indent()
    if emitter.indent_level > 0 then
      emitter.indent_level = emitter.indent_level - 1
    end
  end
  
  -- Write with current indentation
  function emitter.write_indented(fmt, ...)
    emitter.indent()
    emitter.write(fmt, ...)
  end
  
  -- Write line with current indentation
  function emitter.writeln_indented(fmt, ...)
    emitter.indent()
    emitter.writeln(fmt, ...)
  end
  
  -- Emit a block with automatic indentation
  function emitter.emit_block(fn)
    emitter.increase_indent()
    fn()
    emitter.decrease_indent()
  end
  
  -- Emit a function definition
  function emitter.emit_function(name, params, body_fn)
    emitter.write("function %s(", name)
    if params and #params > 0 then
      emitter.write(table.concat(params, ", "))
    end
    emitter.writeln(")")
    
    emitter.emit_block(body_fn)
    emitter.writeln("end")
  end
  
  -- Emit a local function definition
  function emitter.emit_local_function(name, params, body_fn)
    emitter.write("local function %s(", name)
    if params and #params > 0 then
      emitter.write(table.concat(params, ", "))
    end
    emitter.writeln(")")
    
    emitter.emit_block(body_fn)
    emitter.writeln("end")
  end
  
  -- Emit a table constructor
  function emitter.emit_table(entries_fn)
    emitter.writeln("{")
    emitter.emit_block(entries_fn)
    emitter.write("}")
  end
  
  -- Emit a function call
  function emitter.emit_call(name, args_fn)
    emitter.write("%s(", name)
    if args_fn then
      args_fn()
    end
    emitter.write(")")
  end
  
  -- Emit an if statement
  function emitter.emit_if(condition, then_fn, else_fn)
    emitter.write("if ")
    condition()
    emitter.writeln(" then")
    
    emitter.emit_block(then_fn)
    
    if else_fn then
      emitter.writeln("else")
      emitter.emit_block(else_fn)
    end
    
    emitter.writeln("end")
  end
  
  -- Emit a return statement
  function emitter.emit_return(value_fn)
    emitter.write("return ")
    if value_fn then
      value_fn()
    end
  end
  
  -- Emit a local variable declaration
  function emitter.emit_local(name, value_fn)
    emitter.write("local %s", name)
    if value_fn then
      emitter.write(" = ")
      value_fn()
    end
  end
  
  -- Emit an assignment
  function emitter.emit_assignment(target, value_fn)
    emitter.write("%s = ", target)
    value_fn()
  end
  
  -- Emit a comment
  function emitter.emit_comment(text)
    emitter.write("-- %s", text)
  end
  
  -- Get the generated output
  function emitter.get_output()
    return emitter.output.get()
  end
  
  -- Clear the output buffer
  function emitter.clear()
    emitter.output.clear()
    emitter.indent_level = 0
  end
  
  -- Update source location for source mapping
  function emitter.update_source(source_location)
    if source_location then
      emitter.compiler.current_source = source_location
    end
  end
  
  -- Emit with source location tracking
  function emitter.emit_with_source(node, emit_fn)
    local meta = getmetatable(node)
    if meta and meta.source then
      emitter.update_source(meta.source)
    end
    emit_fn()
  end
  
  return emitter
end

-- Factory: Create emitters for declarations and body
function Emitter.create_pair(compiler)
  return {
    declarations = Emitter.new(compiler),
    body = Emitter.new(compiler)
  }
end

return Emitter
