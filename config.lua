-- =====================================
--     https://discord.gg/ec7rmMHPTG
-- =====================================

Config = {}

Config.UseOxInventory = true -- Keep ox_inventory as default

Config.MarkerSettings = {
    type = 21,
    size = vector3(0.4, 0.4, 0.4),
    color = vector4(255, 215, 255, 222),
    bobUpAndDown = false,
    rotateMarker = true
}

-- Fishing Locations
Config.Locations = {
    [1] = { coords = vector4(-1757.2474, -1121.2686, 13.0193, 60.6823), difficulty = { first = "medium", second = "hard", third = "medium" }},
    [2] = { coords = vector4(-1759.4817, -1123.8181, 13.0193, 55.7329), difficulty = { first = "easy", second = "medium", third = "medium" }},
    [3] = { coords = vector4(-1761.6423, -1126.4189, 13.0192, 55.5504), difficulty = { first = "medium", second = "hard", third = "medium" }},
    [4] = { coords = vector4(-1763.8119, -1129.1401, 13.0193, 53.3179), difficulty = { first = "medium", second = "hard", third = "medium" }},
    [5] = { coords = vector4(-1765.6704, -1131.3083, 13.0192, 58.5152), difficulty = { first = "easy", second = "medium", third = "medium" }},
    [6] = { coords = vector4(-1770.9298, -1137.4822, 13.0191, 59.0701), difficulty = { first = "medium", second = "hard", third = "medium" }}
}

-- Available Fish Items
Config.Items = {
    {name = 'bass', label = 'Bass', chance = 70},
    {name = 'catfish', label = 'Catfish', chance = 65},
    {name = 'trout', label = 'Trout', chance = 60},
    {name = 'salmon', label = 'Salmon', chance = 45},
    {name = 'tuna', label = 'Tuna', chance = 30},
    {name = 'cod', label = 'Cod', chance = 55},
    {name = 'mackerel', label = 'Mackerel', chance = 50},
    {name = 'halibut', label = 'Halibut', chance = 35},
    {name = 'swordfish', label = 'Swordfish', chance = 20},
    {name = 'mahi_mahi', label = 'Mahi-Mahi', chance = 25}
}

Config.FishMonger = {
    coords = vector4(-1669.6998, -995.3090, 7.3631, 144.0264),
    model = 'a_m_m_farmer_01',
    prices = {
        bass = 85,
        catfish = 95,
        trout = 75,
        salmon = 150,
        tuna = 200,
        cod = 90,
        mackerel = 70,
        halibut = 180,
        swordfish = 250,
        mahi_mahi = 220
    }
}


