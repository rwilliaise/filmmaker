local Key = require(script.Parent:WaitForChild("Key"))

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
