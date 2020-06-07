local LIBRARY = {}

--// SERVICES //--

local RUN_SERVICE = game:GetService("RunService")

--// CONSTANTS //--

local POOL = require(script.Pool).new()

local NORMALID_TO_DIRECTION = {
	[Enum.NormalId.Right] = Vector3.new(1, 0, 0),
	[Enum.NormalId.Top] = Vector3.new(0, 1, 0),
	[Enum.NormalId.Front] = Vector3.new(0, 0, 1),
	[Enum.NormalId.Left] = Vector3.new(-1, 0, 0),
	[Enum.NormalId.Bottom] = Vector3.new(0, -1, 0),
	[Enum.NormalId.Back] = Vector3.new(0, 0, -1),
}

--// VARIABLES //--

local gizmoColor = Color3.new()
local gizmoTransparency = 0

LIBRARY.onDrawBindableEvent = Instance.new("BindableEvent")
LIBRARY.onDraw = LIBRARY.onDrawBindableEvent.Event

--// FUNCTIONS //--

local function toCFrame(coordinates)
	if (typeof(coordinates) == "CFrame") then
		return coordinates
	elseif (typeof(coordinates) == "Vector3") then
		return CFrame.new(coordinates)
	else
		error("Could not resolve coordinates")
	end
end

function LIBRARY.setColor(color)
	gizmoColor = color
end

function LIBRARY.setTransparency(transparency)
	gizmoTransparency = transparency
end

--// DRAW FUNCTIONS //--

-- Box Adornment Functions --
function LIBRARY.drawBox(cframe, size)
	cframe = toCFrame(cframe)
	local gizmo = POOL:generateGizmo("BoxHandleAdornment", gizmoColor, gizmoTransparency)
	gizmo.CFrame = cframe
	gizmo.Size = size
end

function LIBRARY.drawRegion3(region3)
	LIBRARY.drawBox(region3.CFrame, region3.Size)
end
----

-- Cone Adornment Functions --
function LIBRARY.drawCone(cframe, radius, height)
	cframe = toCFrame(cframe)
	local gizmo = POOL:generateGizmo("ConeHandleAdornment", gizmoColor, gizmoTransparency)
	gizmo.CFrame = cframe
	gizmo.Radius = radius
	gizmo.Height = height
end

function LIBRARY.drawSpotLight(spotLight)
	local spotLightParentCFrame = spotLight.Parent.CFrame
	local spotLightDirection = (spotLightParentCFrame - spotLightParentCFrame.p) * NORMALID_TO_DIRECTION[spotLight.Face] * ((spotLight.Face == Enum.NormalId.Front or spotLight.Face == Enum.NormalId.Back) and (-1) or (1))
	local cframe = CFrame.new(spotLightParentCFrame.p, spotLightParentCFrame.p - spotLightDirection) * CFrame.new(0, 0, spotLight.Range)
	local radius = math.tan(math.rad(spotLight.Angle/2)) * spotLight.Range
	local height = spotLight.Range
	LIBRARY.drawCone(cframe, radius, height)
end
----

-- Cylinder Adornment Functions --
function LIBRARY.drawCylinder(cframe, radius, height)
	cframe = toCFrame(cframe)
	local gizmo = POOL:generateGizmo("CylinderHandleAdornment", gizmoColor, gizmoTransparency)
	gizmo.CFrame = cframe
	gizmo.Radius = radius
	gizmo.Height = height
end

function LIBRARY.drawLine(startPosition, endPosition, radius)
	local distance = (startPosition - endPosition).Magnitude
	local cframe = CFrame.new(startPosition, endPosition) * CFrame.new(0, 0, -distance/2)
	LIBRARY.drawCylinder(cframe, radius, distance)
end

function LIBRARY.drawRay(ray, radius)
	LIBRARY.drawLine(ray.Origin, ray.Origin + ray.Direction, radius)
end
----

-- Line Adornment Functions --
function LIBRARY.drawLinePrimitive(cframe, thickness, length)
	cframe = toCFrame(cframe)
	local gizmo = POOL:generateGizmo("LineHandleAdornment", gizmoColor, gizmoTransparency)
	gizmo.CFrame = cframe
	gizmo.Thickness = thickness
	gizmo.Length = length
end
----

-- Sphere Adornment Functions --
function LIBRARY.drawSphere(cframe, radius)
	cframe = toCFrame(cframe)
	local gizmo = POOL:generateGizmo("SphereHandleAdornment", gizmoColor, gizmoTransparency)
	gizmo.CFrame = cframe
	gizmo.Radius = radius
end

function LIBRARY.drawPointLight(pointLight)
	LIBRARY.drawSphere(pointLight.Parent.Position, pointLight.Range)
end
----

--// INSTRUCTIONS //--

RUN_SERVICE:BindToRenderStep(
	"GIZMO_UPDATE",
	Enum.RenderPriority.Camera.Value - 1,
	function()
		POOL:freeAllGizmos()
		LIBRARY.onDrawBindableEvent:Fire(LIBRARY)
	end
)

return LIBRARY
