local gun=script.Parent;

local shootRe=gun:WaitForChild("ShootRe");

local player=nil;
local mouse=nil;
local connection=nil;

local config=gun:WaitForChild("Configuration");
local coolDownValue=config:WaitForChild("CoolDown");

local canShoot=true;

--Animation

local kickBackAnim=script.Parent:WaitForChild("KickBackAnim");
local kickBackTrack=nil;



local function OnActivated()
	
	if canShoot then
		
		canShoot=false;
		kickBackTrack:Play();
		shootRe:FireServer(mouse.Target);
		wait(coolDownValue.Value);
		canShoot=true;
		
	end
	
	
end


local function OnEquipped()
	
	player=game.Players.LocalPlayer;
	mouse=player:GetMouse();
	connection=gun.Activated:Connect(OnActivated);
	local char=player.Character or player.CharacterAdded:Wait();
	local hum=char:WaitForChild("Humanoid");
	local animator=hum:WaitForChild("Animator");
	kickBackTrack=animator:LoadAnimation(kickBackAnim);
	
	
end

local function OnUnEquipped()

	player=nil;
	mouse=nil;
	connection:Disconnect();

end

gun.Equipped:Connect(OnEquipped);
gun.Unequipped:Connect(OnUnEquipped);