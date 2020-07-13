local ReplicatedStorage = game:GetService("ReplicatedStorage")

local AssetGrabber = require(script:WaitForChild("AssetGrabber"))

local Cache = Instance.new("Folder", ReplicatedStorage) -- TODO: have to make this not replicate to all clients
Cache.Name = "Cache"

local GrabAsset = Instance.new("RemoteFunction", ReplicatedStorage)
GrabAsset.Name = "GrabAsset"

function GrabAsset.OnServerInvoke(_, Id) -- skip the player, dont need
	local Grabbed = AssetGrabber.Grab(Id)
	Grabbed.Parent = Cache -- replicate to all clients
	return Grabbed 	
end
