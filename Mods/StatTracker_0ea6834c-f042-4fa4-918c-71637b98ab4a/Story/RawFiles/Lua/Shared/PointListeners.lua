if Ext.IsDeveloperMode() then
	CustomStatSystem:RegisterAvailablePointsChangedListener(ID, function(id, stat, character, previousPoints, currentPoints)
		fprint(LOGLEVEL.DEFAULT, "[OnAvailablePointsChanged:%s] Stat(%s) Character(%s) %s => %s [%s]", id, stat.UUID, character.DisplayName, previousPoints, currentPoints, isClient and "CLIENT" or "SERVER")
	end)

	CustomStatSystem:RegisterStatValueChangedListener(ID, function(id, stat, character, previousPoints, currentPoints)
		fprint(LOGLEVEL.DEFAULT, "[OnStatValueChanged:%s] Stat(%s) Character(%s) %s => %s [%s]", id, stat.UUID, character.DisplayName, previousPoints, currentPoints, isClient and "CLIENT" or "SERVER")
	end)
end

CustomStatSystem:RegisterStatValueChangedListener("MyMod_Fear", function(id, stat, character, previousPoints, currentPoints)
	fprint(LOGLEVEL.DEFAULT, "[OnStatValueChanged:%s] Stat(%s) Character(%s) %s => %s [%s]", id, stat.UUID, character.DisplayName, previousPoints, currentPoints, isClient and "CLIENT" or "SERVER")
end)