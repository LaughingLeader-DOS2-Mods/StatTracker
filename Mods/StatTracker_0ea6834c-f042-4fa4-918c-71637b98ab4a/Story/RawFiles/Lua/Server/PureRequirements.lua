
local PathOfBloodFlags = { 
	GLO_PathOfBlood_MurderedInnocent = true,
	GLO_StoleItem = true,
	GLO_PathOfBlood_DisrespectedSoul = true
}
local function IsPure(uuid)
	for flag,_ in pairs(PathOfBloodFlags) do
		if Osi.ObjectGetFlag(uuid,flag) == 1 then
			return false
		end
	end
	return true
end

local _registeredListeners = false
local function RegisterPobListeners()
	Events.Osiris.ObjectFlagSet:Subscribe(function(e)
		if PathOfBloodFlags[e.Flag] then
			Osi.SetTag(e.ObjectGUID, "LLSTAT_PathOfBloodFailed")
		end
	end)

	Events.Osiris.ObjectFlagCleared:Subscribe(function(e)
		if PathOfBloodFlags[e.Flag] then
			if IsPure(e.ObjectGUID) then
				Osi.ClearTag(e.ObjectGUID, "LLSTAT_PathOfBloodFailed")
			end
		end
	end)

	Ext.Osiris.RegisterListener("Proc_AbsorbedSoulJar", 2, "after", function(player, jar)
		SheetManager:ModifyValueByID(GameHelpers.GetCharacter(player), ID.SoulsEaten, 1, ModuleUUID, "Custom")
	end)
	
	Ext.Osiris.RegisterListener("PROC_GLO_SystemicTags_CheckSourceSucking", 1, "after", function(player)
		SheetManager:ModifyValueByID(GameHelpers.GetCharacter(player), ID.SoulsEaten, 1, ModuleUUID, "Custom")
	end)

	_registeredListeners = true
end

Events.Initialized:Subscribe(function(e)
	if Ext.Mod.IsModLoaded(MOD_ORIGINS) then
		if not _registeredListeners then
			RegisterPobListeners()
		end
		for player in GameHelpers.Character.GetPlayers() do
			if IsPure(player.MyGuid) then
				Osi.ClearTag(player.MyGuid, "LLSTAT_PathOfBloodFailed")
			elseif not player:HasTag("LLSTAT_PathOfBloodFailed") then
				Osi.SetTag(player.MyGuid, "LLSTAT_PathOfBloodFailed")
			end
		end
	end
end)

