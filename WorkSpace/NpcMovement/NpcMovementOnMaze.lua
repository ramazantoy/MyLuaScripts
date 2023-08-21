local character=script.Parent;


local targetObject=workspace.SimpleMaze.Target;

local pathFindService=game:GetService("PathfindingService");

local path=pathFindService:CreatePath();

local wayPointIndex=1;

local wayPointsTable={};

local humanoidObj=character:WaitForChild("Humanoid");

local humanoidRootPartObj=character:WaitForChild("HumanoidRootPart");

local function FallowThePath(goal)
	
	path:ComputeAsync(humanoidRootPartObj.Position,goal.Position);
	wayPointsTable={};
	
	if path.Status==Enum.PathStatus.Success then
		
		wayPointsTable=path:GetWaypoints();
		wayPointIndex=1;
		humanoidObj:MoveTo(wayPointsTable[wayPointIndex].Position);
	end
	
end

humanoidObj.MoveToFinished:Connect(function(reached)
	
	if(reached and wayPointIndex<#wayPointsTable) then
		wayPointIndex+=1;
		if wayPointsTable[wayPointIndex].Action==Enum.PathWaypointAction.Jump then
			
			humanoidObj.Jump=true;
		end
		humanoidObj:MoveTo(wayPointsTable[wayPointIndex].Position);
	
	end
	
end)

path.Blocked:Connect(function(wayPoint)
	
	if wayPoint > wayPointIndex then
		
		FallowThePath(targetObject);
	end

end)

wait(5);

FallowThePath(targetObject);

