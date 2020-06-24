-- I'll have to eventually store something for the polynomial interpolation
local Key = {}
Key.__index = Key

-- for now this is a storage object for the value and time
-- still reading on polynomial interpolation
function Key.new(Value, Time)
	return setmetatable({
		Value = Value,
		Time = Time
	}, Key)
end

return Key
