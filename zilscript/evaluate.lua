local ZORK_NUMBER = 1
  
-- Evaluation for conditional compilation
local function get_number(node)
	if not node or node.type ~= "number" then
		if node and node.type == "symbol" and node.value == ",ZORK-NUMBER" then
			return ZORK_NUMBER
		end
		return nil
	end
	return node.value
end

local function evaluate_cond(node, value_node)
	if node.type == "expr" then
		if node.name == "==?" and #node == 2 then
			local a, b = get_number(node[1]), get_number(node[2])
			if a and b and a == b then
				return value_node
			end
		elseif node.name == "OR" then
			for _, child in ipairs(node) do
				if child[1] and evaluate_cond(child[1], value_node) then
					return value_node
				end
			end
		elseif node.name == "GASSIGNED?" then
			return value_node
		end
	elseif node.type == "ident" then
		return value_node
	end
	return nil
end

local function evaluate(cond)
	if not cond or cond.name ~= "COND" then
		return nil
	end
	for _, clause in ipairs(cond) do
		if clause.type == "list" and #clause > 0 then
			local result = evaluate_cond(clause[1], clause[2])
			if result then
				if result.type == "placeholder" and result[1] then
					return result[1]
				else
					return nil
				end
			end
		end
	end
	return nil
end

return evaluate