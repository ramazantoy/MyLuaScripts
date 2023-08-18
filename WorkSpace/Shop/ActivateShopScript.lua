local click=script.Parent.Click;

local rs=game:GetService("ReplicatedStorage");

local shopRe=rs:WaitForChild("ShopRe");


click.MouseClick:Connect(function(player)
	
	
	shopRe:FireClient(player);
	
	
end)

shopRe.OnServerEvent:Connect(function(player,itemName,itemPrice)
	
	local item=rs:WaitForChild(itemName);
	
	if item then
		local itemClone=item:Clone();
		itemClone.Parent=player.Backpack;
		local price=tonumber(itemPrice);
		if(price<=2000 and price>=500) then
			player.leaderstats.Points.Value-=price;
		end
	end
end)