local NoClipStatus = false
local NoClipEntity = false
local FollowCamMode = true
local index = 1
local CurrentSpeed = Config.Speeds[index].speed




local dutyStatus = "aktivirao"
local startCoords = GetEntityCoords(GetPlayerPed(source))


Citizen.CreateThread(function()
    while true do
        while NoClipStatus do
            DisableAllControlActions()
            EnableControlAction(0, 1, true)
            EnableControlAction(0, 2, true)

            local yoff = 0.0
            local zoff = 0.0

			if IsDisabledControlPressed(0, Config.Controls.goForward) then
                yoff = Config.Offsets.y
			end
			
            if IsDisabledControlPressed(0, Config.Controls.goBackward) then
                yoff = -Config.Offsets.y
			end

            if IsDisabledControlPressed(0, Config.Controls.goUp) then
                zoff = Config.Offsets.z
			end
			
            if IsDisabledControlPressed(0, Config.Controls.goDown) then
                zoff = -Config.Offsets.z
			end

            if not FollowCamMode and IsDisabledControlPressed(0, Config.Controls.turnLeft) then
                SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())+Config.Offsets.h)
			end
			
            if not FollowCamMode and IsDisabledControlPressed(0, Config.Controls.turnRight) then
                SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())-Config.Offsets.h)
			end
			
            local newPos = GetOffsetFromEntityInWorldCoords(NoClipEntity, 0.0, yoff * (CurrentSpeed + 0.3), zoff * (CurrentSpeed + 0.3))
            local heading = GetEntityHeading(NoClipEntity)
            
            SetEntityVelocity(NoClipEntity, 0.0, 0.0, 0.0)
            SetEntityRotation(NoClipEntity, 0.0, 0.0, 0.0, 0, false)
            if(FollowCamMode) then
                SetEntityHeading(NoClipEntity, GetGameplayCamRelativeHeading());
            else
                SetEntityHeading(NoClipEntity, heading);
            end
            SetEntityCoordsNoOffset(NoClipEntity, newPos.x, newPos.y, newPos.z, true, true, true)

            SetLocalPlayerVisibleLocally(true);
            Citizen.Wait(0)
        end
        Citizen.Wait(0)
    end
end)





RegisterNetEvent('admin:toggleNoClip')
AddEventHandler('admin:toggleNoClip', function()
if dutyStatus == "aktivirao" then
startCoords = GetEntityCoords(GetPlayerPed(source))
end

    if not NoClipStatus then
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            NoClipEntity = GetVehiclePedIsIn(PlayerPedId(), false)
        else
            NoClipEntity = PlayerPedId()
        end

        SetEntityAlpha(NoClipEntity, 51, 0)
        if(NoClipEntity ~= PlayerPedId()) then
            SetEntityAlpha(PlayerPedId(), 51, 0)
        end
	dutyStatus = "aktvirao"
    else
        ResetEntityAlpha(NoClipEntity)
  local playerCoords = GetEntityCoords(GetPlayerPed(source))
    exports.JD_logs:discord("Igrac je izkoristio  ** NoClip** \n Pocetne Koordinate: x=" .. startCoords.x .. " y=" .. startCoords.y .. " z=" .. startCoords.z .."\n Zavrsne Koordinate: x=" .. playerCoords.x .. " y=" .. playerCoords.y .. " z=" .. playerCoords.z, source, source, '12745742', 'comands')

        if(NoClipEntity ~= PlayerPedId()) then
            ResetEntityAlpha(PlayerPedId())
        end
	dutyStatus = "deaktivirao"
	-- sendToDiscord("12745742", "Harri Dzekson", GetPlayerName(source) .."| ID: ".. source .."", "\nIgrac je izkoristio  ** NoClip** \n Pocetne Koordinate: x=" .. startCoords.x .. " y=" .. startCoords.y .. " z=" .. startCoords.z .."\n Zavrsne Koordinate: x=" .. playerCoords.x .. " y=" .. playerCoords.y .. " z=" .. playerCoords.z, "Harri Dzekson")
  
  end
   
    SetEntityCollision(NoClipEntity, NoClipStatus, NoClipStatus)
    FreezeEntityPosition(NoClipEntity, not NoClipStatus)
    SetEntityInvincible(NoClipEntity, not NoClipStatus)
    SetEntityVisible(NoClipEntity, NoClipStatus, not NoClipStatus);
    SetEveryoneIgnorePlayer(PlayerPedId(), not NoClipStatus);
    SetPoliceIgnorePlayer(PlayerPedId(), not NoClipStatus);

    NoClipStatus = not NoClipStatus
end)

RegisterCommand('noclip', function()
    if NoClipStatus then
        TriggerEvent('admin:toggleNoClip')
    else
        TriggerServerEvent('admin:noClip')
    end
end, false)

RegisterCommand('noclip_cam', function()
    FollowCamMode = not FollowCamMode
end, false)

RegisterCommand('noclip_speed', function()
    if index ~= #Config.Speeds then
        index = index+1
        CurrentSpeed = Config.Speeds[index].speed
    else
        CurrentSpeed = Config.Speeds[1].speed
        index = 1
    end
end, false)

RegisterKeyMapping('noclip', 'Toggle NoClip', 'keyboard', Config.Controls.toggle)
RegisterKeyMapping('noclip_cam', 'NoClip Camera', 'keyboard', Config.Controls.camMode)
RegisterKeyMapping('noclip_speed', 'NoClip Speed', 'keyboard', Config.Controls.changeSpeed)