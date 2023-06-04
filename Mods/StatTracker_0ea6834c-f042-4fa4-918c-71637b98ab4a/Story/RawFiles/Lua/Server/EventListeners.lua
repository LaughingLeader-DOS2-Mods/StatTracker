Events.Osiris.CharacterKilledBy:Subscribe(function (e)
	if GameHelpers.Character.IsPlayer(e.Attacker) and e.Defender.OwnerHandle ~= e.AttackerOwner.Handle then
		SheetManager:ModifyValueByID(e.Attacker, ID.Kills, 1, ModuleUUID, "Custom")
	end
end)

Events.CharacterDied:Subscribe(function (e)
	if GameHelpers.Character.IsPlayer(e.Character) then
		SheetManager:ModifyValueByID(e.Character, ID.Deaths, 1, ModuleUUID, "Custom")
	end
end, {MatchArgs={State="Died"}})

--Low priority, in case a mod modifies the heal amount
Events.OnHeal:Subscribe(function (e)
	if e.Status.HealAmount > 0 and GameHelpers.Character.IsPlayer(e.Source) then
		SheetManager:ModifyValueByID(e.Source, ID.HealingDone, e.Status.HealAmount, ModuleUUID, "Custom")
	end
end, {Priority=1, MatchArgs={StatusType="HEAL"}})

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