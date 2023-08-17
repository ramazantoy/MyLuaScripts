local shootRe=script.Parent:WaitForChild("ShootRe");

local damage=8;

local bang=script.Parent.GunPart.Bang;

local function OnShoot(player,target)
	bang:Play();
	
	if(target ~= nil  and target.Parent) then
		local hum=target.Parent:FindFirstChild("Humanoid");
		
		if hum then
			hum:TakeDamage(damage);
		end
	end
end
shootRe.OnServerEvent:Connect(OnShoot);