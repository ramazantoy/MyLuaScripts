
local dataStoreService=game:GetService("DataStoreService");

local ds=dataStoreService:GetDataStore("MyData");


local function InitalizePlayerData(player)
	local data=nil;
	local succes,msg=pcall(function()
		
		data=ds:GetAsync(player.UserId);
		
	end)
	
	if not succes then
		
		player:Kick("Datastore unreachable, pls try again ", msg);
		
	end
	
	if data then
		local leaderStats=player:FindFirstChild("leaderstats");
		leaderStats.Points.Value=data.Points;
		leaderStats.Kills.Value=data.Kills;
		leaderStats.Deaths.Value=data.Deaths;
	else
		data={Points=0,Deaths=0,Kills=0};
		--print("The First Time Player");
		-- maybe do remove event welcome screen
		
	end
	ds:SetAsync(player.UserId,data);
	-- data is false for clear data
	
	
end

local function SavePlayerData(player)
	
	local data={};
	local leaderStats=player:FindFirstChild("leaderstats");
	data.Points=leaderStats.Points.Value;
	data.Kills=leaderStats.Kills.Value;
	data.Deaths=leaderStats.Deaths.Value
	ds:SetAsync(player.UserId,data);
	
	
end

local function SaveLoop()
	
	while wait(5) do
		local players=game.Players:GetChildren();
		for i,player in pairs(players) do
			local board=player:FindFirstChild("leaderstats");
			
			if board then
				SavePlayerData(player);
				print("Save loop",player.Name);
				wait();
			end
		end
	end
end
	

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

local function ExcludeAccessory(part)
	if part:IsA("Accessory") then
		for i, v in pairs(part:GetChildren()) do
			if v:IsA("BasePart") then
				
				v.CanCollide = false
				v.CanQuery = false
				
			end
		end
	end
end

game.Players.PlayerAdded:Connect(function(player)
	addBoard(player)
	InitalizePlayerData(player)
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
	player.CharacterAppearanceLoaded:Connect(function(char)
		
		for i,v in pairs(char:GetChildren()) do
			
			ExcludeAccessory(v);
		end
		char.DescendantAdded:Connect(function(part)
			
			ExcludeAccessory(part);
		end)
	end)
end)

spawn(SaveLoop); -- spawn thread for save loop;

game.Players.PlayerRemoving:Connect(SavePlayerData); -- on leave saving;

