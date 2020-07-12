local Key = require(script.Parent:WaitForChild("Key"))
local Ease = require(script.Parent:WaitForChild("Easing"))

local KeySequence = {}
KeySequence.__index = KeySequence

-- base constructor. index would be the CFrame in
-- Object.CFrame as an example.
function KeySequence.new(Object, Index)
	setmetatable({
		Object = Object,
		Index = Index,
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
	local LargestKey = 0
	for k, v in pairs(self.Sequence) do
		if v.Time > Time then continue end
		if v.Time < Largest then continue end
		Largest = v.Time
		LargestKey = v
	end
	local Smallest = math.huge
	local SmallestKey = math.huge
	for k, v in pairs(self.Sequence) do
		if v.Time < Time then continue end
		if v.Time > Smallest then continue end
		Smallest = v.Time
		SmallestKey = v
	end
	if LargestKey == SmallestKey then return SmallestKey.Value end
	
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
