-- ZIL main module
-- Entry point for the ZIL require system
-- Usage: require "zil" to enable loading .zil files via require()

local base = require "zil.base"

-- Automatically insert the loader when this module is required
base.insert_loader()

-- Return the base module with all its functionality
return base
