
local pickUp=script.Parent;

local function OnTouch(otherPart)

	local hum= otherPart.Parent:FindFirstChild("Humanoid");
	if hum ~= nil and (hum.Health<hum.MaxHealth) then

		hum.Health =hum.MaxHealth;
		pickUp:Destroy()

	end



end


pickUp.Touched:Connect(OnTouch)


