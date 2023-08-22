local rs=game:GetService("ReplicatedStorage");

local battleRe=rs:WaitForChild("BattleRoyalRe");

local battleFrm=script.Parent;

local battleLbl=battleFrm.BattleRoyalLbl;


local acceptBtn=battleFrm.AcceptBtn;

local declineBtn=battleFrm.DeclineBtn;



battleRe.OnClientEvent:Connect(function(queTime)
	
	battleFrm.Visible=true;
	
	for i=queTime,0,-1 do
		battleLbl.Text="Battle in ... " .. i;
		wait(1);
	end
	battleFrm.Visible=false;
end)

acceptBtn.Activated:Connect(function()
	acceptBtn.BorderSizePixel=5;
	declineBtn.BorderSizePixel=1;
	battleRe:FireServer(true);
end)

declineBtn.Activated:Connect(function()
	acceptBtn.BorderSizePixel=1;
	declineBtn.BorderSizePixel=5;
	battleRe:FireServer(false);
end)

