    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)




RegisterNetEvent('admin:noClip')
AddEventHandler('admin:noClip', function()
local xPlayer = ESX.GetPlayerFromId(source)
TriggerClientEvent('admin:toggleNoClip', source)
authorized = true
end)



function GetSteamID(source)
    local sid = false

    for _,v in pairs(GetPlayerIdentifiers(source))do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            sid = v
        end
    end

	return sid
end