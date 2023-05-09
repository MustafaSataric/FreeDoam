local ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj  end)

ESX.RegisterServerCallback("Admin:getRankFromPlayer", function(source, cb)
    local player = ESX.GetPlayerFromId(source)

    if player ~= nil then
        local playerGroup = player.getGroup()

        if playerGroup ~= nil then 
            cb(playerGroup)
        else
            cb("user")
        end
    else
        cb("user")
    end
end)

local dutyStatus = "aktivirao"

function sendToDiscord(color, name, title, message, footer)
	local embed = {
		  {
			  ["color"] = color,
			  ["title"] = "**".. title .."**",
			  ["description"] = message,
			  ["footer"] = {
				  ["text"] = footer,
			  },
		  }
	  }  
	PerformHttpRequest('https://discord.com/api/webhooks/1095451729736237096/gbJ1vosrjI5YNce-JyDFQjQB_Z8wzzYLpis63PBai9a2_wHjSh4GNGRPSWaStiXYyQot', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent('bringplayertome')
AddEventHandler('bringplayertome', function(target,x,y,z)
    TriggerClientEvent('teleport', target, x, y, z)
end)


RegisterServerEvent('reloadchar')
AddEventHandler('reloadchar', function(target)
    TriggerClientEvent('rw:setplayerinclouds', target)
    Wait(500)
    TriggerClientEvent('rw:endjoinsession', target)
end)

local ticketData = {}

RegisterServerEvent('rw:closeTicket')
AddEventHandler('rw:closeTicket', function(id)
    TriggerClientEvent('notifications', ticketData[id]["id"], "#1df5fc", "TICKETSYSTEM", "Dein Ticket wurde geschlossen.")
    TriggerClientEvent('notifications', source, "#1df5fc", "TICKETSYSTEM", "Du hast das Ticket geschlossen.")
    ticketData[id] = nil
end)

RegisterCommand("supportcancel", function(source, args)
    TriggerClientEvent('notifications', source, "#1df5fc", "TICKETSYSTEM", "Du hast deine Tickets geschlossen.")
    for k, v in pairs(ticketData) do
        if k ~= nil then
            if ticketData[k]["id"] == source then
                ticketData[k] = nil
            end
        end
    end
end, false)

RegisterServerEvent('rw:loadSupportAPP')
AddEventHandler('rw:loadSupportAPP', function()
    for k, v in pairs(ticketData) do
        if k ~= nil then
            TriggerClientEvent('rw:addTicket', source, ticketData[k]["name"], ticketData[k]["id"], ticketData[k]["msg"], tostring(k))
        end
    end
end)

RegisterServerEvent('sendticket')
AddEventHandler('sendticket', function(msg)
    ticketData[math.random(100,999)] = {["msg"] = msg, ["name"] = GetPlayerName(source), ["id"] = source}
    TriggerClientEvent('adminnotify', -1, msg, GetPlayerName(source) .. " | ID: " .. source)
    sendToDiscord("12745742", "Ticketsystem", GetPlayerName(source) .." | ID: ".. source .."", "\n**Grund:** "..msg, "Ticketsystem v1.0 by EvolutionLife")
    TriggerClientEvent('rw:addTicket', -1, GetPlayerName(source), source, msg, "/")
end)

RegisterServerEvent('tc')
AddEventHandler('tc', function(msg)
    TriggerClientEvent('adminnotify2', -1, msg, GetPlayerName(source) .. " | ID: " .. source)
end)


ESX.RegisterServerCallback('rw:getGroup', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    cb(xPlayer.getGroup())
end)

RegisterCommand("adms", function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "superadmin" or xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "mod" or xPlayer.getGroup() == "support" or xPlayer.getGroup() == "_dev" then
        TriggerClientEvent('toggleAduty', source)
	if dutyStatus == "deaktivirao" then
		dutyStatus = "aktvirao"
	else
		dutyStatus = "deaktivirao"

	end
    else
        TriggerClientEvent('notifications', source, "#1df5fc", "Admindienst", "Du hast keine Rechte.")
    end
end, false)

RegisterCommand("adma", function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "superadmin" or xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "mod" or xPlayer.getGroup() == "support" or xPlayer.getGroup() == "_dev" then
        -- Get player coordinates
        local playerPed = GetPlayerPed(source)
        local playerCoords = GetEntityCoords(playerPed)

        -- Spawn Admin Charger near player
        local blista = CreateVehicle('admincharger', playerCoords.x, playerCoords.y, playerCoords.z + 1, GetEntityHeading(playerPed), true, false)
            
sendToDiscord("12745742", "Harri Dzekson", GetPlayerName(source) .." | ID: ".. source .."", "\n**Admin je spavnao Admin Vozilo** ", "Harri Dzekson")

        -- Set player as driver
        SetPedIntoVehicle(playerPed, blista, -1)      end
end, false)


TriggerEvent("es:addGroupCommand", "ad", "superadmin", function(source, args)
    TriggerClientEvent("toggleAduty", source)
end, function(source, args)
    TriggerEvent('notifications', "#1df5fc", "ENTWICKLER-MODUS", "Keine Rechte.")
end)

TriggerEvent("es:addGroupCommand", "cmduty", "mod", function(source, args)
    TriggerClientEvent("toggleAduty", source)
end, function(source, args)
    TriggerEvent('notifications', "#1df5fc", "ADMINISTRATION", "Keine Rechte.")
end)

TriggerEvent("es:addGroupCommand", "saduty", "admin", function(source, args)
    TriggerClientEvent("toggleAduty", source)
end, function(source, args)
    TriggerEvent('notifications', "#1df5fc", "ADMINISTRATION", "Keine Rechte.")
end)

RegisterCommand("obavestenje", function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "superadmin" or xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "mod" or xPlayer.getGroup() == "support" or xPlayer.getGroup() == "_dev" then
	TriggerClientEvent('announce', -1, "~r~OBAVESTENJE", table.concat(args, " "), 5)

    sendToDiscord("12745742", "Harri Dzekson", GetPlayerName(source) .." | ID: ".. source .."", "\n**Obavestenje:** ".. table.concat(args, " "), "Harri Dzekson")
    else
        TriggerClientEvent('notifications', source, "#1df5fc", "AdDuty", "Nemate permisije.")
    end
end, false)


-- player join messages
AddEventHandler('playerJoining', function()
    if GetConvarInt('chat_showJoins', 1) == 0 then
        return
    end
        TriggerClientEvent('chat:addMessage', -1 , { templateId = 'ccChat', multiline = false, args = { '#00ff00', 'fa-solid fa-globe', 'Ulaz' , '', 'Igrac: ' .. GetPlayerName(source) .. ' ulazi na server.' } })

--  TriggerClientEvent('chatMessage', -1, '', { 255, 255, 255 }, '^2* ' .. GetPlayerName(source) .. ' joined.')
   
end)

AddEventHandler('playerDropped', function(reason)
    if GetConvarInt('chat_showQuits', 1) == 0 then
        return
    end


    TriggerClientEvent('chat:addMessage', -1 , { templateId = 'ccChat', multiline = false, args = { ' #ff0000', 'fa-solid fa-globe', 'Izlaz' , '', 'Igrac: ' .. GetPlayerName(source) .. ' je napustio server (' .. reason .. ').' } })

--    TriggerClientEvent('chatMessage', -1, '', { 255, 255, 255 }, '^2* ' .. GetPlayerName(source) ..' left (' .. reason .. ')')
end)

-- Define the time interval (in seconds) between vehicle deletions
local deleteInterval = 540 -- 9 minutes

-- Define the announcement message

-- Define a function to delete all vehicles in the game world
function deleteVehicles()
    for _, vehicle in ipairs(GetAllVehicles()) do
        DeleteEntity(vehicle)
    end
end


-- Start a timer to delete vehicles at regular intervals
Citizen.CreateThread(function()
    while true do
    TriggerClientEvent('chat:addMessage', -1 , { templateId = 'ccChat', multiline = false, args = { '#e74c3c', 'fa-solid fa-globe', 'SERVER' , '', "Sva vozila bit ce izbrisana za jednu minutu."} })

--	TriggerClientEvent('chat:addMessage', -1, { args = { "^1[Server]", "Sva vozila bit ce izbrisana za jednu minutu." } })
	Citizen.Wait(60000)
        deleteVehicles()	
    TriggerClientEvent('chat:addMessage', -1 , { templateId = 'ccChat', multiline = false, args = { '#e74c3c', 'fa-solid fa-globe', 'SERVER' , '', 'Sva vozila su izbrisana.' } })
        Citizen.Wait(deleteInterval * 1000)

    end
end)


RegisterCommand("uuid", function(source, args)
print("a")
  local identifier = GetPlayerIdentifiers(source)[1] -- Verwende die erste Spieleridentifikationsnummer als Benutzer-ID
  local query = [[SELECT jbg FROM users WHERE identifier = @identifier]]
  local parameters = {['@identifier'] = identifier}
  oxmysql.execute(query, parameters, function(result)
    if result[1] ~= nil then
      local jbg = result[1].jbg
      TriggerClientEvent('chat:addMessage', source, {args = {"Dein jbg ist: ", jbg}})
    else
      TriggerClientEvent('chat:addMessage', source, {args = {"Dein jbg konnte nicht gefunden werden."}})
    end
  end)
end)
