local CrimeType = {
	ActiveSummon = "ActiveSummon",
	Assault = "Assault",
	AttackAnimal = "AttackAnimal",
	Diseased = "Diseased",
	EmptyPocketNoticed = "EmptyPocketNoticed",
	IncapacitatedAssault = "IncapacitatedAssault",
	ItemDestroy = "ItemDestroy",
	KilledAnimal = "KilledAnimal",
	LoudContinuousNoise = "LoudContinuousNoise",
	MoveForbiddenItem = "MoveForbiddenItem",
	Murder = "Murder",
	PickPocketFailed = "PickPocketFailed",
	Polymorphed = "Polymorphed",
	Smelly = "Smelly",
	Sneaking = "Sneaking",
	SneakKilledAnimal = "SneakKilledAnimal",
	SneakMurder = "SneakMurder",
	SneakUseForbiddenItem = "SneakUseForbiddenItem",
	SourceMagic = "SourceMagic",
	Steal = "Steal",
	SummonAssault = "SummonAssault",
	SummonAttackAnimal = "SummonAttackAnimal",
	SummonItemDestroy = "SummonItemDestroy",
	SummonKilledAnimal = "SummonKilledAnimal",
	SummonMoveForbiddenItem = "SummonMoveForbiddenItem",
	SummonMurder = "SummonMurder",
	SummonVandalise = "SummonVandalise",
	SummonVandaliseNoOwner = "SummonVandaliseNoOwner",
	TeleportPlayerDialog = "TeleportPlayerDialog",
	Trespassing = "Trespassing",
	UseForbiddenItem = "UseForbiddenItem",
	Vandalise = "Vandalise",
	VandaliseNoOwner = "VandaliseNoOwner",
	WeaponsDrawn = "WeaponsDrawn",
}

local MurderCrimes = {
	--KilledAnimal = true,
	Murder = true,
	SneakMurder = true,
	SummonMurder = true,
}

local IgnoreCrimes = {
	ActiveSummon = true,
	Diseased = true,
	EmptyPocketNoticed = true,
	Smelly = true,
	Sneaking = true,
	TeleportPlayerDialog = true,
	UseForbiddenItem = true,
	WeaponsDrawn = true,
}

Ext.RegisterOsirisListener("CharacterStoleItem", Data.OsirisEvents.CharacterStoleItem, "after", function(character, item, x, y, z, victim, container, amount)
	if amount > 0 and GameHelpers.Character.IsPlayer(character) then
		CustomStatSystem:ModifyStat(character, ID.StolenItems, amount, ModuleUUID)
	end
end)

Ext.RegisterOsirisListener("CrimeIsRegistered", Data.OsirisEvents.CrimeIsRegistered, "after", function(victim, crimeType, crimeId, evidence, ...)
	if not IgnoreCrimes[crimeType] then
		local criminals = {...}
		if #criminals > 0 then
			for _,uuid in pairs(criminals) do
				if not StringHelpers.IsNullOrEmpty(uuid) and GameHelpers.Character.IsPlayer(uuid) then
					CustomStatSystem:ModifyStat(uuid, ID.TotalCrimes, 1, ModuleUUID)
					if MurderCrimes[crimeType] then
						CustomStatSystem:ModifyStat(uuid, ID.Murders, 1, ModuleUUID)
					end
				end
			end
		end
	end
end)