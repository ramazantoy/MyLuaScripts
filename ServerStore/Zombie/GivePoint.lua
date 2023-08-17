local char=script.Parent;

local hum=char:WaitForChild("Humanoid");

hum.Died:Connect(function()
	local tag=hum:FindFirstChild("creator");
	if tag and tag.Value then
		
		local ePlayer=tag.Value;
		--
		if ePlayer:FindFirstChild("leaderstats") then
			
			local pointsStat = ePlayer.leaderstats:FindFirstChild("Points")
			
			pointsStat+=20;
			
			--local killsStat = ePlayer.leaderstats:FindFirstChild("Kills")
			--killsStat+=1;
			
			
		end
	end	
end)
