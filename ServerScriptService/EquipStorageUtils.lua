local equipUtils = {};


--data table that has the equipment info for each player
local equipmentTbl={};


local rs=game:GetService("ReplicatedStorage");

--called when purchased

function equipUtils:addItemToPlayersInventory(player,itemInfoTbl)
	
	if not equipmentTbl[player] then
		equipmentTbl[player]={}
	end
	table.insert(equipmentTbl[player],itemInfoTbl);
	print("equipment table = ",equipmentTbl);
end

--called when players enter the game

function equipUtils:updatePlayerWithDbInfo(player,data)
	
	equipmentTbl[player]=data;
	
end

--equip player, data is already in table, but player doesn't have it 

function equipUtils:equipPlayer(player)
	if equipmentTbl[player] then
		
		local char=player.Character or player.CharacterAdded:Wait();
		
		for i,v in pairs(equipmentTbl[player]) do
			local bpItem=player.Backpack:FindFirstChild(v.Name);
			local eItem=char:FindFirstChild(v.Name);
			
			if not bpItem and not eItem then
				local item=rs:WaitForChild(v.Name):Clone();
				item.Parent=player.Backpack;
			end
		end
	end
end

function equipUtils:getPlayerItemsToSave(player)
	
	return equipmentTbl[player];
end
	

--when players removed from game, remove from into table

function equipUtils:removePlayer(player)
	
	equipmentTbl[player]=nil;
	
end

return equipUtils;
