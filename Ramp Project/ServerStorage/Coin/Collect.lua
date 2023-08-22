local coin=script.Parent;

local players=game:GetService("Players");

--onCollectEventForCollectedPlayer
local replicatedStore=game:GetService("ReplicatedStorage");
local awardPoints=replicatedStore:WaitForChild("AwardPointsRe");

local pointVal=10;


local function OnCollect(otherPart)
	
	local hum= otherPart.Parent:FindFirstChild("Humanoid");
	
	if hum  then
		
		local player=players:GetPlayerFromCharacter(otherPart.Parent);
		
		if player then
			awardPoints:FireClient(player,pointVal)
			local points=player.leaderstats["Points"];
			points.Value+=pointVal;
			coin.CanRotate.Value=false;
			hum.UseJumpPower=true;
			--hum.JumpPower=150;
			--hum.WalkSpeed=50;
			coin:Destroy();
		end
	
	
	end
	
end

coin.Touched:Connect(OnCollect);



