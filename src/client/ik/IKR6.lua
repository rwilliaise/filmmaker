-- Rig an R6 model into IK.

local InverseKinematics = require(script:WaitForChild("InverseKinematics"))

local IK6 = {}

function IK6.AutoRig(Rig)
	-- ah yes. spaghet.
	local Humanoid = assert(Rig:FindFirstChild("Humanoid"), "Humanoid not found!")
	assert(Humanoid.RigType == Enum.HumanoidRigType.R6, "Not a valid R6 rig!")
	assert(Rig:FindFirstChild("HumanoidRootPart"), "HumanoidRootPart not found!")
	assert(Rig:FindFirstChild("Torso"), "Torso not found!")
	assert(Rig:FindFirstChild("Left Leg"), "Left Leg not found!")
	assert(Rig:FindFirstChild("Left Arm"), "Left Arm not found!")
	assert(Rig:FindFirstChild("Right Leg"), "Right Leg not found!")
	assert(Rig:FindFirstChild("Right Arm"), "Right Arm not found!")

	
end

return IK6