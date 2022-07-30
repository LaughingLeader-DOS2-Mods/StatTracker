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
	if stat and PathOfBloodRelatedStats[stat.ID] then
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

Ext.Events.SessionLoaded:Subscribe(function (e)
	Game.Tooltip.Register.CustomStat(OnCustomStatTooltip)

	if Ext.IsModLoaded(MOD_ORIGINS) then
		local isMatch = function (args)
			return args.EntryType == "SheetCustomStatData" and PathOfBloodRelatedStats[args.ID] == true
		end
		SheetManager.Events.OnEntryAddedToUI:Subscribe(function (e)
			if not e.Character:HasTag("LLSTAT_PathOfBloodFailed") then
				local text = e.MovieClip.label_txt.htmlText
				e.MovieClip.label_txt.htmlText = string.format("<font color='#0C3D10'>%s</font>", text)
				--stat_mc.label_txt.htmlText = string.format("<font color='#7a1221'>%s</font>", stat_mc.label_txt.htmlText)
			end
		end, {MatchArgs=isMatch})
	end
end)