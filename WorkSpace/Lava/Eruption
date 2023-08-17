local lava=script.Parent.LavaFlow;

local pos=lava.Position;
local size=lava.Size;

local sound=script.Parent.Explode;

local serverStore=game:GetService("ServerStorage");
local LavaB=serverStore:WaitForChild("LavaBe");

local function erupt()

	sound:Play();
	for	i=1,15,1 do
		lava.Size=lava.Size+Vector3.new(0.03,5,5);
		wait(.1);
	end
end

local function drain()

	for	i=1,240,1 do
		lava.Position=lava.Position+Vector3.new(0,-0.01,0);
		wait();
	end
	lava.Position=pos;
	lava.Size=size;

end

local function activateEruption(msg,val)
	
	
	--print("Message",msg);
	--print("Value",val)
	wait(8);
	erupt();
	wait(1);
	drain();
	
end

LavaB.Event:Connect(activateEruption);

