local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('SendDiscordLog')
AddEventHandler('SendDiscordLog', function(title, message, color)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local PlayerData = Player.PlayerData
    local srcSteamID = QBCore.Functions.GetIdentifier(src, 'steam') or 'bulunamadı'
    local srcDiscordID = QBCore.Functions.GetIdentifier(src, 'discord') or 'bulunamadı'
    local srcLicenseID = QBCore.Functions.GetIdentifier(src, 'license') or 'bulunamadı'
    local srcIP = GetPlayerEndpoint(src) or 'bulunamadı'
    local srcCitizenID = PlayerData.citizenid

    local detailedMessage = string.format(
        "%s\nSteam ID: %s\nDiscord ID: %s\nLicense ID: %s\nIP: %s\nCitizen ID: %s",
        message, srcSteamID, srcDiscordID, srcLicenseID, srcIP, srcCitizenID
    )

    local webhook = Config.WebhookURL
    if webhook == "" then return end

    local connect = {
        {
            ["color"] = color,
            ["title"] = title,
            ["description"] = detailedMessage,
            ["footer"] = {
                ["text"] = os.date("%Y-%m-%d %H:%M:%S"),
            },
        }
    }

    PerformHttpRequest(webhook, function(err, text, headers) 
        if err ~= 200 then
        end
    end, 'POST', json.encode({username = "Devlet Aracı Çalma", embeds = connect}), { ['Content-Type'] = 'application/json' })
end)