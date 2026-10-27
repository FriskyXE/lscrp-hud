--[[ All settings of the script are found and edited in this file. ]]

Config = {}

--[[
    You can edit the default settings for Hud like this.
    I tried to choose the variable names as meaningful as possible.
--]]
Config.DefaultHudSettings   = {
    ---@type BarStyle
    bar_style = 'hexagon-w',
    --[[ Places all bar types in a new order. ]]
    is_res_style_active = true,
    vehicle_hud_style = 4,
    -- If `editableByPlayers` value is `false` players cannot change the `onlyInVehicle` value.
    mini_map = { onlyInVehicle = true, style = 'rectangle', editableByPlayers = true },
    -- If `editableByPlayers` value is `false` players cannot change the `onlyInVehicle` value.
    compass = { active = true, onlyInVehicle = true, editableByPlayers = true },
    cinematic = { active = true },
    -- kmH 'true' or 'false' | false is MPH
    vehicle_info = { kmH = false },
    --[[
        - It is located in the upper right corner.
        - It lists data such as date, server name, money, etc.
    --]]
    client_info = {
        active = true,
        server_info = {
            active = false,
            -- Server name
            name = 'LSCRP',
            -- Server Logo | path: ui/build/images/server_images/<file>
            image = 'index.png',
            -- Show online players on client_info
            showOnlinePlayers = true,
        },
        bank = { active = true },
        cash = { active = true },
        job = { active = true },
        player_source = { active = true },
        radio = { active = true },
        time = { active = true },
        weapon = { active = true },
        real_time = { active = true },
        extra_currency = { active = false },
    },
    music_info = {
        -- Listening to music feature true/false
        active = false,
    },
    --[[
        - Located above the map.
        - Shows current location, music information or time.
    --]]
    navigation_widget = { active = false },
    -- Bar colors set by default.
    bar_colors = {
        armor = '#1D4ED8',
        health = '#CF4E5B',
        hunger = '#FFC400',
        oxygen = '#00FFA3',
        stamina = '#C4FF48',
        stress = '#6b21a8',
        thirst = '#00c2ff',
        vehicle_engine = '#C4FF48',
        voice = '#FFFFFF',
        vehicle_nitro = '#cf654e',
    },
}

--If money is an item on your server, you need to edit this.
Config.MoneySettings        = {
    isMoneyItem = true,
    itemName = 'cash',
    -- You can put one more currency if you want it to appear on the `client_info`.
    -- to hide it or set active to `false`
    extra_currency = {
        type = 'item', --[[@type 'item' | 'account']]
        name = 'black_money', --[[@type string | nil]] -- account or item name
    }
}

Config.ToggleSettingsMenu   = {
    active = true,
    key = 'I',             -- nil or Key
    command = 'hudsettings', -- Shortcut key to open hud settings menu
}

-- Configures for seat-belt system.
Config.ToggleSeatBelt       = {
    active = true,
    key = 'B',
    --What should be the minimum vehicle speed for eject:
    -- This value is set according to kmH being `true`. If you are using kmH `false`, you can write it as `MPH`.
    ejectSpeed = 120,
    -- If true, you will receive a warning if you are not wearing your seat belt.
    warning = true,
}

-- Shortcut key to toggle cinametic mode
Config.ToggleCinematicMode  = {
    active = true,
    key = nil,             -- nil or Key
    command = 'cinematic', -- Toggle cinematic mode
}

-- Allows the player to default all positions.
Config.ResetHudPositions    = {
    active = true,
    command = 'resethudpos',
}

--If you want to hide GTA components, you need to enable this.
Config.HideGTAHudComponents = false
--Works with `HideGTAHudComponents` Components. | Can be used to fix the map if it is broken.
Config.HavePostalMap        = false

--Defines the refresh thread timecycle for data that need to be updated periodically. Milliseconds
Config.RefreshTimes         = {
    hud = 750,
    vehicle = 500,
    requestPlayerCount = 30 * 1000 -- 30 seconds
}

-- Colors available by default.
-- I advise you to set 20.
Config.BarColors            = {
    '#CF4E5B', '#CF4E75', '#CF4EAB', '#A888DE', '#6b21a8', '#7FCF4E', '#C4FF48', '#FFC400', '#FF9900', '#CF654E',
    '#1d4ed8', '#00C2FF', '#4EB0CF', '#4ECFA1', '#00FFA3', '#A68A7B', '#FFFFFF', '#7A7A7A', '#4B4B4B', '#00000057'
}

-- Stress System Settings
Config.Stress = {
    minimumStress = 50, -- เริ่ม blur เมื่อ stress ถึงค่านี้

    -- ยิงปืน
    shooting = {
        chancePercent = 3,       -- โอกาสได้ stress ต่อครั้งที่เช็ค (0-100)
        checkEverySeconds = 1,   -- เช็คทุกกี่วินาที ขณะถืออาวุธ
        gain = 1,                 -- stress ที่ได้ต่อครั้ง
    },

    -- ขับเร็ว (หน่วยความเร็วตาม vehicle_info.kmH: true=km/h, false=MPH)
    speeding = {
        checkEverySeconds = 30,      -- เช็คทุกกี่วินาที ขณะอยู่ในรถ
        gain = 1,                 -- stress ที่ได้ต่อครั้ง
        speedWithSeatbelt = 120,      -- เร็วกว่านี้ + คาดเข็มขัด = ได้ stress
        speedWithoutSeatbelt = 90,   -- เร็วกว่านี้ + ไม่คาดเข็มขัด = ได้ stress
    },

    whitelistedWeapons = {          -- อาวุธที่ยิงแล้วไม่เพิ่ม stress
        [`weapon_petrolcan`] = true,
        [`weapon_hazardcan`] = true,
        [`weapon_fireextinguisher`] = true
    },

    vehicleClasses = {              -- ประเภทรถที่ขับเร็วแล้วเพิ่ม stress ได้
        ['0'] = true,         -- Compacts
        ['1'] = true,         -- Sedans
        ['2'] = true,         -- SUVs
        ['3'] = true,         -- Coupes
        ['4'] = true,         -- Muscle
        ['5'] = true,         -- Sports Classics
        ['6'] = true,         -- Sports
        ['7'] = true,         -- Super
        ['8'] = true,         -- Motorcycles
        ['9'] = true,         -- Off Road
        ['10'] = true,        -- Industrial
        ['11'] = true,        -- Utility
        ['12'] = true,        -- Vans
        ['13'] = false,       -- Cycles
        ['14'] = false,       -- Boats
        ['15'] = false,       -- Helicopters
        ['16'] = false,       -- Planes
        ['18'] = false,       -- Emergency
        ['19'] = false,       -- Military
        ['20'] = false,       -- Commercial
        ['21'] = false        -- Trains
    },

    whitelistedVehicles = {         -- รุ่นรถที่ขับเร็วแล้วไม่เพิ่ม stress
        -- [`adder`] = true,
    },

    blurIntensity = {               -- blur กี่วิ ตามระดับ stress ปัจจุบัน (ไม่ใช่จำนวนที่เพิ่ม)
        { fromStress = 50, toStress = 60,  seconds = 1.5 },
        { fromStress = 60, toStress = 70,  seconds = 2.0 },
        { fromStress = 70, toStress = 80,  seconds = 2.5 },
        { fromStress = 80, toStress = 90,  seconds = 2.7 },
        { fromStress = 90, toStress = 100, seconds = 3.0 },
    },

    effectInterval = {              -- effect ถี่แค่ไหน ตามระดับ stress ปัจจุบัน
        { fromStress = 50,  toStress = 60,  everySeconds = 55 },
        { fromStress = 60,  toStress = 70,  everySeconds = 45 },
        { fromStress = 70,  toStress = 80,  everySeconds = 35 },
        { fromStress = 80,  toStress = 90,  everySeconds = 25 },
        { fromStress = 90,  toStress = 100, everySeconds = 17.5 },
    },
}

--A list of electric vehicles available in the game.
Config.ElectricVehicles     = {
    'Imorgon',
    'Neon',
    'Raiden',
    'Cyclone',
    'Voltic',
    'Voltic2',
    'Tezeract',
    'Dilettante',
    'Dilettante2',
    'Airtug',
    'Caddy',
    'Caddy2',
    'Caddy3',
    'Surge',
    'Khamelion',
    'RCBandito'
}