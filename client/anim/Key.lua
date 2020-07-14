--[[
	Stores the value, time and easing data for each key so I don't need to
	create a new table for each key. Literally only used to store data -
	actually don't even need the metatables. Too bad!
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
