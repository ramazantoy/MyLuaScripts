local function addBoard(player)
	
	local board=Instance.new("Folder",player);
	board.Name="leaderstats";
	local points=Instance.new("IntValue",board);
	points.Name="Points";
	
	local kills=Instance.new("IntValue",board)
	kills.Name="Kills";
	

	local deaths=Instance.new("IntValue",board)
	deaths.Name="Deaths";
	
	
	
end

--game.Players.PlayerAdded:Connect(addBoard);

game.Players.PlayerAdded:Connect(function(player)
	addBoard(player)
	player.CharacterAdded:Connect(function(char)
		local hum=char:WaitForChild("Humanoid");
		hum.Died:Connect(function()
			hum:UnequipTools();
			local tag=hum:FindFirstChild("creator");
			if tag and tag.Value then
				local ePlayer=tag.Value;
				if ePlayer:FindFirstChild("leaderstats") then
					local killsStat = ePlayer.leaderstats:FindFirstChild("Kills")
					local pointsStat = ePlayer.leaderstats:FindFirstChild("Points")

					if killsStat and pointsStat then
						killsStat.Value += 1
						pointsStat.Value += 50
					end
				end
			end
			
			if player:FindFirstChild("leaderstats") then
				local deathsStat = player.leaderstats:FindFirstChild("Deaths")

				if deathsStat then
					deathsStat.Value += 1
				end
			end
		end)
	end)
end)
