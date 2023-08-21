local utils= {}

local serverStore=game:GetService("ServerStorage");
local rnd=Random.new(tick());

--Spawn Zombies

local zombieFolder=workspace.Zombies;


--Spawn Kicker

function utils:SpawnKickerNpc(npc)
		local npcInWorld=workspace:FindFirstChild(npc);

		if not npcInWorld then
			local newNpc=serverStore:WaitForChild("KickAi"):Clone();
			newNpc.Parent=workspace;

		end
end


function utils:SpawnZombies(numberOfZombies)

	local tZom=serverStore:WaitForChild("Drooling Zombie");
	local spawnArr=workspace.MSpawnLocs:GetChildren();

	for i=1,numberOfZombies,1 do
		local zombie=tZom:Clone();
		zombie.Parent=zombieFolder;
		local index=rnd:NextInteger(1,#spawnArr)
		zombie:MoveTo(spawnArr[index].Position)
		wait(1);
	end
end

--Spawn Land Mine

local mineFolder=workspace.Mines;

local signPosition=workspace.LandMineSign.Position;


local debris=game:GetService("Debris");

function utils:PlaceMines(numberOfMines,distance)

	local tMine=serverStore:WaitForChild("LandMine");
	local cnt=#mineFolder:GetChildren();

	for i=cnt+1,numberOfMines,1 do

		local xRand=rnd:NextInteger(-distance,distance);
		local zRand=rnd:NextInteger(-distance,distance);

		local pos=Vector3.new(signPosition.X+xRand,tMine.Plate.Position.Y,signPosition.Z+zRand);
		local mine=tMine:Clone();
		mine.Parent=mineFolder;
		mine:MoveTo(pos);
		debris:AddItem(mine,rnd:NextInteger(3,10));


	end


end

--Add to health bar

local healthFolder=workspace.Health;

local function CastRayDownForHeight(x,z)
	local origin=Vector3.new(x,300,z);
	local stop=Vector3.new(x,-20,z);
	local dir=(stop-origin);
	local result=workspace:Raycast(origin,dir,nil);
	
	if result then
		return result.Position;
	else
		return Vector3.new(x,3,z);
	end
	
	
end

function utils:PlaceHealth(numOfHealths,centerPnt,dist)
	
	local tHealth=serverStore:WaitForChild("HealtPickUp");
	local cnt=#healthFolder:GetChildren();
	while cnt < numOfHealths do
		local xRand=rnd:NextInteger(-dist,dist);
		local zRand=rnd:NextInteger(-dist,dist);
		local pos=CastRayDownForHeight(centerPnt.X+xRand,centerPnt.Z+zRand);
		pos +=Vector3.new(0,3,0);
		local health=tHealth:Clone();
		health.Parent=healthFolder;
		health.Position=pos;
		debris:AddItem(health,rnd:NextInteger(30,90));
		cnt=#healthFolder:GetChildren();
		wait()
		
	end
end

---Place To Collectable Coins

local coinFolder=workspace.Coins;

function utils:PlaceCoins(numOfCoins,dist)

	local tCoin=serverStore:WaitForChild("Coin");
	local cnt=#coinFolder:GetChildren();
	while cnt < numOfCoins do
		local xRand=rnd:NextInteger(-dist,dist);
		local zRand=rnd:NextInteger(-dist,dist);
		local pos=CastRayDownForHeight(xRand,zRand);
		
		if pos ~= nil then
			pos +=Vector3.new(0,3,0);
			local coin=tCoin:Clone();
			coin.Parent=coinFolder;
			coin.Position=pos;
			debris:AddItem(coin,rnd:NextInteger(30,90));
			cnt=#coinFolder:GetChildren();
			wait()
		end

	

	end
end

return utils;


