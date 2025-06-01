RegisterNetEvent('fishing:giveFish', function()
    local source = source
    local totalChance = 0
    local chances = {}

    for _, fish in pairs(Config.Items) do
        totalChance = totalChance + fish.chance
        table.insert(chances, {
            name = fish.name,
            min = totalChance - fish.chance + 1,
            max = totalChance
        })
    end

    local roll = math.random(1, totalChance)
    local caughtFish

    for _, fish in pairs(chances) do
        if roll >= fish.min and roll <= fish.max then
            caughtFish = fish.name
            break
        end
    end

    exports.ox_inventory:AddItem(source, caughtFish, 1)

    TriggerClientEvent('ox_lib:notify', source, {
        title = 'Fishing',
        description = ('You caught a %s!'):format(caughtFish),
        type = 'success'
    })
end)

RegisterNetEvent('fishing:sellFish', function(fishType, amount)
    local source = source
    amount = tonumber(amount)

    if not amount or amount < 1 then return end

    local hasItems = exports.ox_inventory:GetItem(source, fishType, amount)
    if not hasItems then
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Fish Monger',
            description = 'You don\'t have enough fish!',
            type = 'error'
        })
        return
    end

    local price = Config.FishMonger.prices[fishType] * amount
    local removeItem = exports.ox_inventory:RemoveItem(source, fishType, amount)
    if not removeItem then
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Fish Monger',
            description = 'Failed to remove fish from inventory!',
            type = 'error'
        })
        return
    end

    exports.ox_inventory:AddItem(source, 'money', price)

    TriggerClientEvent('ox_lib:notify', source, {
        title = 'Fish Monger',
        description = ('Sold %sx %s for $%s'):format(amount, fishType, price),
        type = 'success'
    })
end)
