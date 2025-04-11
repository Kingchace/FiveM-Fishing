local isFishing = false
local fishingRod = nil

lib.requestAnimDict('amb@world_human_stand_fishing@idle_a')

CreateThread(function()
    for k, spot in pairs(Config.Locations) do
        local blip = AddBlipForCoord(spot.coords.x, spot.coords.y, spot.coords.z)
        SetBlipSprite(blip, 68)
        SetBlipColour(blip, 0)
        SetBlipScale(blip, 0.7)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString('Fishing Spot')
        EndTextCommandSetBlipName(blip)
    end
end)

CreateThread(function()
    local blip = AddBlipForCoord(Config.FishMonger.coords.x, Config.FishMonger.coords.y, Config.FishMonger.coords.z)
    SetBlipSprite(blip, 356)
    SetBlipColour(blip, 3)
    SetBlipScale(blip, 0.8)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString('Fish Monger')
    EndTextCommandSetBlipName(blip)
end)

CreateThread(function()
    while true do
        local sleep = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local showingUI = false
        local isNearAnySpot = false

        for k, spot in pairs(Config.Locations) do
            local distance = #(playerCoords - vector3(spot.coords.x, spot.coords.y, spot.coords.z))
            if distance < 10 then
                isNearAnySpot = true
                break
            end
        end

        if isNearAnySpot then
            sleep = 0
            for k, spot in pairs(Config.Locations) do
                local distance = #(playerCoords - vector3(spot.coords.x, spot.coords.y, spot.coords.z))
                if distance < 10 then
                    DrawMarker(
                        Config.MarkerSettings.type,
                        spot.coords.x, spot.coords.y, spot.coords.z,
                        0.0, 0.0, 0.0,
                        0.0, 0.0, 0.0,
                        Config.MarkerSettings.size.x, Config.MarkerSettings.size.y, Config.MarkerSettings.size.z,
                        Config.MarkerSettings.color.x, Config.MarkerSettings.color.y, Config.MarkerSettings.color.z, Config.MarkerSettings.color.w,
                        Config.MarkerSettings.bobUpAndDown,
                        false,
                        0,
                        Config.MarkerSettings.rotateMarker,
                        false,
                        false,
                        false
                    )
                    if distance < 1.5 and not isFishing then
                        showingUI = true
                        lib.showTextUI('[E] Start Fishing')
                        if IsControlJustPressed(0, 38) then
                            StartFishing(spot)
                        end
                    end
                end
            end
        end

        if not showingUI then
            lib.hideTextUI()
        end
        
        Wait(sleep)
    end
end)

function StartFishing(spot)
    if isFishing then return end
    isFishing = true
    lib.hideTextUI()

    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local hash = `prop_fishing_rod_01`
    
    RequestModel(hash)
    while not HasModelLoaded(hash) do Wait(0) end
    
    fishingRod = CreateObject(hash, coords, true, true, true)
    AttachEntityToEntity(fishingRod, ped, GetPedBoneIndex(ped, 18905), 0.1, 0.05, 0, 80.0, 120.0, 160.0, true, true, false, true, 1, true)
    
    FreezeEntityPosition(ped, true)
    TaskPlayAnim(ped, 'amb@world_human_stand_fishing@idle_a', 'idle_c', 1.0, -1.0, -1, 11, 0, false, false, false)
    
    local success = true
    local difficulties = {spot.difficulty.first, spot.difficulty.second, spot.difficulty.third}
    
    for i, difficulty in ipairs(difficulties) do
        if success then
            success = lib.skillCheck(difficulty)
            Wait(500)
        else
            break
        end
    end

    if success then
        GiveFishReward()
    else
        lib.notify({
            title = 'Fishing',
            description = 'The fish got away!',
            type = 'error'
        })
    end

    ClearPedTasks(ped)
    FreezeEntityPosition(ped, false)
    DeleteObject(fishingRod)
    isFishing = false
end

CreateThread(function()
    local model = GetHashKey(Config.FishMonger.model)
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(0) end
    
    local ped = CreatePed(4, model, Config.FishMonger.coords.x, Config.FishMonger.coords.y, Config.FishMonger.coords.z - 1, Config.FishMonger.coords.w, false, true)
    SetEntityHeading(ped, Config.FishMonger.coords.w)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
end)

CreateThread(function()
    while true do
        local sleep = 1000
        local playerCoords = GetEntityCoords(PlayerPedId())
        local distance = #(playerCoords - vector3(Config.FishMonger.coords.x, Config.FishMonger.coords.y, Config.FishMonger.coords.z))
        
        if distance < 2.0 then
            sleep = 0
            lib.showTextUI('[E] Talk to Fish Monger')
            
            if IsControlJustPressed(0, 38) then
                OpenFishMongerMenu()
            end
        else
            lib.hideTextUI()
        end
        
        Wait(sleep)
    end
end)

function OpenFishMongerMenu()
    local items = {}
    
    for name, price in pairs(Config.FishMonger.prices) do
        table.insert(items, {
            title = string.upper(name:sub(1,1)) .. name:sub(2),
            description = ('Sell for $%s each'):format(price),
            image = 'nui://ox_inventory/web/images/' .. name .. '.png',
            onSelect = function()
                local input = lib.inputDialog('Sell Fish', {
                    {type = 'number', label = 'Amount to sell', description = 'How many would you like to sell?', required = true, min = 1}
                })
                
                if input then
                    TriggerServerEvent('fishing:sellFish', name, input[1])
                end
            end
        })
    end
    
    lib.registerContext({
        id = 'fish_monger_menu',
        title = 'Fish Monger',
        options = items
    })
    
    lib.showContext('fish_monger_menu')
end

function GiveFishReward()
    TriggerServerEvent('fishing:giveFish')
end

