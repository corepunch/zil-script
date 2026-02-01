-- ZIL Preprocessor
-- Handles INSERT-FILE directives by recursively including files

local parser = require 'zil.parser'

local Preprocessor = {}

-- Process INSERT-FILE directives in ZIL code
-- Returns the expanded code with all INSERT-FILE directives resolved
function Preprocessor.process(code, filename, options)
	options = options or {}
	local base_dir = options.base_dir or "."
	local included = options.included or {}  -- Track included files to prevent cycles
	local max_depth = options.max_depth or 50
	local current_depth = options.current_depth or 0
	
	-- Prevent infinite recursion
	if current_depth > max_depth then
		error("Maximum include depth exceeded (" .. max_depth .. ") - possible circular include")
	end
	
	-- Track this file as included
	local abs_filename = filename
	if included[abs_filename] then
		return ""  -- Already included, skip
	end
	included[abs_filename] = true
	
	-- Find the directory of the current file for relative includes
	local current_dir = filename:match("(.*/)")
	if not current_dir then
		current_dir = "./"
	end
	
	-- Process the code line by line, looking for INSERT-FILE directives
	local result = {}
	local in_comment = false
	
	for line in code:gmatch("[^\r\n]*") do
		-- Check for INSERT-FILE directive: <INSERT-FILE "path"> or <INSERT-FILE "../path">
		local insert_path = line:match('<INSERT%-FILE%s+"([^"]+)">')
		
		if insert_path and not in_comment then
			-- Resolve the path relative to the current file's directory
			local full_path
			if insert_path:sub(1, 1) == "/" then
				-- Absolute path
				full_path = insert_path
			elseif insert_path:sub(1, 3) == "../" or insert_path:sub(1, 2) == "./" then
				-- Relative path
				full_path = current_dir .. insert_path
			else
				-- Relative to current directory
				full_path = current_dir .. insert_path
			end
			
			-- Normalize the path (remove ../ and ./)
			full_path = Preprocessor.normalize_path(full_path)
			
			-- Add .zil extension if not present
			if not full_path:match("%.zil$") then
				full_path = full_path .. ".zil"
			end
			
			-- Read the included file
			local included_file = io.open(full_path, "r")
			if not included_file then
				error("INSERT-FILE: Cannot open file: " .. full_path .. " (referenced in " .. filename .. ")")
			end
			local included_content = included_file:read("*a")
			included_file:close()
			
			-- Recursively process the included file
			local processed = Preprocessor.process(included_content, full_path, {
				base_dir = base_dir,
				included = included,
				max_depth = max_depth,
				current_depth = current_depth + 1
			})
			
			-- Add comment to mark the included file
			table.insert(result, ";\"Included from: " .. full_path .. "\"")
			table.insert(result, processed)
			table.insert(result, ";\"End of: " .. full_path .. "\"")
		else
			-- Keep the original line
			table.insert(result, line)
		end
	end
	
	return table.concat(result, "\n")
end

-- Normalize a file path by resolving . and .. components
function Preprocessor.normalize_path(path)
	local parts = {}
	for part in path:gmatch("[^/]+") do
		if part == ".." then
			if #parts > 0 and parts[#parts] ~= ".." then
				table.remove(parts)
			else
				table.insert(parts, part)
			end
		elseif part ~= "." then
			table.insert(parts, part)
		end
	end
	return table.concat(parts, "/")
end

-- Parse a ZIL file with INSERT-FILE preprocessing
function Preprocessor.parse_file(filename, options)
	-- Read the file
	local file = io.open(filename, "r")
	if not file then
		return nil, "Cannot open file: " .. filename
	end
	local content = file:read("*a")
	file:close()
	
	-- Process INSERT-FILE directives
	local processed = Preprocessor.process(content, filename, options)
	
	-- Parse the processed code
	return parser.parse(processed, filename)
end

-- Parse ZIL code with INSERT-FILE preprocessing
function Preprocessor.parse(code, filename, options)
	-- Process INSERT-FILE directives
	local processed = Preprocessor.process(code, filename or "stdin", options)
	
	-- Parse the processed code
	return parser.parse(processed, filename or "stdin")
end

return Preprocessor
