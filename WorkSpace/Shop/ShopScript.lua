local shopFrm=script.Parent;
shopFrm.Visible=false;

local rs=game:GetService("ReplicatedStorage");

local shopRe=rs:WaitForChild("ShopRe");

local closeButton=shopFrm.TopBarFrm.CloseBtn;

local ding=shopFrm:WaitForChild("Ding");

local itemsFrame=shopFrm:WaitForChild("ItemsFrame");

local btn ={};

local previewImg=shopFrm.ToBuyFrm.ImgLbl;

local previewName=shopFrm.ToBuyFrm.NameLbl;

local previewPrice=shopFrm.ToBuyFrm.PriceLbl;


local player=game:GetService("Players").LocalPlayer;

local buyBtn=shopFrm.ToBuyFrm.BuyBtn;



local msgLbl=shopFrm.TopBarFrm.MsgLbl;


local function previewItem(btn)

	previewImg.Image=btn.ImageId.Value;
	previewName.Text=btn.ItemName.Value;
	previewPrice.Text=btn.Price.Value;

end
local function clearFields()

	previewImg.Image='';
	previewName.Text='';
	previewPrice.Text='';
	msgLbl.Text='';

end

for i,v in pairs(itemsFrame:GetChildren()) do

	if v:IsA("TextButton") then

		v.Text=v.ItemName.Value;

		v.Activated:Connect(function()

			previewItem(v);
		end)
		table.insert(btn,v);
	end
end

local function isOwned(player,item)

	local char=player.Character or player.CharacterAdded:Wait();
	local ownedItem=char:FindFirstChild(item);
	if ownedItem then
		msgLbl.Text="Found the item! It was equipped!"
		return true;
	end
	ownedItem=player.Backpack:FindFirstChild(item);
	if ownedItem then
		msgLbl.Text="Found the item! It was on Backpack!"
		return true;
	end
end


shopRe.OnClientEvent:Connect(function()

	shopFrm.Visible=true;
	clearFields();
	ding:Play();
end);

closeButton.Activated:Connect(function()

	shopFrm.Visible=false;
end)

buyBtn.Activated:Connect(function()

	if previewName.Text ~='' then -- nothing selected

		if not isOwned(player,previewName.Text) then
			
			
			if(player.leaderstats.Points.Value >= tonumber(previewPrice.Text)) then
				
				shopRe:FireServer(previewName.Text,previewPrice.Text);
				clearFields();
				shopFrm.Visible=false;
				
			else
				
				msgLbl.Text="Not enough money!";
				
				
			end
		end
	end 
	--something was selected
end)
