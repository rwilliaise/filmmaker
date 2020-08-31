local Players = game:GetService("Players")

local Graph = require(script:WaitForChild("Graph"))
local Tree = require(script:WaitForChild("Tree"))

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local ui = {}

function ui.Initialize()
	local ScreenGui = Instance.new("ScreenGui", PlayerGui)
	local MainFrame = Instance.new("Frame", ScreenGui)
	MainFrame.Size = UDim2.new(1, 0, 1, 0)
end

return ui