local tree = {}
tree.__index = tree

function tree.new()
	return setmetatable({Elements = {}}, tree)
end

function tree:AddElement()

end

return tree