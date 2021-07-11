ID = {
	Kills = "LLSTATS_Kills",
	Deaths = "LLSTATS_Deaths",
	LargestHit = "LLSTATS_LargestHit",
	TotalDamage = "LLSTATS_TotalDamage",
	HealingDone = "LLSTATS_HealingDone",
	TotalCrimes = "LLSTATS_TotalCrimes",
	StolenItems = "LLSTATS_StolenItems",
	Murders = "LLSTATS_Murders",
	SoulsEaten = "LLSTATS_SoulsEaten",
}

--Mods.LeaderLib.CustomStatSystem.Stats["0ea6834c-f042-4fa4-918c-71637b98ab4a"].LLSTATS_TotalDamage:SetValue(host.MyGuid, 9999999999999999)
--Mods.LeaderLib.CustomStatSystem.Stats["0ea6834c-f042-4fa4-918c-71637b98ab4a"].LLSTATS_TotalDamage:SetValue(host.MyGuid, math.maxinteger)
--print(Mods.LeaderLib.CustomStatSystem.Stats["0ea6834c-f042-4fa4-918c-71637b98ab4a"].LLSTATS_TotalDamage:GetValue(host.MyGuid))
--local player = Ext.GetCharacter(host.MyGuid); player:SetCustomStat("e2d8e73d-eb9b-4088-a938-3b832abda912", 9999999999999999); print(player:GetCustomStat("e2d8e73d-eb9b-4088-a938-3b832abda912"));
OriginsCampaignEnabled = false

Ext.Require("Shared/PointListeners.lua")

Ext.RegisterListener("SessionLoaded", function()
	OriginsCampaignEnabled = Ext.IsModLoaded("1301db3d-1f54-4e98-9be5-5094030916e4")
	print(Ext.IsModLoaded("1301db3d-1f54-4e98-9be5-5094030916e4"))
end)