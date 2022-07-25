
local PathOfBloodFlags = { 
	GLO_PathOfBlood_MurderedInnocent = true,
	GLO_StoleItem = true,
	GLO_PathOfBlood_DisrespectedSoul = true
}
local function IsPure(uuid)
	for flag,_ in pairs(PathOfBloodFlags) do
		if ObjectGetFlag(uuid,flag) == 1 then
			return false
		end
	end
	return true
end

local _registeredListeners = false
local function RegisterPobListeners()
	Ext.RegisterOsirisListener("ObjectFlagSet", 3, "after", function(flag, object, instance)
		if PathOfBloodFlags[flag] then
			SetTag(object, "LLSTAT_PathOfBloodFailed")
		end
	end)
	
	Ext.RegisterOsirisListener("ObjectFlagCleared", 3, "after", function(flag, object, instance)
		if PathOfBloodFlags[flag] then
			if IsPure(object) then
				ClearTag(object, "LLSTAT_PathOfBloodFailed")
			end
		end
	end)

	Ext.RegisterOsirisListener("Proc_AbsorbedSoulJar", 2, "after", function(player, jar)
		SheetManager:ModifyValueByID(StringHelpers.GetUUID(player), ID.SoulsEaten, 1, ModuleUUID, "Custom")
	end)
	
	Ext.RegisterOsirisListener("PROC_GLO_SystemicTags_CheckSourceSucking", 1, "after", function(player)
		SheetManager:ModifyValueByID(StringHelpers.GetUUID(player), ID.SoulsEaten, 1, ModuleUUID, "Custom")
	end)

	_registeredListeners = true
end

local MOD_ORIGINS = "1301db3d-1f54-4e98-9be5-5094030916e4"

Events.Initialized:Subscribe(function(e)
	if Ext.IsModLoaded(MOD_ORIGINS) then
		if not _registeredListeners then
			RegisterPobListeners()
		end
		for player in GameHelpers.Character.GetPlayers() do
			if IsPure(player.MyGuid) then
				ClearTag(player.MyGuid, "LLSTAT_PathOfBloodFailed")
			elseif not player:HasTag("LLSTAT_PathOfBloodFailed") then
				SetTag(player.MyGuid, "LLSTAT_PathOfBloodFailed")
			end
		end
	end
end)

