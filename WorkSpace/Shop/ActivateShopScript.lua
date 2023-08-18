local click=script.Parent.Click;

local rs=game:GetService("ReplicatedStorage");

local shopRe=rs:WaitForChild("ShopRe");


click.MouseClick:Connect(function(player)
	
	
	shopRe:FireClient(player);
	
	
end)