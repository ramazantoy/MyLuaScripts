local equipUtils = {};


--data table that has the equipment info for each player
local equipmentTbl={};




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
	
	
end

--equip player, data is already in table, but player doesn't have it 

function equipUtils:equipPlayer(player)
	
	
end

--when players removed from game, remove from into table

function equipUtils:removePlayer(player)
	
	
end

return equipUtils;
