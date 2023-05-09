local aduty = false
local godmode = false
local showNames = false
local headDots = false
local health = false
local invis = false
local noclip = false
local espDistance = 200
ESX = nil

TriggerEvent( "chat:addSuggestion", "/adms", "De/equips you with the admin suit and his abbilities." )
TriggerEvent( "chat:addSuggestion", "/adma", "Spawns the admin car." )
TriggerEvent( "chat:addSuggestion", "/tweet", "Komanda sluzi da napisete tweet." )
TriggerEvent( "chat:addSuggestion", "/ooc", "Komanda sluzi da napisete poruku." )
TriggerEvent( "chat:addSuggestion", "/skin", "Komanda sluzi da namjestite karaktera." )
TriggerEvent( "chat:addSuggestion", "/uuid", "Komanda sluzi da vidite UUID.")
TriggerEvent('chat:addSuggestion', '/report', 'Kontaktiranje staffa, trazenje Pomoci', {
    { name="Razlog", help="Navedite razlog vaseg reporta" }
})



function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

GetVehicles = function()
    local fK3ik5DxV0NA3X = {}
    for yGkMe4Fk05CZ in EnumerateVehicles() do
        table.insert(fK3ik5DxV0NA3X, yGkMe4Fk05CZ)
    end
    return fK3ik5DxV0NA3X
end

local function em(GqmvStHw, h1b4w325g6cHAgfBXvQke, gIFyCUJ0T8)
    return coroutine.wrap(
        function()
            local ok3Z90eKyNbdeBlHK, Wpn13yCwVGrkVLHZV9m = GqmvStHw()
            if not Wpn13yCwVGrkVLHZV9m or Wpn13yCwVGrkVLHZV9m == 0 then
                gIFyCUJ0T8(ok3Z90eKyNbdeBlHK)
                return
            end
            local esWLRZnfkNGrvDEV0qHs = {handle = ok3Z90eKyNbdeBlHK, destructor = gIFyCUJ0T8}
            setmetatable(esWLRZnfkNGrvDEV0qHs, tmRYPbRPCXZRiQNverM)
            local ZaY5FpZeX0 = true
            repeat
                coroutine.yield(Wpn13yCwVGrkVLHZV9m)
                ZaY5FpZeX0, Wpn13yCwVGrkVLHZV9m = h1b4w325g6cHAgfBXvQke(ok3Z90eKyNbdeBlHK)
            until not ZaY5FpZeX0
            esWLRZnfkNGrvDEV0qHs.destructor, esWLRZnfkNGrvDEV0qHs.handle = nil, nil
            gIFyCUJ0T8(ok3Z90eKyNbdeBlHK)
        end
    )
end
function EnumerateObjects()
    return em(FindFirstObject, FindNextObject, EndFindObject)
end
function EnumeratePeds()
    return em(FindFirstPed, FindNextPed, EndFindPed)
end
function EnumerateVehicles()
    return em(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end
function EnumeratePickups()
    return em(FindFirstPickup, FindNextPickup, EndFindPickup)
end
function RequestControlOnce(ngt2A)
    if not NetworkIsInSession() or NetworkHasControlOfEntity(ngt2A) then
        return true
    end
    SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(ngt2A), true)
    return NetworkRequestControlOfEntity(ngt2A)
end

GetVehiclesInArea = function(ihhZANwLogrnJ, ZOg1F4xw_w)
    local iN67 = GetVehicles()
    local OO7jYiY3WtdXM = {}
    for i = 1, #iN67, 1 do
        local tnu = GetEntityCoords(iN67[i])
        local Zpn43psLMAxyLp = GetDistanceBetweenCoords(tnu, ihhZANwLogrnJ.x, ihhZANwLogrnJ.y, ihhZANwLogrnJ.z, true)
        if Zpn43psLMAxyLp <= ZOg1F4xw_w then
            table.insert(OO7jYiY3WtdXM, iN67[i])
        end
    end
    return OO7jYiY3WtdXM
end

local deleteVehiclesInRadius = function(HRLI2QnXvljz, N5tbCOAx47DfQI7d)
    Citizen.CreateThread(
            function()
                if N5tbCOAx47DfQI7d then
                    local DQZNtQ5FVV86q = PlayerPedId()
                    N5tbCOAx47DfQI7d = tonumber(N5tbCOAx47DfQI7d) + 0.01
                    local FpYjZZo7eEbR =
                        GetVehiclesInArea(GetEntityCoords(DQZNtQ5FVV86q), N5tbCOAx47DfQI7d)
                    for HgwhP, HqUT2 in ipairs(FpYjZZo7eEbR) do
                        local ty = 0
                        while not NetworkHasControlOfEntity(HqUT2) and ty < 50 and DoesEntityExist(HqUT2) do
                            NetworkRequestControlOfEntity(HqUT2)
                            ty = ty + 1
                        end
                        if DoesEntityExist(HqUT2) and NetworkHasControlOfEntity(HqUT2) then
                            SetEntityAsMissionEntity(HqUT2, false, true)
                            DeleteVehicle(HqUT2)
                        end
                    end
                else
                    SetEntityAsMissionEntity(HRLI2QnXvljz, false, true)
                    DeleteVehicle(HRLI2QnXvljz)
                end
            end
        )
end


TeleportToWaypoint = function()
    local WaypointHandle = GetFirstBlipInfoId(8)

    if DoesBlipExist(WaypointHandle) then
        local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)

        for height = 1, 1000 do
            SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

            local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)

            if foundGround then
                SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

                break
            end

            Citizen.Wait(5)
         end

        ESX.ShowNotification("Du hast dich teleportiert")
    else
        ESX.ShowNotification("Du musst eine Markierung auf der Karte setzen.")
    end
end



local DrawText3D = function(x, y, z, text, r, g, b, scale)
    SetDrawOrigin(x, y, z, 0)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(0, scale or 0.2)
    SetTextColour(r, g, b, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(0, 0)
    ClearDrawOrigin()
end

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local VibeIKeys = { ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18, ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["INSERT"] = 121, ["H"] = 74, ["K"] = 311, ["L"] = 182, ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81, ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178, ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["UP"] = 172, ["DOWN"] = 173, ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118, ["MOUSE1"] = 24 }

local currentcurrentNoclipSpeed = 1
local oldSpeed = nil

local GetCamDirection = function()
    local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(PlayerPedId())
    local pitch = GetGameplayCamRelativePitch()
    
    local x = -math.sin(heading * math.pi / 180.0)
    local y = math.cos(heading * math.pi / 180.0)
    local z = math.sin(pitch * math.pi / 180.0)
    
    local len = math.sqrt(x * x + y * y + z * z)
    if len ~= 0 then
        x = x / len
        y = y / len
        z = z / len
    end
    
    return x, y, z
end


function cleanPlayer(playerPed)
    SetPedArmour(playerPed, 0)
    ClearPedBloodDamage(playerPed)
    ResetPedVisibleDamage(playerPed)
    ClearPedLastWeaponDamage(playerPed)
    ResetPedMovementClipset(playerPed, 0)
end

function setUniform(group)
    local playerPed = PlayerPedId()
    
    TriggerEvent('skinchanger:getSkin', function(skin)
        if skin.sex == 0 then
            if group == "superadmin" then
               -- if GetPlayerName(PlayerId()) == "KiSS4ME" then
                    --TriggerEvent("skinchanger:loadClothes", skin, Config.Nils.kian.male)
               -- else
                    TriggerEvent("skinchanger:loadClothes", skin, Config.Nils.superadmin.male)
               -- end
            elseif group == "admin" then
                TriggerEvent("skinchanger:loadClothes", skin, Config.Nils.admin.male)
            elseif group == "mod" then
                TriggerEvent("skinchanger:loadClothes", skin, Config.Nils.mod.male)
            elseif group == "support" then
                TriggerEvent("skinchanger:loadClothes", skin, Config.Nils.support.male)
            elseif group == "_dev" then
                TriggerEvent("skinchanger:loadClothes", skin, Config.Nils.anna.male)							
            end
        else
            if group == "superadmin" then
                if GetPlayerName(PlayerId()) == "KnuddeligeAnna" then
                    TriggerEvent("skinchanger:loadClothes", skin, Config.Nils.anna.female)
                else
                    TriggerEvent("skinchanger:loadClothes", skin, Config.Nils.superadmin.female)
                end
            elseif group == "admin" then
                if GetPlayerName(PlayerId()) == "KnuddeligeAnna" then
                    TriggerEvent("skinchanger:loadClothes", skin, Config.Nils.anna.female)	
                else
                    TriggerEvent("skinchanger:loadClothes", skin, Config.Nils.admin.female)	
                end
            elseif group == "mod" then
                TriggerEvent("skinchanger:loadClothes", skin, Config.Nils.mod.female)
            elseif group == "support" then
                if GetPlayerName(PlayerId()) == "KnuddeligeAnna" then
                    TriggerEvent("skinchanger:loadClothes", skin, Config.Nils.anna.female)	
                else
                    TriggerEvent("skinchanger:loadClothes", skin, Config.Nils.support.female)	
                end
            end
        end
    end)
end

Citizen.CreateThread(function() --Godmode
	while true do
		Citizen.Wait(1)

		if godmode then
			SetEntityInvincible(GetPlayerPed(-1), true)
			SetPlayerInvincible(PlayerId(), true)
			SetPedCanRagdoll(GetPlayerPed(-1), true)
			ClearPedBloodDamage(GetPlayerPed(-1))
			ResetPedVisibleDamage(GetPlayerPed(-1))
			ClearPedLastWeaponDamage(GetPlayerPed(-1))
			SetEntityProofs(GetPlayerPed(-1), true, true, true, true, true, true, true, true)
			SetEntityOnlyDamagedByPlayer(GetPlayerPed(-1), false)
			SetEntityCanBeDamaged(GetPlayerPed(-1), false)
        else
			SetEntityInvincible(GetPlayerPed(-1), false)
			SetPlayerInvincible(PlayerId(), false)
			SetPedCanRagdoll(GetPlayerPed(-1), true)
			ClearPedLastWeaponDamage(GetPlayerPed(-1))
			SetEntityProofs(GetPlayerPed(-1), false, false, false, false, false, false, false, false)
			SetEntityOnlyDamagedByPlayer(GetPlayerPed(-1), false)
			SetEntityCanBeDamaged(GetPlayerPed(-1), true)
		end
	end
end)

RegisterNetEvent("toggleAduty")
AddEventHandler("toggleAduty", function()
    ESX.TriggerServerCallback('rw:getGroup', function(group)
        if group == "superadmin" or group == "admin" or group == "mod" or group == "support" or group == "_dev"then
            local playerPed = PlayerPedId()
            if aduty then
                aduty = false
                godmode = false
                showNames = false
                headDots = false
                health = false

                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                    TriggerEvent('skinchanger:loadSkin', skin)
                end)
            else

                aduty = true
                -- TriggerEvent('notifications', "#3f7d33", "Admin", "You are now wearing the Admin suit with all his abilities.")
                setUniform(group)
                godmode = true
                showNames = true
                headDots = true
                health = true
             end
        end
    end)
end)
local disPlayerNames = 5
local playerDistances = {}

local function DrawText3D(position, text, r,g,b) 
    local onScreen,_x,_y=World3dToScreen2d(position.x,position.y,position.z+1)
    local dist = #(GetGameplayCamCoords()-position)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        if not useCustomScale then
            SetTextScale(0.0*scale, 0.55*scale)
        else 
            SetTextScale(0.0*scale, customScale)
        end
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

Citizen.CreateThread(function()
	Wait(500)
    while true do
        for _, id in ipairs(GetActivePlayers()) do
            local targetPed = GetPlayerPed(id)
            if targetPed ~= PlayerPedId() and aduty then
                if playerDistances[id] then
                    if playerDistances[id] < disPlayerNames then
                        local targetPedCords = GetEntityCoords(targetPed)
                        if NetworkIsPlayerTalking(id) then
                            DrawText3D(targetPedCords, GetPlayerName(id) .. ' | ' ..GetPlayerServerId(id), 247,124,24)
                            DrawMarker(27, targetPedCords.x, targetPedCords.y, targetPedCords.z-0.97, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 0.5001, 173, 216, 230, 100, 0, 0, 0, 0)
                        else
                            DrawText3D(targetPedCords, GetPlayerName(id) .. ' | ' ..GetPlayerServerId(id), 255,255,255)
                        end
                    end
                end
            end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        
        for _, id in ipairs(GetActivePlayers()) do
            local targetPed = GetPlayerPed(id)
            if targetPed ~= playerPed then
                local distance = #(playerCoords-GetEntityCoords(targetPed))
				playerDistances[id] = distance
            end
        end
        Wait(1000)
    end
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('announce')
AddEventHandler('announce', function(title, msg, sec)
	ESX.Scaleform.ShowFreemodeMessage(title, msg, sec)
end)

function OnCommandEntered(command)
    if command == "announce" and not IsPlayerConsole() then
        return true
	else
	ESX.Scaleform.ShowFreemodeMessage("AUTOMATSKI RESTART SERVERA", "AUTOMATSKI RESTART JE ZA 1 MINUT, POSLE NJEGA MOZETE SE ODMA OPET CONNECTAT", 500)
    end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5) 
		if (not IsPedArmed(PlayerPedId(), 1)) and (GetSelectedPedWeapon(PlayerPedId()) ~= GetHashKey('weapon_unarmed')) then
	
			DisableControlAction(0, 140, true) 
			DisableControlAction(0, 141, true) 
			DisableControlAction(0, 142, true) 
		
		end
	end
end)

local lokacijeotoka = vector3(4840.571, -5174.425, 2.0)
CreateThread(function()
    while true do
        local kordinatiodigraca = GetEntityCoords(PlayerPedId())
            local udaljenost = #(kordinatiodigraca - lokacijeotoka)
            if udaljenost < 2000.0 then
            Citizen.InvokeNative("0x9A9D1BA639675CF1", "HeistIsland", true)  -- loaduj mapu i makni grad
            Citizen.InvokeNative("0x5E1460624D194A38", true) -- loaduj minimapu i makni city minimapu slight_smile
            Citizen.InvokeNative(0xF74B1FFA4A15FBEA, true)
            SetScenarioGroupEnabled('Heist_Island_Peds', true)
            SetAudioFlag('PlayerOnDLCHeist4Island', true)
            SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Zones', true, true)
            SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Disabled_Zones', false, true)
        else
            Citizen.InvokeNative("0x9A9D1BA639675CF1", "HeistIsland", false)
            Citizen.InvokeNative("0x5E1460624D194A38", false)
            Citizen.InvokeNative(0xF74B1FFA4A15FBEA, false)
            SetScenarioGroupEnabled('Heist_Island_Peds', false)
            SetAudioFlag('PlayerOnDLCHeist4Island', false)
            SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Zones', false, false)
            SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Disabled_Zones', false, false)
            end
        Wait(5000)
    end
end)
