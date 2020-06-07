--// CONSTANTS //--

local GIZMOS = require(script.Parent.Gizmos)

--// VARIABLES //--



--// INSTRUCTIONS //--

GIZMOS.onDraw:Connect(function(g)
	g.setColor(Color3.new(1, 1, 1))
	g.setTransparency(0.5)
	
	g.drawSphere(Vector3.new(0, 5, 0), 1)
	
end)
