local Handles = {}
Handles.__index = Handles

--[[
	Base constructor for RotationHandles.

		CFrame Position
			The CoordinateFrame object to manipulate.
		boolean Local
			When this is false, the RotationHandles will only transform the
			Position value in world space. When this is true, however, it will
			transform the Position value in Local space. 
]]
function Handles.new(Local)
	local Handle1 = Instance.new("Part", workspace.CurrentCamera)
	local SurfaceGui1 = Instance.new("SurfaceGui", Handle1)
	SurfaceGui1.Adornee = Handle1
	return setmetatable({
		Handle1 = Handle1
	}, Handles)
end

--[[
	Destroy all instances related to this object.
]]
function Handles:Destroy()
	self.Handle1:Destroy()
end

return Handles