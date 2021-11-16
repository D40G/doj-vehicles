
local QBCore = exports['qb-core']:GetCoreObject()

--========================================================== Turbo
RegisterNetEvent('doj:client:applyTurbo', function()
	local playerPed	= PlayerPedId()
    local coords	= GetEntityCoords(playerPed)
    if IsPedSittingInAnyVehicle(playerPed) then
		QBCore.Functions.Notify("Cannot Install while inside vehicle", "error", 3500)
        ClearPedTasks(playerPed)
        return
    end
	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.5) then
		local vehicle = nil
		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, 71)
		end
		if DoesEntityExist(vehicle) then
			playAnim("mini@repair", "fixing_a_ped", 35000)
			SetVehicleEngineOn(vehicle, false, false,true)
			SetVehicleDoorOpen(vehicle, 4, false, false)
			local finished = exports["np-skillbar"]:taskBar(1700,math.random(3,7))
			if finished ~= 100 then
				QBCore.Functions.Notify("Turbo installation failed!", "error", 3500)
				ClearPedTasks(playerPed)
			else
				QBCore.Functions.Notify("Success! Installing Turbo", "success", 3500)
				FreezeEntityPosition(playerPed, true)
				time = math.random(7000,10000)
				TriggerEvent('pogressBar:drawBar', time, 'Installing Turbo')
				Wait(time)
				SetVehicleModKit(vehicle, 0)
				ToggleVehicleMod(vehicle, 18, true)
				SetVehicleEngineOn(vehicle, true, true)
				SetVehicleDoorShut(vehicle, 4, false)
				ClearPedTasks(playerPed)
				FreezeEntityPosition(playerPed, false)
				SetVehicleEngineOn(vehicle, false, false,false)
				CurrentVehicleData = QBCore.Functions.GetVehicleProperties(vehicle)
				TriggerServerEvent('updateVehicle', CurrentVehicleData)
				TriggerServerEvent('doj:server:removeTurbo')
			end
		end
	else
		QBCore.Functions.Notify("There is no vehicle nearby", "error", 3500)
	end
end)

function playAnim(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do 
      Wait(0) 
    end
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
    RemoveAnimDict(animDict)
end