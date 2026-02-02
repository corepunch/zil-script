-- Test for ZIL require system
-- Tests that require "zilscript" enables loading .zil files

local test = require 'tests.test_framework'

test.describe("ZIL Require System", function(t)
  -- Need to save this outside the test for reuse
  local zil, loaders, original_path
  
  t.it("should load zil module", function(assert)
    zil = require "zilscript"
    assert.assert_not_nil(zil, "Failed to load zil module")
    assert.assert_equal(type(zil.insert_loader), "function", "zil.insert_loader should be a function")
    assert.assert_equal(type(zil.zil_loader), "function", "zil.zil_loader should be a function")
  end)
  
  t.it("should create package.zilpath", function(assert)
    assert.assert_not_nil(package.zilpath, "package.zilpath should be created")
  end)
  
  t.it("should insert loader", function(assert)
    loaders = package.loaders or package.searchers
    local found = false
    for _, loader in ipairs(loaders) do
      if loader == zil.zil_loader then
        found = true
        break
      end
    end
    assert.assert_true(found, "zil_loader should be in package.loaders/searchers")
  end)
  
  t.it("should load .zil file via require", function(assert)
    -- First, ensure tests directory is in the path
    original_path = package.path
    package.path = package.path .. ";./zil/?.lua"
    package.zilpath = package.zilpath .. ";./zil/?.zil"
    
    -- Now require should work
    local success, test_module = pcall(require, "test-require")
    if not success then
      error("Failed to load test-require.zil: " .. tostring(test_module))
    end
    assert.assert_true(success, "Should load test-require.zil via require")
  end)
  
  t.it("should convert ZIL to Lua with to_lua", function(assert)
    local simple_code = '<ROUTINE FOO () <RETURN 1>>'
    local lua_code, result = zil.to_lua(simple_code)
    assert.assert_not_nil(lua_code, "to_lua should return code")
    assert.assert_type(lua_code, "string", "to_lua should return a string")
  end)
  
  t.it("should load ZIL with loadstring", function(assert)
    local test_code = '<ROUTINE BAR () <RETURN 99>>'
    local chunk, err = zil.loadstring(test_code)
    assert.assert_not_nil(chunk, "loadstring should return a chunk: " .. tostring(err))
  end)
  
  t.it("should remove loader", function(assert)
    local removed = zil.remove_loader()
    assert.assert_true(removed, "remove_loader should return true")
    local found_after = false
    for _, loader in ipairs(loaders) do
      if loader == zil.zil_loader then
        found_after = true
        break
      end
    end
    assert.assert_false(found_after, "Loader should be removed")
  end)
  
  t.it("should re-insert loader", function(assert)
    local inserted = zil.insert_loader()
    assert.assert_true(inserted, "insert_loader should return true")
    local found_again = false
    for _, loader in ipairs(loaders) do
      if loader == zil.zil_loader then
        found_again = true
        break
      end
    end
    assert.assert_true(found_again, "Loader should be re-inserted")
  end)
  
  t.it("should be idempotent", function(assert)
    local count_before = 0
    for _, loader in ipairs(loaders) do
      if loader == zil.zil_loader then
        count_before = count_before + 1
      end
    end
    require "zilscript"  -- Call again
    local count_after = 0
    for _, loader in ipairs(loaders) do
      if loader == zil.zil_loader then
        count_after = count_after + 1
      end
    end
    assert.assert_equal(count_after, count_before, "Loader should not be inserted multiple times")
    
    -- Clean up
    package.path = original_path
  end)
end)

-- Run tests and exit with appropriate code
local success = test.summary()
os.exit(success and 0 or 1)
