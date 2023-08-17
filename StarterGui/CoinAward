
local replicatedStore=game:GetService("ReplicatedStorage");
local awardsPointsRe=replicatedStore:WaitForChild("AwardPointsRe");

local sound=script:WaitForChild("Grab");

local labelTemp=replicatedStore:WaitForChild("AwardLbl");
local tweenService=game:GetService("TweenService");
local screenGui=script.Parent;

local function OnAward(value)
	
	sound:Play();
	local lbl=labelTemp:Clone();
	lbl.Parent=screenGui;
	lbl.Text="+".. tostring(value);
	
	local tween = tweenService:Create(lbl,TweenInfo.new(3),
		{Position=UDim2.new(.5,0,-.5,0)});
	tween:Play();
	
	tween.Completed:Wait();
	lbl:Destroy();
	
	
	
end

awardsPointsRe.OnClientEvent:Connect(OnAward);






