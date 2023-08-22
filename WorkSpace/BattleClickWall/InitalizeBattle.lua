local clicker=script.Parent.Button.ClickDetector;

local placeId=1;--place Id


local teleportService=game:GetService("TeleportService");

local playerQue={};

local function SendPlayers()
	local code=teleportService:ReserveServer(placeId);
	
	teleportService:TeleportToPrivateServer(placeId,code,playerQue);
	playerQue={};
	
end

local function StartRegistration(player)
	
	table.insert(playerQue,player);
	
	SendPlayers();
	
end

clicker.MouseClick:Connect(StartRegistration);
