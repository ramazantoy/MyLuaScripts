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

game.Players.PlayerAdded:Connect(addBoard);
