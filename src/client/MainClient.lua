--[[
	The main LocalScript running client-side. This is meant for the standalone.

	TODO: Seperate the standalone and plugin codebases. Should be fairly simple
	as most of the code is highly modular.
]]
local KeySequence = require(script:WaitForChild("KeySequence"))
local Animation = require(script:WaitForChild("Animation"))
local MainUI = require(script:WaitForChild("MainUI"))

local MainAnimation = Animation.new() -- TODO: saving

MainUI.Initialize()

-- animation manipulation code goes here