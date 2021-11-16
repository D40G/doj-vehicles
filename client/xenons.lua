
local QBCore = exports['qb-core']:GetCoreObject()

--========================================================== Headlights
RegisterNetEvent('doj:client:applyXenons', function()
	local playerPed		= PlayerPedId()
    local coords		= GetEntityCoords(playerPed)

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
			CreateThread(function()
                local finished = exports["np-skillbar"]:taskBar(1700,math.random(5,10))
                if finished ~= 100 then
					QBCore.Functions.Notify("Xenon Headlight installation failed!", "error", 3500)
					ClearPedTasks(playerPed) 
				else
					QBCore.Functions.Notify("Success! Installing Xenon Headlights", "success", 3500)
					FreezeEntityPosition(playerPed, true)
					time = math.random(3000,7000)
					TriggerEvent('pogressBar:drawBar', time, 'Installing Xenon Headlights')
					Wait(time)
					SetVehicleModKit(vehicle, 0)
					ToggleVehicleMod(vehicle, 22, true)
					ClearPedTasks(playerPed)
					FreezeEntityPosition(playerPed, false)
					CurrentVehicleData = QBCore.Functions.GetVehicleProperties(vehicle)
					TriggerServerEvent('updateVehicle', CurrentVehicleData)
					TriggerServerEvent('doj:server:removeXenon')
                end
			end)
		end
	else
		QBCore.Functions.Notify("There is no vehicle nearby", "error", 3500)
	end
end)