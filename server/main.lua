
local QBCore = exports['qb-core']:GetCoreObject()

--========================================================== Turbo
RegisterNetEvent('doj:server:removeTurbo', function()
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.RemoveItem('turbo', 1)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['turbo'], "remove", 1)
    TriggerClientEvent('QBCore:Notify', source, "Turbo has been installed", 'success')
end)

QBCore.Functions.CreateUseableItem("turbo", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	TriggerClientEvent("doj:client:applyTurbo", source)
end)

--========================================================== Headlights
RegisterNetEvent('doj:server:removeXenon', function()
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.RemoveItem('headlights', 1)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['headlights'], "remove", 1)
    TriggerClientEvent('QBCore:Notify', source, "Xenon Headlights Installed", 'success')
end)

QBCore.Functions.CreateUseableItem("headlights", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	TriggerClientEvent("doj:client:applyXenons", source)
end)


--========================================================== Tire Repair
QBCore.Functions.CreateUseableItem("tire", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('doj:client:replacePoppedTire', source)
end)

RegisterServerEvent('doj:server:removeTire', function()
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.RemoveItem('tire', 1)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['tire'], "remove", 1)
    TriggerClientEvent('QBCore:Notify', source, "Tire replaced", 'success')
end)

--========================================================== suspension
QBCore.Functions.CreateUseableItem("coilovers", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('doj:client:coiloverMenu', source)
end)

-- RegisterServerEvent('doj:server:removeCoilovers', function()
--     local Player = QBCore.Functions.GetPlayer(source)
--     Player.Functions.RemoveItem('coilovers', 1)
--     TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['coilovers'], "remove", 1)
--     TriggerClientEvent('QBCore:Notify', source, "suspension installed", 'success')
-- end)





