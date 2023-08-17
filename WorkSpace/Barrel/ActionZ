local part=script.Parent;

local prompt=part.ActionPrompt;

local alarm=part.Alarm;

local sss=game:GetService("ServerScriptService");

local zss= sss:WaitForChild("ZSpawner");

local activeted=zss:WaitForChild("Activated");

function OnRelase(player)

	if(activeted.Value) then

		activeted.Value=false;
		alarm:Stop();
	else
		activeted.Value=true;
		alarm:Play();
	end

end


prompt.Triggered:Connect(OnRelase);
