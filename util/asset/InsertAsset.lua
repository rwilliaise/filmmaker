--[[
	Used to parse the actual .rbxm downloaded frm the asset delivery endpoint.
]]

local HttpProxy = require(script.Parent:WaitForChild("HttpProxy"))

--[[
	Used to get an asset from the asset delivery endpoint so we don't have the
	opressive limitations of InsertService. Not sure if there is entirely a
	better solution to this, however I cannot find a better one.
]]
local function InsertAsset(id)
	
end

return InsertAsset
