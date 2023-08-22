local clicker=script.Parent.Button.ClickDetector;

local placeId=1 --placeId;


local teleportService=game:GetService("TeleportService");

local playerQue={};

local rs=game:GetService("ReplicatedStorage");

local battleRe=rs:WaitForChild("BattleRoyalRe");

local queTime=15;

local isIntiated=false;

local sound=script.Parent.BattleStartSound;

local requiredPlayers=1;



local function HasPlayer(tab,player)
	
	for _,v in pairs(tab) do
		if v==player then
			print("Player found in table ...",player.Name);
			return true;
		end
	end
	return false;
end

local function RemovePlayer(tab,player)
	
	for i,v in pairs(table) do
		if v==player then
			table.remove(table,i);
		end
	end
	
end
local function PlayerResponse(player,response)
	
	if player and response then
		if not HasPlayer(playerQue,player) then
			table.insert(playerQue,player);
			--print("Player has joined  the que ..",playerQue);
		end
	else
		RemovePlayer(playerQue,player);
		--print("Player has been removed from que ..",player.Name);
	end
		
	
end

local function SendPlayers()
	
	if #playerQue >=requiredPlayers then
		
		--print("prepare teleport..")
		local code=teleportService:ReserveServer(placeId);

		teleportService:TeleportToPrivateServer(placeId,code,playerQue);
		playerQue={};
	end


end

local function StartRegistration(player)

	if not isIntiated then

		isIntiated=true;

		--table.insert(playerQue,player);
		
		sound:Play();
		
		battleRe:FireAllClients(queTime);
		
		wait(queTime);
		
		SendPlayers();

		isIntiated=false;
	end


end

clicker.MouseClick:Connect(StartRegistration);

battleRe.OnServerEvent:Connect(PlayerResponse);
