local character=script.Parent;

local wayPoints=character.Wps:GetChildren();

local humanoid=character.Humanoid;

local wayPointIndex=1;

humanoid.WalkSpeed=10;

wait(5);

humanoid:MoveTo(wayPoints[wayPointIndex].Position);

humanoid.MoveToFinished:Connect(function()
	
	wayPointIndex+=1;
	
	if(wayPointIndex>#wayPoints) then
		
		wayPointIndex=1;
	end
	humanoid:MoveTo(wayPoints[wayPointIndex].Position);
	
end)