local homeId=1;--Ramp project id

local teleportService=game:GetService("TeleportService");

local function addPlayer(player)
	player.CharacterAdded:Connect(function(char)
		local hum=char:WaitForChild("Humanoid");
		hum.Died:Connect(function()
			teleportService:Teleport(homeId,player);
		end)
	end)
end
game.Players.PlayerAdded:Connect(addPlayer);
