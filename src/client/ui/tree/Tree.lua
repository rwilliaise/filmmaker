--[[
	Supposed to be an easy-to-use, OOP based tree ui. Still working on both of those.
]]
local tree = {}
tree.__index = tree

function tree.new()
	return setmetatable({Elements = {}}, tree)
end

function tree:AddElement()

end

return tree