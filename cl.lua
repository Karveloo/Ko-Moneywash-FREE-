ESX = exports["es_extended"]:getSharedObject()

local inMarker = false
local currentLaundry = nil
local props = {}

Citizen.CreateThread(function()
    for i=1, #Config.pesulat, 1 do
        local prop = CreateObject(GetHashKey(Config.Prop), Config.pesulat[i].sijainti.x, Config.pesulat[i].sijainti.y, Config.pesulat[i].sijainti.z - 1.0, false, false, false)
        SetEntityAsMissionEntity(prop, true, true)
        FreezeEntityPosition(prop, true)
        table.insert(props, prop)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local pelaajanSijainti = GetEntityCoords(PlayerPedId())
        local isInMarker = false
        local currentZone = nil

        for i=1, #Config.pesulat, 1 do
            local pesula = Config.pesulat[i]
            local distance = #(pelaajanSijainti - pesula.sijainti)

            if distance < Config.DrawDistance then
                DrawMarker(Config.MarkerType, pesula.sijainti.x, pesula.sijainti.y, pesula.sijainti.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
            end

            if distance < Config.MarkerSize.x then
                isInMarker = true
                currentZone = i
            end
        end

        if (isInMarker and not inMarker) then
            inMarker = true
            currentLaundry = currentZone
            exports.ox_lib:notify({
                type = 'info', 
                description = "Paina [E] avataksesi valikon.",
                position = 'bottom',
            })
        end

        if not isInMarker and inMarker then
            inMarker = false
            currentLaundry = nil
        end

        if IsControlJustReleased(0, 38) and inMarker and currentLaundry then
            local pelaajanjob = ESX.GetPlayerData().job
            local pesula = Config.pesulat[currentLaundry]

            if pesula.jobi.nimi == "none" or (pesula.jobi.nimi == pelaajanjob.name and pelaajanjob.grade >= pesula.jobi.arvo) then
                openWashInput(pesula.pesuProsentti)
            else
                exports.ox_lib:notify({
                    type = 'error',
                    description = "Sinulla ei ole oikeutta käyttää tätä pesulaa.",
                    icon = 'ban',
                    iconColor = 'red',
                    position = 'bottom'
                })
            end
        end
    end
end)

function openWashInput(pesuProsentti)
    local input = exports.ox_lib:inputDialog('Pese rahaa', {'Syötä määrä'})

    if input then
        local amount = tonumber(input[1])

        if amount and amount > 0 then
            local playerPed = PlayerPedId()
    

            lib.progressCircle({
                duration = 15000,
                position = 'bottom',
                useWhileDead = false,
                canCancel = false,
                anim = { dict = 'amb@prop_human_bum_bin@idle_b', clip = 'idle_d' },
                disable = { move = true, car = true }
            })
            ClearPedTasksImmediately(playerPed)

            TriggerServerEvent('ko_pesee', pesuProsentti, amount)
        else
            exports.ox_lib:notify({
                type = 'error', 
                description = "Virheellinen määrä.",
                icon = 'ban',
                iconColor = 'red',
                position = 'bottom',
            })
        end
    end
end

