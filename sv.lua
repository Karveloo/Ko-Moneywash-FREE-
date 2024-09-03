ESX = exports["es_extended"]:getSharedObject()

RegisterServerEvent('ko_pesee')
AddEventHandler('ko_pesee', function(pesuProsentti, amount)
    local pelaaja = ESX.GetPlayerFromId(source)
    local dirtyMoney = pelaaja.getAccount('black_money').money

        if dirtyMoney >= amount then
        local washedMoney = amount * (pesuProsentti / 100)
        pelaaja.removeAccountMoney('black_money', amount)
        pelaaja.addMoney(washedMoney)
        TriggerClientEvent('ox_lib:notify', source, {
            type = 'success',
            title = 'Pesit likaista $' .. amount .. ' ja sait puhdasta $' .. washedMoney,
            duration = 5000,
            icon = 'fa-solid fa-money-bill',
            position = 'bottom',
            iconColor = 'blue'
        })
        --TriggerClientEvent('esx:showNotification', source, 'Pesit $' .. amount .. ' ja sait takaisin $' .. washedMoney)

        -- Lähetetään logi Discordiin
        local discordData = {
            {
                ["color"] = 3066993,
                ["title"] = "Rahapesu onnistui",
                ["description"] = string.format("**Pelaaja:** %s\n**Steam Hex:** %s\n**Määrä:** $%d\n**Pesty määrä:**", pelaaja.getName(), pelaaja.identifier, amount, washedMoney),
                ["footer"] = {
                    ["text"] = os.date("%Y-%m-%d %H:%M:%S")
                }
            }
        }

        PerformHttpRequest(Config.DiscordWebhook, function(err, text, headers) end, 'POST', json.encode({username = 'Rahapesula', embeds = discordData}), { ['Content-Type'] = 'application/json' })
    else
        TriggerClientEvent('ox_lib:notify', source, {
            type = 'success',
            title = 'Ei tarpeeksi pestävää rahaa',
            duration = 5000,
            icon = 'fa-solid fa-money-bill',
            iconColor = 'red',
            position = 'bottom',
        })
    end
end)