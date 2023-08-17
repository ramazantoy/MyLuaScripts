
local dataStoreService=game:GetService("DataStoreService");

local ds=dataStoreService:GetDataStore("MyData");

local rs=game:GetService("ReplicatedStorage");

local infoMsgRE=rs:WaitForChild("InfoMessageRe");


local function addBoard(player)
	local board = Instance.new("Folder", player)
	board.Name = "leaderstats"

	local points = Instance.new("IntValue", board)
	points.Name = "Points"

	local kills = Instance.new("IntValue", board)
	kills.Name = "Kills"

	local deaths = Instance.new("IntValue", board)
	deaths.Name = "Deaths"

	local playerInfo = Instance.new("Folder", player)
	playerInfo.Name = "playerInfo"

	local badData = Instance.new("BoolValue", playerInfo)
	badData.Name = "Bad Data"
	badData.Value = false

	--daily event
	local savedTime=Instance.new("NumberValue",playerInfo);
	savedTime.Name="SavedTime";

	local streak=Instance.new("IntValue",playerInfo);
	streak.Name="Streak";
end


local function CheckDailyStreak(player)
	local savedTime=player.playerInfo.SavedTime.Value;
	local secPerDay=86400; --second for a day
	local now=os.time();
	local nowMinus1day=now-secPerDay;
	local formatedSaveTime=os.date('*t',savedTime);
	local formatedNowMinus1Day=os.date('*t',nowMinus1day);


	if formatedSaveTime.yday == formatedNowMinus1Day.yday  and 
		formatedSaveTime.year == formatedNowMinus1Day.year then
		player.playerInfo.Streak.Value+=1;
		infoMsgRE:FireClient(player,"You  increast your streak!".. player.playerInfo.Streak.Value);
		infoMsgRE:FireClient(player,"You get 100 points.");
		infoMsgRE:FireClient(player,"You get a daily reward!.");
		infoMsgRE:FireClient(player,"You get 50 points.");
		player.leaderstats.Points.Value+=150;
	elseif (now-savedTime < secPerDay) then


	else
		player.playerInfo.Streak.Value=1;
		infoMsgRE:FireClient(player,"You broke your streak.");
		infoMsgRE:FireClient(player,"You get a daily reward!.");
		infoMsgRE:FireClient(player,"You get 50 points.");
		player.leaderstats.Points.Value+=50;
	end

	player.playerInfo.SavedTime.Value=now;

end

local function InitalizePlayerData(player)
	local data=nil;
	local succes,msg=pcall(function()

		data=ds:GetAsync(player.UserId);

	end)

	if not succes then

		player.playerInfo["Bad Data"].Value=true;
		player:Kick("Datastore unreachable, pls try again ", msg);

	end

	if data then
		local leaderStats=player.leaderstats;
		leaderStats.Points.Value=data.Points;
		leaderStats.Kills.Value=data.Kills;
		leaderStats.Deaths.Value=data.Deaths;
		if not data.Streak then
			--brand new user
			player.playerInfo.Streak.Value=1;
			player.playerInfo.SavedTime.Value=os.time();
		else
			player.playerInfo.Streak.Value=data.Streak;
			player.playerInfo.SavedTime.Value=data.SavedTime;
			CheckDailyStreak(player);
		end


	else
		data={Points=0,Deaths=0,Kills=0,Streak=1,SaveTime=os.time()};
		--print("The First Time Player");
		-- maybe do remove event welcome screen

	end
	ds:SetAsync(player.UserId,data);
	-- data is false for clear data


end


local function SavePlayerData(player)
	local data = {}
	local leaderStats = player.leaderstats;
	data.Points = leaderStats.Points.Value
	data.Kills = leaderStats.Kills.Value
	data.Deaths = leaderStats.Deaths.Value

	CheckDailyStreak(player);
	data.SavedTime=player.playerInfo.SavedTime.Value;
	data.Streak=player.playerInfo.Streak.Value;


	if not player.playerInfo["Bad Data"].Value then

		ds:SetAsync(player.UserId,data);
	else

	end
end

local function SaveLoop()

	while wait(10) do
		local players=game.Players:GetChildren();
		for i,player in pairs(players) do
			local board=player:FindFirstChild("leaderstats");

			if board then
				SavePlayerData(player);
				--print("Save loop",player.Name);
				wait();
			end
		end
	end
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
					local killsStat = ePlayer.leaderstats["Kills"];
					local pointsStat = ePlayer.leaderstats["Deaths"];

					if killsStat and pointsStat then
						killsStat.Value += 1
						pointsStat.Value += 50
					end
				end
			end

			if player.leaderstats then
				local deathsStat = player.leaderstats["Deaths"];

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

