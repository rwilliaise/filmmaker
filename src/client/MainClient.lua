--[[
	The main LocalScript running client-side. This is meant for the standalone.

	TODO: Seperate the standalone and plugin codebases. Should be fairly simple
	as most of the code is highly modular.
]]
local client = script:FindFirstAncestor("client")
local anim = client:WaitForChild("anim")
local ui = client:WaitForChild("ui")

local KeySequence = require(anim:WaitForChild("KeySequence"))
local Animation = require(anim:WaitForChild("Animation"))
local MainUI = require(ui:WaitForChild("MainUI"))

local MainAnimation = Animation.new()

MainUI.Initialize()