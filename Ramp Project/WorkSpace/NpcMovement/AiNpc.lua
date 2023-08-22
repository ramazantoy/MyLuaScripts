local aiNpc=script.Parent;

local aiHrp=aiNpc.HumanoidRootPart;

local aiHum=aiNpc.Humanoid;

local maxDistance=30;


local function FindNearestChars(aiNpc,distanceOfInt)--distrance of interest
	
	local closestHrp=nil;
	local aiNpcHrp=aiNpc.HumanoidRootPart;
	
	for i,v in pairs(workspace:GetChildren()) do
		
		local humanoidRootPart=v:FindFirstChild("HumanoidRootPart");--hrp always first child
		
		if humanoidRootPart  then
			
			local tempDistance=(aiHrp.Position-humanoidRootPart.Position).Magnitude;
			
			if tempDistance<distanceOfInt and tempDistance>1 then
				distanceOfInt=tempDistance;
				closestHrp=humanoidRootPart;
			end
		end
		
	end
	return closestHrp;
	
end

while wait(1) do
	
	local closestHrp=FindNearestChars(aiNpc,maxDistance);
	if closestHrp then
		local targetPos=closestHrp.Position;
		local aiDir=(targetPos-aiHrp.Position).Unit; --direction vector for unit normalized vector
		aiHum:MoveTo(targetPos-aiDir*5,closestHrp);
		
	end
end

