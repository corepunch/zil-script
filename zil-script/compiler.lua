-- ZIL to Lua Compiler
-- This file provides backward compatibility by redirecting to the new modular structure
-- The compiler has been split into separate modules under zil/compiler/
-- See zil/compiler/README.md for details on the new structure

-- Note: This compatibility shim can be removed in a future version
-- For now, it ensures existing code that requires 'zil.compiler' continues to work

return require 'zil-script.compiler.init'
