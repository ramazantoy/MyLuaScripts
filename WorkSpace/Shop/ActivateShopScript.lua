local click=script.Parent.Click;

local rs=game:GetService("ReplicatedStorage");

local shopRe=rs:WaitForChild("ShopRe");

local equipUtils=require(game.ServerScriptService.EquipStorageUtils);


click.MouseClick:Connect(function(player)
	
	
	shopRe:FireClient(player);
	
	
end)

local function makeInfoTable(item)
	
	local itemTable={Name=item.Name}
	local config=item:FindFirstChild("Configuration");
	
	if config then
		
		for i,v in pairs(config:GetChildren()) do
			itemTable[v.Name]=v.Value;
		end
	end
	return itemTable;
end

shopRe.OnServerEvent:Connect(function(player,itemName)
	
	local item=rs:WaitForChild(itemName);
	
	if item then
		local itemClone=item:Clone();
		local itemTbl=makeInfoTable(itemClone);
		itemClone.Parent=player.Backpack;
		local price=itemClone.Price.Value;
		
		player.leaderstats.Points.Value-=price;
		equipUtils:addItemToPlayersInventory(player,itemTbl);
	
	end
end)