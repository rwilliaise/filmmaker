--[[
	Handles everything for animating a scene. There is an animation, which you can
	add specific "AnimatedObjects" to. These AnimatedObjects basically handle the
	keysequences and essentially everything keyframe related for a specific object.

	Speaking of KeyFrames and KeySequences, there is a sort of hierarchy for these
	key objects.

	- Animation stores:
		- AnimatedObject stores:
			- KeySequence stores:
				- Keys

	Each stores multiple of the next, all the way down to the Keys, which store a
	single value, along with the bezier easing data.
]]
local KeySequence = script.Parent:WaitForChild("KeySequence")

--[[
	Easy access to specific KeySequences indexed by an object.
]]
local animatedObject = {}
animatedObject.__index = animatedObject

function animatedObject.new(inst)
	return setmetatable({Instance = inst, Sequences = {}}, animatedObject)
end

--[[
	Add a KeySequence representing the index Index on the appropriate object.
]]
function animatedObject:AddIndex(Index, DefaultValue)
	if not self.Instance[Index] then warn("Index " .. Index .. " does not exist!") return end
	local Sequence = KeySequence.new(self.Instance, Index, DefaultValue or self.Instance[Index])
	self.Sequences[Index] = Sequence
end

--[[
	Do all the math to display a specific Time
]]
function animatedObject:Preview(Time)
	for _, v in pairs(self.Sequences) do
		local Value = v:Get(Time)
		local Index = v.Index
		self.Instance[Index] = Value
	end
end

--[[
	Add a key for the sequence pertaining to Index at a specific Time. If no such
	sequence exists, automatically create one.
]]
function animatedObject:AddKey(Index, Time)
	local Sequence = self.Sequences[Index] or self:AddIndex(Index)
	return Sequence:ForceAdd(nil, Time)
end

--[[
	Easy access and creation to objects for manipulation
]]
local animation = {}
animation.__index = {}

function animation.new()
	return setmetatable({Objects = {}}, animation)
end

--[[
	Create a new AnimatedObject to manipulate later.
]]
function animation:AddObject(inst)
	local Object = animatedObject.new(inst)
	table.insert(self.Objects, Object)
	return Object
end

--[[
	Lights, Camera, Action!
]]
function Animation:Preview(Time)
	for _, v in pairs(Objects) do
		v:Preview(Time)
	end
end

return animation
