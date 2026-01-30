-- Diagnostic System for ZIL Compiler
-- Inspired by TypeScript's diagnostic reporting system
-- Provides structured error collection, categorization, and reporting

local Diagnostics = {}

-- Diagnostic categories (similar to TypeScript's DiagnosticCategory)
Diagnostics.Category = {
  ERROR = "error",
  WARNING = "warning",
  INFO = "info",
  MESSAGE = "message"
}

-- Diagnostic codes for different error types
Diagnostics.Code = {
  UNKNOWN_FORM = 1001,
  EXPECTED_TYPE = 1002,
  INVALID_SYNTAX = 1003,
  UNDEFINED_VARIABLE = 1004,
  UNDEFINED_FUNCTION = 1005,
  INVALID_ARGUMENT_COUNT = 1006,
  TYPE_MISMATCH = 1007,
  MISSING_FIELD = 1008,
  DUPLICATE_DECLARATION = 1009,
  INVALID_IDENTIFIER = 1010,
}

-- Create a new diagnostic collection
function Diagnostics.new()
  local diagnostics = {}
  local errors = {}
  local warnings = {}
  local infos = {}
  
  local collection = {
    diagnostics = diagnostics,
    errors = errors,
    warnings = warnings,
    infos = infos
  }
  
  -- Add a diagnostic
  function collection.add(category, code, message, source_location, node)
    local diagnostic = {
      category = category,
      code = code,
      message = message,
      file = source_location and source_location.filename or "unknown",
      line = source_location and source_location.line or 0,
      col = source_location and source_location.col or 0,
      node = node
    }
    
    table.insert(diagnostics, diagnostic)
    
    if category == Diagnostics.Category.ERROR then
      table.insert(errors, diagnostic)
    elseif category == Diagnostics.Category.WARNING then
      table.insert(warnings, diagnostic)
    elseif category == Diagnostics.Category.INFO then
      table.insert(infos, diagnostic)
    end
    
    return diagnostic
  end
  
  -- Convenience methods for adding specific diagnostic types
  function collection.error(code, message, source_location, node)
    return collection.add(Diagnostics.Category.ERROR, code, message, source_location, node)
  end
  
  function collection.warning(code, message, source_location, node)
    return collection.add(Diagnostics.Category.WARNING, code, message, source_location, node)
  end
  
  function collection.info(code, message, source_location, node)
    return collection.add(Diagnostics.Category.INFO, code, message, source_location, node)
  end
  
  -- Check if there are any errors
  function collection.has_errors()
    return #errors > 0
  end
  
  -- Get count of diagnostics by category
  function collection.count()
    return {
      total = #diagnostics,
      errors = #errors,
      warnings = #warnings,
      infos = #infos
    }
  end
  
  -- Clear all diagnostics
  function collection.clear()
    -- Clear tables in place to maintain references
    for k in pairs(diagnostics) do diagnostics[k] = nil end
    for k in pairs(errors) do errors[k] = nil end
    for k in pairs(warnings) do warnings[k] = nil end
    for k in pairs(infos) do infos[k] = nil end
  end
  
  -- Format a single diagnostic for display
  function collection.format_diagnostic(diagnostic)
    local category_str = diagnostic.category:upper()
    local location_str = string.format("%s:%d:%d", 
      diagnostic.file, diagnostic.line, diagnostic.col)
    
    return string.format("%s [ZIL%04d] %s: %s",
      location_str, diagnostic.code, category_str, diagnostic.message)
  end
  
  -- Format all diagnostics for display
  function collection.format_all(filter_category)
    local lines = {}
    
    for _, diagnostic in ipairs(diagnostics) do
      if not filter_category or diagnostic.category == filter_category then
        table.insert(lines, collection.format_diagnostic(diagnostic))
      end
    end
    
    return table.concat(lines, "\n")
  end
  
  -- Report all diagnostics to stderr
  function collection.report(filter_category)
    local formatted = collection.format_all(filter_category)
    if #formatted > 0 then
      io.stderr:write(formatted .. "\n")
    end
  end
  
  -- Get summary statistics
  function collection.summary()
    local counts = collection.count()
    local parts = {}
    
    if counts.errors > 0 then
      table.insert(parts, string.format("%d error%s", 
        counts.errors, counts.errors == 1 and "" or "s"))
    end
    
    if counts.warnings > 0 then
      table.insert(parts, string.format("%d warning%s", 
        counts.warnings, counts.warnings == 1 and "" or "s"))
    end
    
    if counts.infos > 0 then
      table.insert(parts, string.format("%d message%s", 
        counts.infos, counts.infos == 1 and "" or "s"))
    end
    
    if #parts == 0 then
      return "No diagnostics"
    end
    
    return table.concat(parts, ", ")
  end
  
  return collection
end

-- Helper: Extract source location from a node
function Diagnostics.get_source_location(node)
  if not node then return nil end
  
  local meta = getmetatable(node)
  if meta and meta.source then
    return meta.source
  end
  
  return nil
end

-- Helper: Create a diagnostic from a node
function Diagnostics.from_node(category, code, message, node)
  local location = Diagnostics.get_source_location(node)
  local collection = Diagnostics.new()
  collection.add(category, code, message, location, node)
  return collection
end

return Diagnostics
