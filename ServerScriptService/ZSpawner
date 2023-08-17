local ss=game:GetService("ServerStorage");

local szs=ss:WaitForChild("SimpleZSpawner");

local zombieModel=szs:WaitForChild("Zombies");

local interMission=script:WaitForChild("InterMission")
local round=script:WaitForChild("Round");
local ttl=script:WaitForChild("TimeToLive");
local activated=script:WaitForChild("Activated");
local debris=game:GetService("Debris");

while true do
	
	wait(interMission.Value);
	
	if(activated.Value) then
		
		local zombies=zombieModel:Clone();
		zombies.Parent=workspace;
		wait(round.Value);
		debris:AddItem(zombies,ttl.Value);
	end


end
