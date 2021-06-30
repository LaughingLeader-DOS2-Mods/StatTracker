local PathOfBloodRelatedStats = {
	[ID.Murders] = true,
	[ID.Kills] = true,
	[ID.SoulsEaten] = true,
	[ID.StolenItems] = true,
}

---@param character EclCharacter
---@param stat CustomStatData
---@param tooltip TooltipData
local function OnCustomStatTooltip(character, stat, tooltip)
	if PathOfBloodRelatedStats[stat.ID] then
		if character:HasTag("LLSTAT_PathOfBloodFailed") then
			tooltip:AppendElement({
				Type="StatsTalentsMalus",
				Label = GameHelpers.GetStringKeyText("LLSTAT_PathOfBloodFailed", "Impure")
			})
		else
			tooltip:AppendElement({
				Type="StatsTalentsBoost",
				Label = GameHelpers.GetStringKeyText("PURE_DisplayName", "Pure")
			})
		end
	end
end

local stats = {
	ID.Murders,
	ID.Kills,
	ID.SoulsEaten,
	ID.StolenItems,
}

local registeredListeners = false

Ext.RegisterListener("SessionLoaded", function()
	if Ext.IsModLoaded("1301db3d-1f54-4e98-9be5-5094030916e4") and not registeredListeners then
		CustomStatSystem:RegisterStatAddedHandler(stats, function(id, stat, character, stat_mc)
			if not character:HasTag("LLSTAT_PathOfBloodFailed") then
				stat_mc.label_txt.htmlText = string.format("<font color='#0C3D10'>%s</font>", stat_mc.label_txt.htmlText)
				--stat_mc.label_txt.htmlText = string.format("<font color='#7a1221'>%s</font>", stat_mc.label_txt.htmlText)
			end
		end)
		Game.Tooltip.RegisterListener("CustomStat", nil, OnCustomStatTooltip)
		registeredListeners = true
	end
end)