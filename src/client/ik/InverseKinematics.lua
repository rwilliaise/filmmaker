--[[
	This is an implementation of the Foward And Backwards Reaching Inverse Kinematics
	(FABRIK) algorithm. Instead of using constraints, I am just gonna use a purely
	mathematical model for the system instead.
]]
local IK = {}
IK.__index = IK

local function Sum(Table)
	local x = 0
	for _, v in pairs(Table) do
		x += v
	end
	return x
end
	
local function GetLengths(Joints)
	local Lengths = {}
	local Positions = {}
	local LastJoint
	local LastPosition
	for i, v in ipairs(Joints) do
		if not v or not v:IsA("Motor6D") then continue end
		if not v.Part0 or not v.C0 then continue end
		local Position = (v.Part0.CFrame * v.C0).p
		table.insert(Positions, Position)
		if not LastJoint then LastJoint = v LastPosition = Position continue end
		table.insert(Lengths, (LastPosition - Position).Magnitude)
	end
	return Lengths
end

function IK.new(Joints)
	if not
	local Lengths, Positions = GetLengths(Joints)
	return setmetatable({Lengths = Lengths, Positions = Positions})
end

function IK:Length()
	return Sum(self.Lengths)
end

function IK:Backwards()

end

function IK:Forwards()

end

function IK:Solve(End)
	if (self.Positions[1] - End).Magnitude > IK:Length() then return (self.Positions[1] - End).Unit * IK:Length() end
end

return IK