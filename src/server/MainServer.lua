--[[
	This server script is meant for the standalone game. Speaking of the standalone,
	I need to seperate the standalone and plugin versions eventually. Perhaps a 
	different repo?
]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local InsertAsset = require(script:WaitForChild("InsertAsset"))

local Cache = Instance.new("Folder", ReplicatedStorage) -- TODO: have to make this not replicate to all clients
Cache.Name = "Cache"

local GrabAsset = Instance.new("RemoteFunction", ReplicatedStorage)
GrabAsset.Name = "GrabAsset"

--[[
	Used to get assets for animation use client-side. Takes an id, and then works
	it's magic to get the actual asset from the asset delivery endpoint. Very
	hacky solution, however it works for now until ROBLOX probably patches it
	out down the line.
]]
function GrabAsset.OnServerInvoke(_, Id)
	local Grabbed = InsertAsset.Grab(Id)
	Grabbed.Parent = Cache
	return Grabbed 	
end
