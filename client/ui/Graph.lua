--[[
	Intended to just be a basic renderer for the graph. A few things need to be
	added, however.
	
	TODO:
		- Handles for bezier easing manipulation
		- Less aliased then the default 
]]

local graph = {}
graph.__index = graph

function graph.new(Resolution, KeySequence)
	return setmetatable({Resolution = Resolution, 
						KeySequence = KeySequence,
						Children = Children}, graph) 
end

function graph:Update()

end

return graph