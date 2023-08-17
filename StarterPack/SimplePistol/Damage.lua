local shootRe=script.Parent:WaitForChild("ShootRe");

local damage=8;

local bang=script.Parent.GunPart.Bang;

local function tagHumanoid(hum,player)
	
	local creatorTag=Instance.new("ObjectValue",hum);
	
	creatorTag.Name="creator";
	creatorTag.Value=player;
	game.Debris:AddItem(creatorTag,2);
	
end

local function untagHumanoid(hum)
	
	for i,v in pairs(hum:GetChildren()) do
		
		if v:IsA("ObjectValue") and v.Name=="creator" then 
		
			v:Destroy();
			
			
		end
	end
end

local config=script.Parent:WaitForChild("Configuration");
local coolDownValue=config:WaitForChild("CoolDown");

local canShoot=true;

local function OnShoot(player,target)
	
	if canShoot then
		
		canShoot=false;
		bang:Play();

		if(target ~= nil  and target.Parent) then
			local hum=target.Parent:FindFirstChild("Humanoid");

			if hum then
				untagHumanoid(hum);
				tagHumanoid(hum,player);
				hum:TakeDamage(damage);
			end
		end
		wait(coolDownValue.Value);
		canShoot=true;
	end

end
shootRe.OnServerEvent:Connect(OnShoot);