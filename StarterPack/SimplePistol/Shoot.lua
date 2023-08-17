local gun=script.Parent;

local shootRe=gun:WaitForChild("ShootRe");

local player=nil;
local mouse=nil;
local connection=nil;

local config=gun:WaitForChild("Configuration");
local coolDownValue=config:WaitForChild("CoolDown");

local canShoot=true;

local function OnActivated()
	
	if canShoot then
		
		canShoot=false;
		shootRe:FireServer(mouse.Target);
		wait(coolDownValue.Value);
		canShoot=true;
		
	end
	
	
end


local function OnEquipped()
	
	player=game.Players.LocalPlayer;
	mouse=player:GetMouse();
	connection=gun.Activated:Connect(OnActivated);
	
end

local function OnUnEquipped()

	player=nil;
	mouse=nil;
	connection:Disconnect();

end

gun.Equipped:Connect(OnEquipped);
gun.Unequipped:Connect(OnUnEquipped);