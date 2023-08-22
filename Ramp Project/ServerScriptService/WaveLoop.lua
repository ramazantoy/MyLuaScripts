local utils=require(game.ServerScriptService.SessionUtils);

--Zombie
local numberOfZombies=10;
local zombieFolder=workspace.Zombies;
--Mines
local numberOfMines=15;
local distanceOfMines=25;
--Healtbar

local numberOfHealths=10;
local healthCenterDistance=50;
local healthCenterPos=workspace.HealthCenter.Position;

--LavaBindEvent

local serverStore=game:GetService("ServerStorage");

local lavaBe=serverStore:WaitForChild("LavaBe");

local waveLoop=0;

--Coin

local numberOfCoins=100;

local distFromCoin=1024;

local kickAi="KickAi";

wait(5);
while true do

	wait(1);
	utils:PlaceMines(numberOfMines,distanceOfMines);
	utils:SpawnKickerNpc("KickAi");
	wait(1);
	utils:PlaceHealth(numberOfHealths,healthCenterPos,healthCenterDistance)
	wait(1);
	utils:PlaceCoins(numberOfCoins,distFromCoin)

	--Spawn Zombies
	local cnt=#zombieFolder:GetChildren();
	if(cnt==0) then
		utils:SpawnZombies(numberOfZombies,distanceOfMines);
	end
	wait(1);
	if(waveLoop%15==0) then
		lavaBe:Fire("Lava Event",waveLoop);
	end
	waveLoop+=1;



end



