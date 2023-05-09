ESX = nil
lastlocation = nil
debuglocation = nil
local isAlive = true
local spawnedVehicle = nil



Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(50)
	end
end)

RegisterNetEvent('tpmenu:open')
AddEventHandler('tpmenu:open', function()
    ESX.UI.Menu.CloseAll() --Close everything ESX.Menu related	
    local elements = {}   

    table.insert(elements, { label = '[F2] NoClip', value= 'smth'})
    table.insert(elements, { label = '[Z] Radio ', value= 'smth'})
    table.insert(elements, { label = 'Heal', value= 'h'})
    table.insert(elements, { label = 'Stavi Pancir', value= 'a'})
    table.insert(elements, { label = 'Skini pancir', value= '-a'})
    table.insert(elements, { label = 'Teleport do markera', value= 'waypoint'})
    table.insert(elements, { label = 'Lokacije', value= 'loc'})
    table.insert(elements, { label = 'Oruzarnica', value= 'weaponmenu'})

    table.insert(elements, { label = 'Super Sportska Auta', value= 'ssmenu'})
    table.insert(elements, { label = 'Sportska Auta', value= 'smenu'})
    table.insert(elements, { label = 'Limusine', value= 'limomenu'})
    table.insert(elements, { label = 'SUV', value= 'suvmenu'})
    table.insert(elements, { label = 'Old Timeri', value= 'oldtimermenu'})
    table.insert(elements, { label = 'Motori', value= 'motorcyclemenu'})
    table.insert(elements, { label = 'Ostala Vozila', value= 'othermenu'})
    table.insert(elements, { label = 'Avioni', value= 'planemenu'})
    table.insert(elements, { label = 'Helikopteri', value= 'helimenu'})
    table.insert(elements, { label = 'Brodovi', value= 'boatmenu'})

    table.insert(elements, { label = 'Pokazi koordinate', value= 'printcoords'})
	
	if isAlive then
    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'tpmenu',
    {
        title    = 'Glavni Meni',
        align    = 'top-right',
        elements = elements
    },
    function(data, menu) --on data selection
        if data.current.value == "lastloc" then
            if lastlocation ~= nil then  
                ESX.Game.Teleport(PlayerPedId(), lastlocation) 
                ESX.ShowNotification(Locale['teleported_last'])
            else 
                ESX.ShowNotification(Locale['teleported_last_empty'])
            end
        elseif data.current.value == "setdebugloc" then
            debuglocation = GetEntityCoords(GetPlayerPed(-1))
            ESX.ShowNotification(Locale['teleported_debug'])
            menu.close()
        elseif data.current.value == "waypoint" then
            TeleportWaypoint()
        elseif data.current.value == "debugloc" then        
            lastlocation = GetEntityCoords(GetPlayerPed(-1))
            ESX.Game.Teleport(PlayerPedId(), debuglocation) 
            ESX.ShowNotification(Locale['teleported'] .. data.current.label)
        elseif data.current.value == "loc" then   
            OpenLocationsMenu()
        elseif data.current.value == "printcoords" then
            PrintCoords()
  	elseif data.current.value == "weaponmenu" then
            OpenWeaponMenu()
  	elseif data.current.value == "a" then
    SetPedArmour(PlayerPedId(), 100)
	elseif data.current.value == "-a" then
    SetPedArmour(PlayerPedId(), 0)
  	elseif data.current.value == "h" then
        SetEntityHealth(PlayerPedId(), 200)
  	elseif data.current.value == "helimenu" then
	            spawnHeli()
elseif data.current.value == "helimenu" then
	            spawnHeli()
elseif data.current.value == "boatmenu" then
	            spawnBoats()
elseif data.current.value == "motorcyclemenu" then
	            spawnMotorcycles()
elseif data.current.value == "oldtimermenu" then
	            spawnMuscleCars()
elseif data.current.value == "othermenu" then
	            spawnOtherVehicles()
elseif data.current.value == "planemenu" then
	            spawnPlanes()
elseif data.current.value == "suvmenu" then
	            spawnSuv()
elseif data.current.value == "limomenu" then
	            spawnSedans()
elseif data.current.value == "ssmenu" then
	            spawnSuperSports()
elseif data.current.value == "smenu" then
	            spawnSports()

  	end
    end,
    function(data, menu)
        menu.close()
    end)
end
end)


function spawnHeli()
    local elements = {}
    
    for k,v in ipairs(Helicopters) do
        table.insert(elements, { label = v.label, value  = v.value })
	-- print(v.value)

    end
    
    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'tpmenu_weapons',
    {
        title    = 'Helikopteri',
        align    = 'top-right',
        elements = elements
    },
    function(data, menu) --on data selection
      spawnVehicle(GetHashKey(data.current.value))    
   end,
    function(data, menu)
        menu.close()
    end)
end

function spawnBoats()
    local elements = {}
    
    for k,v in ipairs(Boats) do
        table.insert(elements, { label = v.label, value  = v.value })
	-- print(v.value)

    end
    
    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'tpmenu_weapons',
    {
        title    = 'Brodovi',
        align    = 'top-right',
        elements = elements
    },
    function(data, menu) --on data selection
	-- print(GetHashKey(data.current.value))

      spawnVehicle(GetHashKey(data.current.value))    
   end,
    function(data, menu)
        menu.close()
    end)
end

function spawnMotorcycles()
    local elements = {}
    
    for k,v in ipairs(Motorcycles) do
        table.insert(elements, { label = v.label, value  = v.value })
	-- print(v.value)

    end
    
    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'tpmenu_weapons',
    {
        title    = 'Motori',
        align    = 'top-right',
        elements = elements
    },
    function(data, menu) --on data selection
	-- print(GetHashKey(data.current.value))

      spawnVehicle(GetHashKey(data.current.value))    
   end,
    function(data, menu)
        menu.close()
    end)
end

function spawnMuscleCars()
    local elements = {}
    
    for k,v in ipairs(MuscleCars) do
        table.insert(elements, { label = v.label, value  = v.value })
	-- print(v.value)

    end
    
    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'tpmenu_weapons',
    {
        title    = 'Old Timeri',
        align    = 'top-right',
        elements = elements
    },
    function(data, menu) --on data selection
	-- print(GetHashKey(data.current.value))

      spawnVehicle(GetHashKey(data.current.value))    
   end,
    function(data, menu)
        menu.close()
    end)
end


function spawnOtherVehicles()
    local elements = {}
    
    for k,v in ipairs(OtherVehicles) do
        table.insert(elements, { label = v.label, value  = v.value })
	-- print(v.value)

    end
    
    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'tpmenu_weapons',
    {
        title    = 'Bez kategorisana Vozila',
        align    = 'top-right',
        elements = elements
    },
    function(data, menu) --on data selection
	-- print(GetHashKey(data.current.value))

      spawnVehicle(GetHashKey(data.current.value))    
   end,
    function(data, menu)
        menu.close()
    end)
end

function spawnPlanes()
    local elements = {}
    
    for k,v in ipairs(Planes) do
        table.insert(elements, { label = v.label, value  = v.value })
	-- print(v.value)

    end
    
    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'tpmenu_weapons',
    {
        title    = 'Avioni',
        align    = 'top-right',
        elements = elements
    },
    function(data, menu) --on data selection
	-- print(GetHashKey(data.current.value))

      spawnVehicle(GetHashKey(data.current.value))    
   end,
    function(data, menu)
        menu.close()
    end)
end

function spawnSuv()
    local elements = {}
    
    for k,v in ipairs(Suv) do
        table.insert(elements, { label = v.label, value  = v.value })
	-- print(v.value)

    end
    
    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'tpmenu_weapons',
    {
        title    = 'SUV',
        align    = 'top-right',
        elements = elements
    },
    function(data, menu) --on data selection
	-- print(GetHashKey(data.current.value))

      spawnVehicle(GetHashKey(data.current.value))    
   end,
    function(data, menu)
        menu.close()
    end)
end

function spawnSedans()
    local elements = {}
    
    for k,v in ipairs(Sedans) do
        table.insert(elements, { label = v.label, value  = v.value })
	-- print(v.value)

    end
    
    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'tpmenu_weapons',
    {
        title    = 'Limusine',
        align    = 'top-right',
        elements = elements
    },
    function(data, menu) --on data selection
	-- print(GetHashKey(data.current.value))

      spawnVehicle(GetHashKey(data.current.value))    
   end,
    function(data, menu)
        menu.close()
    end)
end

function spawnSports()
    local elements = {}
    
    for k,v in ipairs(Sports) do
        table.insert(elements, { label = v.label, value  = v.value })
	-- print(v.value)

    end
    
    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'tpmenu_weapons',
    {
        title    = 'Sportska Auta',
        align    = 'top-right',
        elements = elements
    },
    function(data, menu) --on data selection
	-- print(GetHashKey(data.current.value))

      spawnVehicle(GetHashKey(data.current.value))    
   end,
    function(data, menu)
        menu.close()
    end)
end

function spawnSuperSports()
    local elements = {}
    
    for k,v in ipairs(SuperSports) do
        table.insert(elements, { label = v.label, value  = v.value })
	-- print(v.value)

    end
    
    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'tpmenu_weapons',
    {
        title    = 'Super Sportska Auta',
        align    = 'top-right',
        elements = elements
    },
    function(data, menu) --on data selection
	-- print(GetHashKey(data.current.value))

      spawnVehicle(GetHashKey(data.current.value))    
   end,
    function(data, menu)
        menu.close()
    end)
end


local isVehicleSpawning = false

function spawnVehicle(vehicleModel)
    if isVehicleSpawning then
        ESX.ShowNotification("Strpite se malo vase vozilo ce se uskoro stvoriti")
        return
    end
    
    isVehicleSpawning = true
    
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, 0.0))
    RequestModel(vehicleModel)
    
    Citizen.CreateThread(function() 
        ESX.ShowNotification(Locale['will_spawn'])
        local waiting = 0
        while not HasModelLoaded(vehicleModel) do
            waiting = waiting + 100
            Citizen.Wait(100)
            if waiting > 5000 then
                break
            end
        end

        -- Löschen des vorherigen Fahrzeugs
        if spawnedVehicle ~= nil and DoesEntityExist(spawnedVehicle) then
            SetEntityAsMissionEntity(spawnedVehicle, true, true)
            DeleteVehicle(spawnedVehicle)
            spawnedVehicle = nil
        end

        -- Erstellen des neuen Fahrzeugs
        spawnedVehicle = CreateVehicle(vehicleModel, x, y, z, GetEntityHeading(GetPlayerPed(-1)), 1, 0)
        TaskWarpPedIntoVehicle(PlayerPedId(), spawnedVehicle, -1)
        
        isVehicleSpawning = false
    end)
end


function OpenWeaponMenu()
    local elements = {}
    table.insert(elements, { label = 'Uzmite svo Oruzje', value= 'refillAmmo'})
    table.insert(elements, { label = 'Maknite svo Oruzje', value= 'clearWeapons'})


    for k,v in ipairs(Weapons) do
        table.insert(elements, { label = v.label, weapon = v.weapon })
    end
    
    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'tpmenu_weapons',
    {
        title    = 'Oruzje',
        align    = 'top-right',
        elements = elements
    },
    function(data, menu) --on data selection
		if data.current.value == "refillAmmo" then
			for k,v in ipairs(Weapons) do
				table.insert(elements, { label = v.label, weapon = v.weapon })
				GiveWeaponToPed(GetPlayerPed(-1), GetHashKey(v.weapon), 99999, true, true)
    				SetPedInfiniteAmmo(GetPlayerPed(-1), true, GetHashKey(v.weapon))

			end
	        elseif data.current.value == "clearWeapons" then
			for k,v in ipairs(Weapons) do
				table.insert(elements, { label = v.label, weapon = v.weapon })
      				RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey(v.weapon))
			end
		else
			GiveWeaponToPed(GetPlayerPed(-1), GetHashKey(data.current.weapon), 99999, true, true)
			SetPedInfiniteAmmo(GetPlayerPed(-1), true, GetHashKey(data.current.weapon))
		end
    end,
    function(data, menu)
        menu.close()
    end)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000) -- wait for 1 second to reduce server load
        local playerPed = GetPlayerPed(-1)
        local isPlayerDead = IsEntityDead(playerPed)
        
        if isPlayerDead then
		isAlive = false
        else
            	isAlive = true
        end
    end
end)

function OpenLocationsMenu()
    local elements = {}

    for k,v in ipairs(Locations) do
        table.insert(elements, { label = v.label, x = v.x, y = v.y, z = v.z })
    end
    
    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'tpmenu_locations',
    {
        title    = 'Lokacije za teleportiranje',
        align    = 'top-right',
        elements = elements
    },
    function(data, menu) --on data selection
        lastlocation = GetEntityCoords(GetPlayerPed(-1))
        local coords = { x = data.current.x,  y = data.current.y, z = data.current.z}
        ESX.Game.Teleport(PlayerPedId(), coords)
        ESX.ShowNotification(Locale['teleported'] .. data.current.label)
    end,
    function(data, menu)
        menu.close()
    end)
end

function TeleportWaypoint()
	local playerPed = GetPlayerPed(-1)
	local blip = GetFirstBlipInfoId(8)

	if DoesBlipExist(blip) then
		local waypointCoords = GetBlipInfoIdCoord(blip)
		for height = 1, 1000 do
			SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
			local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)

			if foundGround then
				SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
				break
			end
			Citizen.Wait(5)
		end
        ESX.ShowNotification(Locale['teleported'] .. 'Waypoint')
	else
        ESX.ShowNotification(Locale['no_waypoint'])
	end
end

function PrintCoords()
    local playerPed = PlayerPedId()

	local pos      = GetEntityCoords(playerPed)
	local heading  = GetEntityHeading(playerPed)
	local finalPos = {}

	-- round to 2 decimals
	finalPos.x = string.format("%.2f", pos.x)
	finalPos.y = string.format("%.2f", pos.y)
	finalPos.z = string.format("%.2f", pos.z)
	finalPos.h = string.format("%.2f", heading)

	local formattedText = "x = " .. finalPos.x .. ", y = " .. finalPos.y .. ", z = " .. finalPos.z .. ', h = ' .. finalPos.h
	TriggerEvent('chatMessage', 'SYSTEM', { 0, 0, 0 }, formattedText)
	print(formattedText)
end

Crouched = false
CrouchedForce = false
Aimed = false
Cooldown = false
PlayerInfo = {
	playerPed = PlayerPedId(),
	playerID = GetPlayerIndex(),
	nextCheck = GetGameTimer() + 1500
}
CoolDownTime = 500 -- in ms

NormalWalk = function()
	SetPedMaxMoveBlendRatio(PlayerInfo.playerPed, 1.0)
	ResetPedMovementClipset(PlayerInfo.playerPed, 0.55)
	ResetPedStrafeClipset(PlayerInfo.playerPed)
	SetPedCanPlayAmbientAnims(PlayerInfo.playerPed, true)
	SetPedCanPlayAmbientBaseAnims(PlayerInfo.playerPed, true)
	ResetPedWeaponMovementClipset(PlayerInfo.playerPed)
	Crouched = false
end

SetupCrouch = function()
	while not HasAnimSetLoaded('move_ped_crouched') do
		Citizen.Wait(5)
		RequestAnimSet('move_ped_crouched')
	end
end

RemoveCrouchAnim = function()
	RemoveAnimDict('move_ped_crouched')
end

CanCrouch = function()
	if IsPedOnFoot(PlayerInfo.playerPed) and not IsPedInAnyVehicle(PlayerInfo.playerPed, false) and not IsPedJumping(PlayerInfo.playerPed) and not IsPedFalling(PlayerInfo.playerPed) and not IsPedDeadOrDying(PlayerInfo.playerPed) then
		return true
	else
		return false
	end
end

CrouchPlayer = function()
	SetPedUsingActionMode(PlayerInfo.playerPed, false, -1, "DEFAULT_ACTION")
	SetPedMovementClipset(PlayerInfo.playerPed, 'move_ped_crouched', 0.55)
	SetPedStrafeClipset(PlayerInfo.playerPed, 'move_ped_crouched_strafing') -- it force be on third person if not player will freeze but this func make player can shoot with good anim on crouch if someone know how to fix this make request :D
	SetWeaponAnimationOverride(PlayerInfo.playerPed, "Ballistic")
	Crouched = true
	Aimed = false
end

SetPlayerAimSpeed = function()
	SetPedMaxMoveBlendRatio(PlayerInfo.playerPed, 0.2)
	Aimed = true
end

IsPlayerFreeAimed = function()
	if IsPlayerFreeAiming(PlayerInfo.playerID) or IsAimCamActive() or IsAimCamThirdPersonActive() then
		return true
	else
		return false
	end
end

CrouchLoop = function()
	SetupCrouch()
	while CrouchedForce do
		DisableFirstPersonCamThisFrame()

		local now = GetGameTimer()
		if now >= PlayerInfo.nextCheck then
			PlayerInfo.playerPed = PlayerPedId()
			PlayerInfo.playerID = GetPlayerIndex()
			PlayerInfo.nextCheck = now + 1500
		end

		local CanDo = CanCrouch()
		if CanDo and Crouched and IsPlayerFreeAimed() then
			SetPlayerAimSpeed()
		elseif CanDo and (not Crouched or Aimed) then
			CrouchPlayer()
		elseif not CanDo and Crouched then
			CrouchedForce = false
			NormalWalk()
		end

		Citizen.Wait(5)
	end
	NormalWalk()
	RemoveCrouchAnim()
end

RegisterCommand('crouch', function()
	DisableControlAction(0, 36, true) -- magic
	if not Cooldown then
		CrouchedForce = not CrouchedForce

		if CrouchedForce then
			CreateThread(CrouchLoop) -- Magic Part 2 lamo
		end

		Cooldown = true
		SetTimeout(CoolDownTime, function()
			Cooldown = false
		end)
	end
end, false)

RegisterKeyMapping('crouch', 'Crouch', 'keyboard', 'LCONTROL') -- now its better player can change to any bottom they want


-- Exports --
IsCrouched = function()
	return Crouched
end

exports("IsCrouched", IsCrouched)

