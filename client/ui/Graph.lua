--[[
	Intended to just be a basic renderer for the graph. A few things need to be
	added, however.
	
	TODO:
		- Handles for bezier easing manipulation
		- Less aliased then the default 
]]

local graph = {}
graph.__index = graph

--[[
	Used to create a frame to represent a small part of the slope on the curve.
	Takes in two points on the screen and creates a frame connecting the two.
]]
local function RenderLine(point1, point2, frame)
	local difference = point2 - point1
	local slope = frame or Instance.new("Frame")
	slope.Size = UDim2.new(0, difference.Magnitude + 1, 0, 2)
	slope.Rotation = math.deg(math.atan2(difference.Y, difference.X))
	slope.Position = UDim2.new(0, (p1.x + v.x/2) - (difference.Magnitude + 1) * 0.5, 0, (p1.y + v.y/2) - 1)
	slope.BorderSizePixel = 0
	slope.BackgroundColor3 = Color3.new()
	return slope
end

--[[
	Simple constructor.
]]
function graph.new(Frame, Resolution, KeySequence)
	return setmetatable({
							Frame = Frame,
							Resolution = Resolution, 
							KeySequence = KeySequence
						}, graph) 
end

--[[
	Used to update the graph display with new information.
]]
function graph:Update(Start, End, Zoom)
	local KeySequence = self.KeySequence
end

return graph