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

Events.Osiris.CharacterStoleItem:Subscribe(function (e)
	if e.Amount > 0 and GameHelpers.Character.IsPlayer(e.Character) then
		SheetManager:ModifyValueByID(e.Character, ID.StolenItems, e.Amount, ModuleUUID, "Custom")
	end
end)

Events.Osiris.CrimeIsRegistered:Subscribe(function (e)
	if not IgnoreCrimes[e.CrimeType] then
		for _,v in pairs(e.Criminals) do
			if GameHelpers.Character.IsPlayer(v) then
				SheetManager:ModifyValueByID(v, ID.TotalCrimes, 1, ModuleUUID, "Custom")
				if MurderCrimes[e.CrimeType] then
					SheetManager:ModifyValueByID(v, ID.Murders, 1, ModuleUUID, "Custom")
				end
			end
		end
	end
end)