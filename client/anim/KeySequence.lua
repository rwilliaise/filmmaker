local Key = require(script.Parent:WaitForChild("Key"))
local Ease = require(script.Parent:WaitForChild("Easing"))

local KeySequence = {}
KeySequence.__index = KeySequence

-- base constructor. index would be the CFrame in
-- Object.CFrame as an example.
function KeySequence.new(Object, Index, DefaultValue)
	setmetatable({
		Object = Object,
		Index = Index,
		Default = DefaultValue,
		Sequence = {}
	}, KeySequence)
end

-- Add a key to the sequence
function KeySequence:ForceAdd(Value, Time)
	assert(typeof(self.Object[self.Index]) == typeof(Value), "Incorrect key type!")
	table.insert(Sequence, Key.new(Value, Time))
end

-- Converting this to a function of time. Fun!
function KeySequence:Get(Time)
	local Key1, Key2
	local Largest = 0
	local LargestKey = nil
	-- Get the key right before time Time
	for k, v in pairs(self.Sequence) do
		if v.Time > Time then continue end
		if v.Time < Largest then continue end
		Largest = v.Time
		LargestKey = v
	end
	local Smallest = math.huge
	local SmallestKey = nil
	-- Get the key right after or during time Time
	for k, v in pairs(self.Sequence) do
		if v.Time < Time then continue end
		if v.Time > Smallest then continue end
		Smallest = v.Time
		SmallestKey = v
	end
	-- make sure both of them arent nil by the time we start screwing around with their values
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

-- DONE: Find out how exactly to interpolate differently 
-- between keys.
--
-- Also found out - we don't even need this! Too bad!
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
