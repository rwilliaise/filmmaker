--[[
	Stores the value, time and easing data for each key so I don't need to
	create a new table for each key. The OOP is kinda pointless, however its
	pretty nice.

	Eventually I will need to implement a :new overload for the constructor
	so I can duplicate certain keys. For now, however, this is a fine impl.
]]

local Key = {}
Key.__index = Key

function Key.new(Value, Time)
	return setmetatable({
		Value = Value,
		Time = Time,
		Bezier = {0.5,0.5,
				  0.5,0.5} -- linear easing
	}, Key)
end

return Key
