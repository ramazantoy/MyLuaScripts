local rs=game:GetService("ReplicatedStorage");

local infoMsgRe=rs:WaitForChild("InfoMessageRe");

local LblTemplate=rs:WaitForChild("InfoMessageLabel");

local ts=game:GetService("TweenService");

local ti=TweenInfo.new(1,Enum.EasingStyle.Quad,
	Enum.EasingDirection.Out,0,false,2);

local goal={Position=UDim2.new(.5,0,-.5,0)};




local msgQue={};

local function processMsg()
	
	while true do
		
		if(#msgQue>0) then
			
			local lbl=LblTemplate:Clone();
			lbl.Parent=script.Parent;
			lbl.Text=msgQue[1];
			local tween= ts:Create(lbl,ti,goal);
			tween:Play();
			tween.Completed:Wait();
			table.remove(msgQue,1);
			lbl:Destroy();
		else
			--print("the que is empty");
			wait(1);
		end
	end
end
infoMsgRe.OnClientEvent:Connect(function(msg)
	table.insert(msgQue,msg);
	
	
end)
spawn(processMsg);

