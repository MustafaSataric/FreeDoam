--------------------------------
--- RP Revive, Made by FAXES ---
--------------------------------

--- Config ---

local reviveWait = 5 -- Change the amount of time to wait before allowing revive (in seconds).
local featureColor = "~y~" -- Game color used as the button key colors.

--- Code ---
local timerCount = reviveWait
local isDead = false
cHavePerms = false

TriggerEvent( "chat:addSuggestion", "/dv", "Briše vozilo u kojem sedite ili stojite pored njega." )
TriggerEvent( "chat:addSuggestion", "/a", "Opremi vas pancirom." )
TriggerEvent( "chat:addSuggestion", "/-a", "Skine vam pancir." )
TriggerEvent( "chat:addSuggestion", "/h", "Napunite vas health na 100%." )
TriggerEvent( "chat:addSuggestion", "/tpm", "Teleportuje vas na vašu izabranu lokaciju." )
TriggerEvent( "chat:addSuggestion", "/report", "Sa ovom komandom mozete zatraziti pomoc od Staffa.", {

    { name="Razlog", help="Unesite razlog vaseg reporta." }
})


RegisterCommand('a', function(source, args, rawCommand)
    if not isDead then
    SetPedArmour(PlayerPedId(), 100)
        Notify( "~g~Stavili ste pancir.." )
           TriggerServerEvent('sendToDiscord',"12745742", "Harri Dzekson", GetPlayerName(source) .." | ID: ".. PlayerPedId() .."", "\n**Igrac je izkoristi komandu /a** ", "Harri Dzekson")
	end
end, false)

RegisterCommand('-a', function(source, args, rawCommand)
    if not isDead then
    SetPedArmour(PlayerPedId(), 0)
        Notify( "~g~Skinuli ste pancir." )
           TriggerServerEvent('sendToDiscord',"12745742", "Harri Dzekson", GetPlayerName(source) .." | ID: ".. PlayerPedId() .."", "\n**Igrac je izkoristi komandu /-a** ", "Harri Dzekson")
	end
end, false)


RegisterCommand('h', function(source, args, rawCommand)
    if not isDead then
        SetEntityHealth(PlayerPedId(), 200)
        Notify( "~g~Izlijecen ste." )
           TriggerServerEvent('sendToDiscord',"12745742", "Harri Dzekson", GetPlayerName(source) .." | ID: ".. PlayerPedId() .."", "\n**Igrac je izkoristi komandu /h** ", "Harri Dzekson")
	end
end, false)

RegisterCommand("tpm", function(source)
        local waypointBlip = GetFirstBlipInfoId( 8 ) 
        if DoesBlipExist(waypointBlip) then          
	        local coord = Citizen.InvokeNative( 0xFA7C7F0AADF25D09, waypointBlip, Citizen.ResultAsVector( ) ) 
	        local x  = coord.x
	        local y = coord.y
	        local z = coord.z
            for z = 1, 1000 do
                SetPedCoordsKeepVehicle(PlayerPedId(), x, y, z + 0.0)

                local foundGround, zPos = GetGroundZFor_3dCoord(x, y, z + 0.0)

                if foundGround then
                    SetPedCoordsKeepVehicle(PlayerPedId(), x, y, z + 0.0)
			        Notify( "~g~Teleportovani ste" )
           TriggerServerEvent('sendToDiscord',"12745742", "Harri Dzekson", GetPlayerName(source) .." | ID: ".. PlayerPedId() .."", "\n**Igrac je izkoristi komandu /tmp i nalazi se na lokaciji ** vector3 = {" .. x .. " , " .. y .. " , " .. z .. " }" , "Harri Dzekson")
                    break
                end

                Citizen.Wait(5)
            end
        else
		        Notify( "~y~Morate oznacit lokaciju." )
        end
    end)

RegisterCommand( "dv", function()
    TriggerEvent( "wk:deleteVehicle" )
           TriggerServerEvent('sendToDiscord',"12745742", "Harri Dzekson", GetPlayerName(source) .." | ID: ".. PlayerPedId() .."", "\n**Igrac je izkoristi komandu /dv** ", "Harri Dzekson")

end, false )

-- The distance to check in front of the player for a vehicle   
local distanceToCheck = 5.0

-- The number of times to retry deleting a vehicle if it fails the first time 
local numRetries = 5

-- Add an event handler for the deleteVehicle event. Gets called when a user types in /dv in chat
RegisterNetEvent( "wk:deleteVehicle" )
AddEventHandler( "wk:deleteVehicle", function()
    local ped = GetPlayerPed( -1 )

    if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
        local pos = GetEntityCoords( ped )

        if ( IsPedSittingInAnyVehicle( ped ) ) then 
            local vehicle = GetVehiclePedIsIn( ped, false )

            if ( GetPedInVehicleSeat( vehicle, -1 ) == ped ) then 
                DeleteGivenVehicle( vehicle, numRetries )
            else 
                Notify( "You must be in the driver's seat!" )
            end 
        else
            local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords( ped, 0.0, distanceToCheck, 0.0 )
            local vehicle = GetVehicleInDirection( ped, pos, inFrontOfPlayer )

            if ( DoesEntityExist( vehicle ) ) then 
                DeleteGivenVehicle( vehicle, numRetries )
            else 
                Notify( "~y~Da biste vozilo izbrisali, morate sjediti u vozilu ili stojati blizu njega." )
            end 
        end 
    end 
end )

function DeleteGivenVehicle( veh, timeoutMax )
    local timeout = 0 

    SetEntityAsMissionEntity( veh, true, true )
    DeleteVehicle( veh )

    if ( DoesEntityExist( veh ) ) then
        Notify( "~r~Brisanje vozila nije uspjelo, pokušajemo ponovo..." )

        -- Fallback if the vehicle doesn't get deleted
        while ( DoesEntityExist( veh ) and timeout < timeoutMax ) do 
            DeleteVehicle( veh )

            -- The vehicle has been banished from the face of the Earth!
            if ( not DoesEntityExist( veh ) ) then 
        Notify( "~g~Vozilo izbrisano" )
            end 

            -- Increase the timeout counter and make the system wait
            timeout = timeout + 1 
            Citizen.Wait( 500 )

            -- We've timed out and the vehicle still hasn't been deleted. 
            if ( DoesEntityExist( veh ) and ( timeout == timeoutMax - 1 ) ) then
                Notify( "~r~Brisanje vozila nije uspjelo posle " .. timeoutMax .. " pokušaja." )
            end 
        end 
    else 
        Notify( "~g~Vozilo izbrisano" )
    end 
end 

-- Gets a vehicle in a certain direction
-- Credit to Konijima
function GetVehicleInDirection( entFrom, coordFrom, coordTo )
	local rayHandle = StartShapeTestCapsule( coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 5.0, 10, entFrom, 7 )
    local _, _, _, _, vehicle = GetShapeTestResult( rayHandle )
    
    if ( IsEntityAVehicle( vehicle ) ) then 
        return vehicle
    end 
end


--PAUZA
Citizen.CreateThread(function()
  AddTextEntry('PM_PANE_LEAVE', '~y~Izadji sa servera')
  AddTextEntry('PM_PANE_QUIT', '~y~Napusti igricu')
  AddTextEntry('PM_SCR_MAP', '~y~Mapa')
  AddTextEntry('PM_SCR_GAM', '~y~Igrica')
  AddTextEntry('PM_SCR_INF', '~y~Informacije')
  AddTextEntry('PM_SCR_SET', '~y~Podesavanja')
  AddTextEntry('PM_SCR_STA', '~y~Statistika')
  AddTextEntry('PM_SCR_GAL', '~y~Galerija')
  AddTextEntry('PM_SCR_RPL', '~y~Rockstar ?')
end)

function SetData()
    local name = GetPlayerName(PlayerId())
    local id = GetPlayerServerId(PlayerId())
    Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), 'FE_THDR_GTAO', '~b~[Balkan] ~y~MILF GANGWAR | ~y~ID~y~:~b~ ' .. id .. ' | ~y~Ime~y~: ~b~' .. name .. ' | ~y~discord.gg/ ~b~tctdvX3MTb')
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(3000)
        SetData()
    end
end)

function AddTextEntry(key, value)
    Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    HideHudComponentThisFrame(3) -- Versteckt den Bargeldbetrag
    HideHudComponentThisFrame(4) -- Versteckt den Bankbetrag
    HideHudComponentThisFrame(7)
    HideHudComponentThisFrame(9)
  end
end)



AddEventHandler('playerSpawned', function()
    local src = source
    TriggerServerEvent("RPRevive:CheckPermission", src)
end)

RegisterNetEvent("RPRevive:CheckPermission:Return")
AddEventHandler("RPRevive:CheckPermission:Return", function(havePerms)
	cHavePerms = havePerms
end)

-- Turn off automatic respawn here instead of updating FiveM file.
AddEventHandler('onClientMapStart', function()
	SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
	Citizen.Trace("RPRevive: Disabling the autospawn.")
	exports.spawnmanager:spawnPlayer() -- Ensure player spawns into server.
	Citizen.Wait(2500)
	exports.spawnmanager:setAutoSpawn(false)
	Citizen.Trace("RPRevive: Autospawn is disabled.")
end)

function respawnPed(ped, coords)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, coords.heading, true, false) 
	SetPlayerInvincible(ped, false) 
	TriggerEvent('playerSpawned', coords.x, coords.y, coords.z, coords.heading)
	ClearPedBloodDamage(ped)
           TriggerServerEvent('sendToDiscord',"12745742", "Harri Dzekson", GetPlayerName(source) .." | ID: ".. PlayerPedId() .."", "\n**Igrac je se respawnao** ", "Harri Dzekson")
end

function revivePed(ped)
	local playerPos = GetEntityCoords(ped, true)
	isDead = false
	timerCount = reviveWait
           TriggerServerEvent('sendToDiscord',"12745742", "Harri Dzekson", GetPlayerName(source) .." | ID: ".. PlayerPedId() .."", "\n**Igrac je se revivo** ", "Harri Dzekson")
	NetworkResurrectLocalPlayer(playerPos, true, true, false)
	SetPlayerInvincible(ped, false)
	ClearPedBloodDamage(ped)
end

function ShowInfoRevive(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentSubstringPlayerName(text)
	DrawNotification(true, true)
end

Citizen.CreateThread(function()
	local respawnCount = 0
	local spawnPoints = {}
	local playerIndex = NetworkGetPlayerIndex(-1) or 0
	math.randomseed(playerIndex)

	function createSpawnPoint(x1, x2, y1, y2, z, heading)
		local xValue = math.random(x1,x2) + 0.0001
		local yValue = math.random(y1,y2) + 0.0001

		local newObject = {
			x = xValue,
			y = yValue,
			z = z + 0.0001,
			heading = heading + 0.0001
		}
		table.insert(spawnPoints,newObject)
	end

	createSpawnPoint(-448, -448, -340, -329, 35.5, 0) -- Mount Zonah
	createSpawnPoint(372, 375, -596, -594, 30.0, 0)   -- Pillbox Hill
	createSpawnPoint(335, 340, -1400, -1390, 34.0, 0) -- Central Los Santos
	createSpawnPoint(1850, 1854, 3700, 3704, 35.0, 0) -- Sandy Shores
	createSpawnPoint(-247, -245, 6328, 6332, 33.5, 0) -- Paleto


    while true do
    Citizen.Wait(0)
		ped = GetPlayerPed(-1)
        if IsEntityDead(ped) then
			isDead = true
            SetPlayerInvincible(ped, true)
            SetEntityHealth(ped, 1)
			ShowInfoRevive('Umrli ste. Koristite ~y~E ~w~ da se ozivite, ili ~y~R ~w~ da se stvorite pred Bolnicom.')
            if IsControlJustReleased(0, 38) and GetLastInputMethod(0) then
                if timerCount <= 0 or cHavePerms then
                    revivePed(ped)
    			SetPedArmour(PlayerPedId(), 100)
				else
				--	Notify("~r~Sacekajte jos " .. timerCount .. "sekundi prije ozivljavanja.")
                end	
            elseif IsControlJustReleased(0, 45) and GetLastInputMethod( 0 ) then
		
		 local coords = spawnPoints[math.random(1,#spawnPoints)]
				respawnPed(ped, coords)
				isDead = false
				timerCount = reviveWait
				respawnCount = respawnCount + 1
				math.randomseed(playerIndex * respawnCount)
		SetPedArmour(PlayerPedId(), 100)
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        if isDead then
			timerCount = timerCount - 1
        end
        Citizen.Wait(1000)          
    end
end)

-- Shows a notification on the player's screen 
function Notify( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end
