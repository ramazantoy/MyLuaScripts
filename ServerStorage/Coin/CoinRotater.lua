local coin=script.Parent;
local canRotate=coin.CanRotate;

local function Rotate()
	
	while canRotate.Value do
		coin.Orientation=coin.Orientation+Vector3.new(0,10,0);
		wait();
	end
end

Rotate();

