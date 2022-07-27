-- Created by Schnidde
local ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local Keys = {

    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,

    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,

    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,

    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,

    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,

    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,

    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,

    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,

    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118

}

local display = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local canSleep = true

		function hintToDisplay(text, bool)
			BeginTextCommandDisplayHelp("STRING")
			AddTextComponentString(text)
			DisplayHelpTextFromStringLabel(0, 0, bool, -1)
		end

		if CanOpenShop() then

			for i=1, #Config.Locations, 1 do
				local carWashLocation = Config.Locations[i]
				local distance = GetDistanceBetweenCoords(coords, carWashLocation, true)

				if distance < 50 then
					DrawMarker(1, carWashLocation, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 0.5, 255, 0, 0, 155, false, false, 2, false, false, false, false)
					canSleep = false
				end

				if distance < 1.5 then
					canSleep = false
					hintToDisplay('Drücke ~INPUT_CONTEXT~ um den illegalen Waffenverkauf zu öffnen', false)

					if IsControlJustReleased(0, 38) then
                        SendNUIMessage({action = "SetPreis1", preis = Config.Preis1})
                        SendNUIMessage({action = "SetPreis2", preis = Config.Preis2})
                        SendNUIMessage({action = "SetPreis3", preis = Config.Preis3})
                        SendNUIMessage({action = "SetLabel1", label = Config.WaffenLabel1})
                        SendNUIMessage({action = "SetLabel2", label = Config.WaffenLabel2})
                        SendNUIMessage({action = "SetLabel3", label = Config.WaffenLabel3})
                        SetDisplay(true)
                        if Config.ServerLogo then
                            SendNUIMessage({action = "showLogo"})
                            Citizen.Wait(5000)
                        else
                            SendNUIMessage({action = "hideLogo"})
                            Citizen.Wait(5000)
                        end
					end
				end
			end

			if canSleep then
				Citizen.Wait(500)
			end

		else
			Citizen.Wait(500)
		end
	end
end)

function CanOpenShop()
	local playerPed = PlayerPedId()

	if IsPedSittingInAnyVehicle(playerPed) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)

		if GetPedInVehicleSeat(vehicle, -1) == playerPed then
			return false
		end
	end

	return true
end

RegisterNUICallback('BuyWeapon1', function()
    local player = PlayerPedId()
    ESX.TriggerServerCallback('sch_weaponshop:canAfford', function(canAfford)
        if canAfford then
            ESX.TriggerServerCallback('sch_weaponshop:buyWaffe1')
            TriggerEvent('notifications', 'rgb(0, 255, 0)', 'WEAPON SALE', 'Du hast ' ..Config.WaffenLabel1.. ' für ' ..Config.Preis1.. '$ gekauft!')
        else
            TriggerEvent('notifications', 'rgb(255, 0, 0)', 'WEAPON SALE', 'Du hast nicht genug Geld dabei!')
        end
    end)
    SetDisplay(false)
end)

RegisterNUICallback('BuyWeapon2', function()
    local player = PlayerPedId()
    ESX.TriggerServerCallback('sch_weaponshop:canAfford2', function(canAfford2)
        if canAfford2 then
            ESX.TriggerServerCallback('sch_weaponshop:buyWaffe2')
            TriggerEvent('notifications', 'rgb(0, 255, 0)', 'WEAPON SALE', 'Du hast ' ..Config.WaffenLabel2.. ' für ' ..Config.Preis2.. '$ gekauft!')
        else
            TriggerEvent('notifications', 'rgb(255, 0, 0)', 'WEAPON SALE', 'Du hast nicht genug Geld dabei!')
        end
    end)
    SetDisplay(false)
end)

RegisterNUICallback('BuyWeapon3', function()
    local player = PlayerPedId()
    ESX.TriggerServerCallback('sch_weaponshop:canAfford3', function(canAfford3)
        if canAfford3 then
            ESX.TriggerServerCallback('sch_weaponshop:buyWaffe3')
            TriggerEvent('notifications', 'rgb(0, 255, 0)', 'WEAPON SALE', 'Du hast ' ..Config.WaffenLabel3.. ' für ' ..Config.Preis3.. '$ gekauft!')
        else
            TriggerEvent('notifications', 'rgb(255, 0, 0)', 'WEAPON SALE', 'Du hast nicht genug Geld dabei!')
        end
    end)
    SetDisplay(false)
end)

RegisterNUICallback("exit", function(data)
    SetDisplay(false)
end)

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end