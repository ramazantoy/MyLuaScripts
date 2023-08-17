local boulderTrap=script.Parent;

local triggerObject=boulderTrap.Trigger;

local stopperObject=boulderTrap.Stopper;

stopperObject.Transparency=1;
local boulderTemplate=boulderTrap.Boulder;

local currentBoulder=nil;
local canTrigger=false;

local debris=game:GetService("Debris");

local function OnTouch(otherPart)

	local hum =otherPart.Parent:FindFirstChild("Humanoid");


	if hum and canTrigger then
	

		stopperObject.CanCollide=false;
		stopperObject.Transparency=1;
		canTrigger=false;
		debris:AddItem(currentBoulder,8);--8 sn yok olacak
		currentBoulder.BoulderSnd:Play();

	end

end

local function SetTrap()

	currentBoulder=boulderTemplate:Clone();
	currentBoulder.Transparency=0;
	currentBoulder.CanCollide=true;
	currentBoulder.Anchored=false;
	currentBoulder.Parent=boulderTrap;
	
	stopperObject.CanCollide=true;
	stopperObject.Transparency=0;
	
	currentBoulder.Destroying:Connect(SetTrap)
	canTrigger=true;
end 

triggerObject.Touched:Connect(OnTouch);
SetTrap();

