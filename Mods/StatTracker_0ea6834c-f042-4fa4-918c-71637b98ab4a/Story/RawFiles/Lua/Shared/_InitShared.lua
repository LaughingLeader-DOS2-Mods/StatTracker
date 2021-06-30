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

OriginsCampaignEnabled = false

Ext.Require("Shared/PointListeners.lua")

Ext.RegisterListener("SessionLoaded", function()
	OriginsCampaignEnabled = Ext.IsModLoaded("1301db3d-1f54-4e98-9be5-5094030916e4")
	print(Ext.IsModLoaded("1301db3d-1f54-4e98-9be5-5094030916e4"))
end)