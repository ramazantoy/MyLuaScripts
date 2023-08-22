local triggerObject=script.Parent.Trigger;

local wall=script.Parent.Blockage;

wall.Transparency=1;
wall.CanCollide=false;

triggerObject.Touched:Connect(function(otherPart)
	
	local hum=otherPart.Parent:FindFirstChild("Humanoid");
	
	if hum then
		wall.Transparency=0;
		wall.CanCollide=true;
	end
	
end)