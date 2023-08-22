local rs=game:GetService("ReplicatedStorage");

local infoMsgRe=rs:WaitForChild("InfoMessageRe");

game.Players.PlayerAdded:Connect(function(player)
	
	--print("Player added to msgGen event");
	wait(5);
	--print("Sending messages");
	
	for i=1,3,1 do
		local msg="message number".. i;
		--print("serverside message ",msg);
		infoMsgRe:FireClient(player,msg);
		
	end
	
end);
