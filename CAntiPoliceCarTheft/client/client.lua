local QBCore = exports['qb-core']:GetCoreObject()
local vehicleJobs = Config.Vehicles
CreateThread(function()
    while true do
        Wait(Config.SystemWait)  
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped, false)

        if vehicle ~= 0 and GetPedInVehicleSeat(vehicle, -1) == ped then
            local vehModel = GetEntityModel(vehicle)
            if vehicleJobs[vehModel] then
                local allowedJobs = vehicleJobs[vehModel]

                local playerData = QBCore.Functions.GetPlayerData()
                local playerJob = playerData.job.name
                
                local isAllowed = false
                for _, job in pairs(allowedJobs) do
                    if playerJob == job then
                        isAllowed = true
                        break
                    end
                end
                
                if not isAllowed then
                    TaskLeaveVehicle(ped, vehicle, 16)
                    if Config.Notify.QBCoreNotify then
                        QBCore.Functions.Notify(Config.Notify.Message, Config.Notify.Type)
                    else
                        local exportResource = Config.Notify.Custom.ExportResourceName
                        local exportFunction = Config.Notify.Custom.ExportFunctionName
                        exports[exportResource][exportFunction](Config.Notify.Message, Config.Notify.Type, Config.Notify.Time)
                    end
                    
                    local playerId = GetPlayerServerId(PlayerId())
                    local playerName = GetPlayerName(PlayerId())
                    local vehName = GetDisplayNameFromVehicleModel(vehModel)
                    local logMessage = string.format("Oyuncu: %s (ID: %d) bu aracı sürme yetkisine sahip değil: %s", playerName, playerId, vehName)

                    TriggerServerEvent('SendDiscordLog', "Devlet Aracı Çalma", logMessage, 16711680)
                end
            end
        end
    end
end)