ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('sch_weaponshop:canAfford', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
		if xPlayer.getMoney() >= Config.Preis1 then
			xPlayer.removeMoney(Config.Preis1)
			cb(true)
		else
			TriggerEvent('notifications', 'rgb(255, 0, 0)', 'WEAPON SALE', 'Du hast nicht genug Geld dabei!')
			cb(false)
		end
end)

ESX.RegisterServerCallback('sch_weaponshop:canAfford2', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
		if xPlayer.getMoney() >= Config.Preis2 then
			xPlayer.removeMoney(Config.Preis2)
			cb(true)
		else
			TriggerEvent('notifications', 'rgb(255, 0, 0)', 'WEAPON SALE', 'Du hast nicht genug Geld dabei!')
			cb(false)
		end
end)

ESX.RegisterServerCallback('sch_weaponshop:canAfford3', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
		if xPlayer.getMoney() >= Config.Preis3 then
			xPlayer.removeMoney(Config.Preis3)
			cb(true)
		else
			TriggerEvent('notifications', 'rgb(255, 0, 0)', 'WEAPON SALE', 'Du hast nicht genug Geld dabei!')
			cb(false)
		end
end)

ESX.RegisterServerCallback('sch_weaponshop:buyWaffe1', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addWeapon(Config.Waffe1, 250)
end)

ESX.RegisterServerCallback('sch_weaponshop:buyWaffe2', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addWeapon(Config.Waffe2, 250)
end)

ESX.RegisterServerCallback('sch_weaponshop:buyWaffe3', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addWeapon(Config.Waffe3, 250)
end)