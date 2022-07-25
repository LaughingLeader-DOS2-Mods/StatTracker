
-- if Ext.IsDeveloperMode() then
-- 	SheetManager.CustomStats:RegisterAvailablePointsChangedListener(ID, function(id, stat, character, previousPoints, currentPoints)
-- 		fprint(LOGLEVEL.DEFAULT, "[OnAvailablePointsChanged:%s] Stat(%s) Character(%s) %s => %s [%s]", id, stat.ID, character.DisplayName, previousPoints, currentPoints, isClient and "CLIENT" or "SERVER")
-- 	end)

-- 	SheetManager.CustomStats:RegisterStatValueChangedListener(ID, function(id, stat, character, previousPoints, currentPoints, isClientSide)
-- 		fprint(LOGLEVEL.DEFAULT, "[OnStatValueChanged:%s] Stat(%s) Character(%s) %s => %s [%s]", id, stat.ID, character.DisplayName, previousPoints, currentPoints, isClientSide and "CLIENT" or "SERVER")
-- 	end)
-- end