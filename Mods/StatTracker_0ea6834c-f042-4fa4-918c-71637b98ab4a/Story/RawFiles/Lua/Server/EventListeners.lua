RegisterProtectedOsirisListener("CharacterKilledBy", Data.OsirisEvents.CharacterKilledBy, "after", function(defender, owner, attacker)
	if GameHelpers.Character.IsPlayer(owner) then
		CustomStatSystem:ModifyStat(owner, ID.Kills, 1, ModuleUUID)
	end
end)

RegisterProtectedOsirisListener("CharacterDied", Data.OsirisEvents.CharacterDied, "after", function(character)
	if GameHelpers.Character.IsPlayer(character) then
		CustomStatSystem:ModifyStat(character, ID.Deaths, 1, ModuleUUID)
	end
end)

RegisterProtectedOsirisListener("NRD_OnHeal", Data.OsirisEvents.NRD_OnHeal, "after", function(target, source, amount, handle)
	if amount > 0 and GameHelpers.Character.IsPlayer(source) then
		CustomStatSystem:ModifyStat(source, ID.HealingDone, amount, ModuleUUID)
	end
end)

local hitSource = {}

---@param target EsvCharacter|EsvItem
---@param source EsvCharacter|nil
---@param data HitData
---@param hitStatus EsvStatusHit
RegisterListener("StatusHitEnter", function(target, source, data, hitStatus)
	if source then
		hitSource[data.HitContext.HitId] = source.MyGuid
	end
end)

---@param target EsvCharacter
---@param attacker StatCharacter
---@param hit HitRequest
---@param causeType string
---@param impactDirection number[]
---@param context HitContext
local function OnBeforeCharacterApplyDamage(target, attacker, hit, causeType, impactDirection, context)
	--fprint(LOGLEVEL.TRACE, "[OnBeforeCharacterApplyDamage] context.HitId(%s) hitSource[%s] = %s", context.HitId, context.HitId, hitSource[context.HitId])
	--print("OnBeforeCharacterApplyDamage", target.DisplayName, hit.TotalDamageDone, attacker, (attacker and attacker.Character and attacker.Character.IsPlayer) or "No attacker", hit.DamageDealt, causeType)
	local source = hitSource[context.HitId]
	if source then
		source = Ext.GetGameObject(source)
	end
	if hit.TotalDamageDone > 0 then
		if not source then
			if attacker and attacker.Character then
				source = attacker.Character
			end
		end
		if GameHelpers.Character.IsPlayer(source) then
			CustomStatSystem:ModifyStat(source, ID.TotalDamage, hit.TotalDamageDone)
			local highestHitStat = CustomStatSystem:GetStatByID(ID.LargestHit, ModuleUUID)
			if highestHitStat then
				local amount = highestHitStat:GetValue(source)
				if amount < hit.TotalDamageDone then
					CustomStatSystem:SetStat(source, ID.LargestHit, hit.TotalDamageDone, ModuleUUID)
				end
			end
		end
	end
	if not source and attacker then
		source = attacker.Character
	end
end

RegisterProtectedExtenderListener("BeforeCharacterApplyDamage", OnBeforeCharacterApplyDamage)

RegisterStatusListener(Vars.StatusEvent.Applied, "DRAIN", function(target, status, source, statusType)
	if GameHelpers.Character.IsPlayer(source) then
		CustomStatSystem:ModifyStat(source, ID.SoulsEaten, 1)
	end
end)