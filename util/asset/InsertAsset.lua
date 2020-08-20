--[[
	Used to parse the actual .rbxm downloaded frm the asset delivery endpoint.
]]

local HttpProxy = require(script.Parent:WaitForChild("HttpProxy"))

local Magic = "rb" -- TODO: Find the .rbxm binary magic.

--[[
	Used to get an asset from the asset delivery endpoint so we don't have the
	opressive limitations of InsertService. Not sure if there is entirely a
	better solution to this, however I cannot find a better one.
]]
local function InsertAsset(id)
	local Data = HttpProxy.Request(id)
	--[[
		First, detect which data type we are working with. If it is the XML version,
		parse it like an XML file, and if it has the binary magic asscociated with
		the binary version, parse it like a binary file.

		Second, create the model, using the classnames and properties provided withn
		the data.

		Finally, if we cannot set the properties of a given object, simply skip the
		object in question/destroy it.
	]]
end

return InsertAsset
