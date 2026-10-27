-- Stress Module

local Seatbelt = require 'modules.seatbelt.client'

-- ───────────────────────────────────────────
-- Stress Gain: Speeding
-- ───────────────────────────────────────────
CreateThread(function()
    local speeding = Config.Stress.speeding
    while true do
        if client.load then
            if IsPedInAnyVehicle(cache.ped, false) then
                local veh      = GetVehiclePedIsIn(cache.ped, false)
                local vehClass = GetVehicleClass(veh)
                local vehHash  = GetEntityModel(veh)
                local speedMult = Config.DefaultHudSettings.vehicle_info.kmH and 3.6 or 2.236936
                local speed     = GetEntitySpeed(veh) * speedMult

                if Config.Stress.vehicleClasses[tostring(vehClass)]
                    and not Config.Stress.whitelistedVehicles[vehHash]
                then
                    local stressSpeed
                    if vehClass == 8 then
                        -- Motorcycles always use speedWithSeatbelt (no seatbelt)
                        stressSpeed = speeding.speedWithSeatbelt
                    else
                        stressSpeed = Seatbelt.GetCurrentState() and speeding.speedWithSeatbelt or speeding.speedWithoutSeatbelt
                    end

                    if speed >= stressSpeed then
                        exports['lscrp-needs']:GainStress(speeding.gain or 1)
                    end
                end
            end
        end
        Wait(speeding.checkEverySeconds * 1000)
    end
end)

-- ───────────────────────────────────────────
-- Stress Gain: Shooting
-- ───────────────────────────────────────────
CreateThread(function()
    local shooting = Config.Stress.shooting
    while true do
        local wait = 1000
        if client.load then
            local weapon = GetSelectedPedWeapon(cache.ped)
            if weapon ~= `WEAPON_UNARMED` then
                wait = shooting.checkEverySeconds * 1000
                if IsPedShooting(cache.ped) and not Config.Stress.whitelistedWeapons[weapon] then
                    if math.random() < (shooting.chancePercent / 100) then
                        exports['lscrp-needs']:GainStress(shooting.gain or 1)
                    end
                end
            end
        end
        Wait(wait)
    end
end)

-- ───────────────────────────────────────────
-- Screen Effects
-- ───────────────────────────────────────────
local function getBlurIntensity(stressLevel)
    for _, v in ipairs(Config.Stress.blurIntensity) do
        if stressLevel >= v.fromStress and stressLevel <= v.toStress then
            return v.seconds * 1000
        end
    end
    return 1500
end

local function getEffectInterval(stressLevel)
    for _, v in ipairs(Config.Stress.effectInterval) do
        if stressLevel >= v.fromStress and stressLevel <= v.toStress then
            return v.everySeconds * 1000
        end
    end
    return 60000
end

CreateThread(function()
    while true do
        local currentStress  = PlayerData.stress or 0
        local effectInterval = getEffectInterval(currentStress)

        if currentStress >= 100 then
            local blurIntensity  = getBlurIntensity(currentStress)
            local fallRepeat     = math.random(2, 4)
            local ragdollTimeout = fallRepeat * 1750

            TriggerScreenblurFadeIn(1000.0)
            Wait(blurIntensity)
            TriggerScreenblurFadeOut(1000.0)

            if not IsPedRagdoll(cache.ped) and IsPedOnFoot(cache.ped) and not IsPedSwimming(cache.ped) then
                local fwd = GetEntityForwardVector(cache.ped)
                SetPedToRagdollWithFall(cache.ped, ragdollTimeout, ragdollTimeout, 1, fwd.x, fwd.y, fwd.z, 1.0, 0.0, 0.0, 0.0, 0.0, 0, 0)
            end

            Wait(1000)
            for _ = 1, fallRepeat do
                Wait(750)
                DoScreenFadeOut(200)
                Wait(1000)
                DoScreenFadeIn(200)
                TriggerScreenblurFadeIn(1000.0)
                Wait(blurIntensity)
                TriggerScreenblurFadeOut(1000.0)
            end

        elseif currentStress >= Config.Stress.minimumStress then
            local blurIntensity = getBlurIntensity(currentStress)
            TriggerScreenblurFadeIn(1000.0)
            Wait(blurIntensity)
            TriggerScreenblurFadeOut(1000.0)
        end

        Wait(effectInterval)
    end
end)