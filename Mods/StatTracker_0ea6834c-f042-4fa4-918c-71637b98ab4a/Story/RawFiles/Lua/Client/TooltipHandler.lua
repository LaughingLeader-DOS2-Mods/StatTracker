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
	if OriginsCampaignEnabled and PathOfBloodRelatedStats[stat.ID] then
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

Game.Tooltip.RegisterListener("CustomStat", nil, OnCustomStatTooltip)