RegisterProtectedOsirisListener("CharacterKilledBy", Data.OsirisEvents.CharacterKilledBy, "after", function(defender, owner, attacker)
	if GameHelpers.Character.IsPlayer(owner) then
		SheetManager:ModifyValueByID(owner, ID.Kills, 1, ModuleUUID, "Custom")
	end
end)

RegisterProtectedOsirisListener("CharacterDied", Data.OsirisEvents.CharacterDied, "after", function(character)
	if GameHelpers.Character.IsPlayer(character) then
		SheetManager:ModifyValueByID(character, ID.Deaths, 1, ModuleUUID, "Custom")
	end
end)

--Low priority, in case a mod modifies the heal amount
Events.OnHeal:Subscribe(function (e)
	if e.Heal.HealAmount > 0 and GameHelpers.Character.IsPlayer(e.Source) then
		SheetManager:ModifyValueByID(e.Source, ID.HealingDone, e.Heal.HealAmount, ModuleUUID, "Custom")
	end
end, {Priority=1})

local hitSource = {}

Events.OnHit:Subscribe(function (e)
	if e.Source then
		hitSource[e.HitContext.Id] = e.Source.MyGuid
	end
end)

Ext.Events.BeforeCharacterApplyDamage:Subscribe(function (e)
	local source = hitSource[e.Context.Id]
	if source then
		source = GameHelpers.TryGetObject(source)
	end
	if not source and e.Attacker and GameHelpers.Ext.ObjectIsStatCharacter(e.Attacker) then
		source = e.Attacker.Character
	end
	if source and e.Hit.TotalDamageDone > 0 then
		---@cast source EsvCharacter
		if GameHelpers.Character.IsPlayer(source) then
			SheetManager:ModifyValueByID(source, ID.TotalDamage, e.Hit.TotalDamageDone, ModuleUUID, "Custom")
			local highestHitStat = SheetManager:GetEntryByID(ID.LargestHit, ModuleUUID, "Custom")
			if highestHitStat then
				local amount = highestHitStat:GetValue(source)
				if amount < e.Hit.TotalDamageDone then
					highestHitStat:SetValue(source, e.Hit.TotalDamageDone)
				end
			end
		end
	end
end)

StatusManager.Subscribe.Applied("DRAIN", function (e)
	if GameHelpers.Character.IsPlayer(e.Source) then
		SheetManager:ModifyValueByID(e.Source, ID.SoulsEaten, 1, ModuleUUID, "Custom")
	end
end)