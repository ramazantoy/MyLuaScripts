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


local function previewItem(btn)

	previewImg.Image=btn.ImageId.Value;
	previewName.Text=btn.ItemName.Value;
	previewPrice.Text=btn.Price.Value;

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


shopRe.OnClientEvent:Connect(function()

	shopFrm.Visible=true;
	ding:Play();
end);

closeButton.Activated:Connect(function()

	shopFrm.Visible=false;
end)

buyBtn.Activated:Connect(function()

	if previewName.Text ~='' then -- nothing selected
		
		print("buying ....",previewName.Text);
		if(player.leaderstats.Points.Value >= tonumber(previewPrice.Text)) then
			shopRe:FireServer(previewName.Text,previewPrice.Text);
		else
			print("Not enough money");

		end

	end
end)
