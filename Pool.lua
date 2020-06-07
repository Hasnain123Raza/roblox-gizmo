local CLASS = {}

--// CONSTANTS //--

local GIZMO_TYPES = {
	["BoxHandleAdornment"] = true,
	["ConeHandleAdornment"] = true,
	["CylinderHandleAdornment"] = true,
	["LineHandleAdornment"] = true,
	["SphereHandleAdornment"] = true
}

local DEGENERATE_CFRAME = CFrame.new(0, 10000, 0)

--// VARIABLES //--



--// CONSTRUCTORS //--

function CLASS.new()
	local dataTable = setmetatable(
		{
			freeGizmos = {
				["BoxHandleAdornment"] = {},
				["ConeHandleAdornment"] = {},
				["CylinderHandleAdornment"] = {},
				["LineHandleAdornment"] = {},
				["SphereHandleAdornment"] = {}
			},
			busyGizmos = {
				["BoxHandleAdornment"] = {},
				["ConeHandleAdornment"] = {},
				["CylinderHandleAdornment"] = {},
				["LineHandleAdornment"] = {},
				["SphereHandleAdornment"] = {}
			}
		},
		CLASS
	)
	local proxyTable = setmetatable(
		{
		
		},
		{
			__index = function(self, index)
				return dataTable[index]
			end,
			__newindex = function(self, index, value)
				dataTable[index] = value
			end
		}
	)
	return proxyTable
end

--// METHODS //--

function CLASS:generateGizmo(gizmoType, color, transparency)
	if not (GIZMO_TYPES[gizmoType]) then
		error("Gizmo type not recognized")
	end
	local gizmo
	if (#self.freeGizmos[gizmoType] > 0) then
		gizmo = table.remove(self.freeGizmos[gizmoType])
	else
		gizmo = Instance.new(gizmoType)
		gizmo.Adornee = workspace.Terrain
		gizmo.Parent = workspace.Terrain
	end
	gizmo.Color3 = color
	gizmo.Transparency = transparency
	table.insert(self.busyGizmos[gizmoType], gizmo)
	return gizmo
end

function CLASS:degenerateGizmo(gizmo)
	local index = table.find(self.busyGizmos[gizmo.ClassName], gizmo)
	if (index) then
		table.remove(self.busyGizmos[gizmo.ClassName], index)
	end
	table.insert(self.freeGizmos[gizmo.ClassName], gizmo)
	gizmo.CFrame = DEGENERATE_CFRAME
end

function CLASS:freeAllGizmos()
	for _, gizmosCollectionByType in pairs(self.busyGizmos) do
		for counter = #gizmosCollectionByType, 1, -1 do
			self:degenerateGizmo(gizmosCollectionByType[counter])
		end
	end
end

--// INSTRUCTIONS //--

CLASS.__index = CLASS

return CLASS
