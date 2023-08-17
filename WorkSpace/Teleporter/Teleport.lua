local padA=script.Parent.TeleporterA.PadA;

local padB=script.Parent.TeleporterB.PadB;

local padC=script.Parent.TeleporterC.PadC;

local soundA=padA.Charge;
local soundB=padB.Charge;
local roof=script.Parent.TeleporterA.RoofA;

local playerServer=game:GetService("Players");

local canTeleport=true;

local coolDown=5;


local function TransLocate(otherPart)
	
	local hrp=otherPart.Parent:FindFirstChild("HumanoidRootPart");
	
	if hrp then
		
		local player=playerServer:GetPlayerFromCharacter(otherPart.Parent);
		
		if player and canTeleport then
			canTeleport=false;
			soundA:Play();
			wait(soundA.TimeLength);
			
			hrp.CFrame=CFrame.new(padB.Position)+ Vector3.new(0,3,0);
			
			padA.BrickColor=BrickColor.Gray();
			padA.Material=Enum.Material.Plastic;
			
			roof.BrickColor=BrickColor.Gray();
			roof.Material=Enum.Material.Plastic;
			
			wait(coolDown);
			soundB:Play();
			wait(soundB.TimeLength);
			canTeleport=true;
			hrp.CFrame=CFrame.new(padC.Position)+ Vector3.new(0,3,0);
			

			padA.BrickColor=BrickColor.new("Lime green");
			padA.Material=Enum.Material.Neon;

			roof.BrickColor=BrickColor.new("Lime green")
			roof.Material=Enum.Material.Neon;
		end
	end
end

padA.Touched:Connect(TransLocate);
