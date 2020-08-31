--[[
	Easy storage for keys for a given object.
]]

local Key = require(script.Parent:WaitForChild("Key"))
local Ease = require(script.Parent:WaitForChild("Easing"))

local KeySequence = {}
KeySequence.__index = KeySequence

--[[
	Constructor; takes in 3 values:
		Object - the actual object being manipulated
		Index - the index of the object being manipulated (i.e. CFrame or Position)
		DefaultValue - the default value returned when there are no keys.
]]
function KeySequence.new(Object, Index, DefaultValue)
	setmetatable({
		Object = Object,
		Index = Index,
		Default = DefaultValue,
		Sequence = {}
	}, KeySequence)
end

--[[
	Stores a key in the sequence for later use.

	TODO: Add another function to manipulate indiviual keys.
]]
function KeySequence:ForceAdd(Value, Time)
	Value = Value or self.DefaultValue
	assert(typeof(self.Object[self.Index]) == typeof(Value), "Incorrect key type!")
	local Key = Key.new(Value, Time)
	table.insert(Sequence, Key)
	return Key -- need to be able to manipulate keys
end


--[[
	Gets the value at a given point in time.
]]
function KeySequence:Get(Time)
	local Key1, Key2
	local Largest = 0
	local LargestKey = nil
	-- we need to get the keys right after and before the time Time
	for k, v in pairs(self.Sequence) do
		if v.Time > Time then continue end
		if v.Time < Largest then continue end
		Largest = v.Time
		LargestKey = v
	end
	local Smallest = math.huge
	local SmallestKey = nil
	for k, v in pairs(self.Sequence) do
		if v.Time < Time then continue end
		if v.Time > Smallest then continue end
		Smallest = v.Time
		SmallestKey = v
	end
	-- have to make sure neither of them are nil so the entire thing doesnt blow up with errors
	if not SmallestKey then SmallestKey = LargestKey end
	if not LargestKey then LargestKey = SmallestKey end
	if not SmallestKey and not LargestKey then return self.Default end
	if LargestKey == SmallestKey then return SmallestKey.Value end
	local x1 = LargestKey.Bezier[1]
	local y1 = LargestKey.Bezier[2]
	local x2 = SmallestKey.Bezier[3]
	local y2 = SmallestKey.Bezier[4]
	local EasingFunction = Ease(x1, y1, x2, y2) -- FIXME: Need to clamp X values eventually! This could cause a very bad bug down the line!
	local UnnormalizedTime = Time - LargestKey.Time
	local NormalizedTime = UnnormalizedTime / (SmallestKey.Time - LargestKey.Time)
	return EasingFunction(NormalizedTime)
end

--[[
	Not currently used, however was originally intended for interpolation. However,
	this just calculates a spline. Could be used for later, so I'm keeping it for now.
]]
function KeySequence:Lagrange(Time)
	local n = self.Sequence
	local Out = 0
	for j = 1, #n do
		local Add = 1
		for k = 1, #n do
			if k == j then continue end
			Add += n[j].Value * ((Time - n[k].Time) / (n[j].Time - n[k].Time))
		end
		Out += Add
	end
	return Out
end

return KeySequence
