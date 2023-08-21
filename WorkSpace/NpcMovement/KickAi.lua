local aiNpc=script.Parent;

local aiHrp=aiNpc.HumanoidRootPart;

local aiHum=aiNpc.Humanoid;

local maxDistance=30;

local frontKickAnim=script:WaitForChild("KickAnim");

local animator=aiHum:WaitForChild("Animator");

local frontKickTrack = animator:LoadAnimation(frontKickAnim);

local kickSound=aiHrp:WaitForChild("KickSound");

local tolForKick=3;-- 5 studs away

local kickDamage=30;





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

local function KickBack(attackCharacter,enemyCharacter)
	if attackCharacter and enemyCharacter then
		
		local aHrp=attackCharacter:FindFirstChild("HumanoidRootPart");
		
		local eHrp=enemyCharacter:FindFirstChild("HumanoidRootPart");
		
		if aHrp and eHrp then
			local direction=(eHrp.Position-aiHrp.Position).Unit;
			local att=Instance.new("Attachment",eHrp);
			local vectorForce=Instance.new("VectorForce",eHrp);
			vectorForce.Attachment0=att;
			vectorForce.Force=(direction+Vector3.new(0,1,0)).Unit*1000;
			vectorForce.RelativeTo=Enum.ActuatorRelativeTo.World;
			vectorForce.ApplyAtCenterOfMass=true;
			local rot=Instance.new("AngularVelocity",eHrp);
			rot.Attachment0=att;
			rot.AngularVelocity=Vector3.new(1,1,1)*30;
			rot.MaxTorque=math.huge;
			game.Debris:AddItem(vectorForce,2);
			game.Debris:AddItem(rot,2);
			game.Debris:AddItem(att,2);
		end
	end
		
end

local function IsWithInRange(hrp,goal,tolarance)
	
	return ((hrp.Position-goal.Position).Magnitude < tolarance);
end

while wait(1) do
	
	local closestHrp=FindNearestChars(aiNpc,maxDistance);
	if closestHrp then
		local targetPos=closestHrp.Position;
		local aiDir=(targetPos-aiHrp.Position).Unit; --direction vector for unit normalized vector
		aiHum:MoveTo(targetPos-aiDir*2,closestHrp);
		
		local rng=IsWithInRange(aiHrp,closestHrp,tolForKick);
		
	
		local closestHum=closestHrp.Parent:WaitForChild("Humanoid");
		
		if rng and closestHum and closestHum.Health > 2 then
			
			frontKickTrack:Play();
			kickSound:Play();
		
			closestHum:TakeDamage(kickDamage);
			KickBack(aiNpc,closestHrp.Parent)
			
		end
	end
end



