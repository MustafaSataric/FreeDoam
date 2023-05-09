local svConfig = {}

-- Configuration
 svConfig.versionChecker = true -- Version Checker
 svConfig.supportChecker = true -- Support Checker (If you use exports, it is recommended that you leave this on)

-- Script
AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    if GetCurrentResourceName() ~= 'cc-chat' and svConfig.supportChecker == true then
        print('^6[Warning]^0 For better support, it is recommended that "'..GetCurrentResourceName().. '" be renamed to "cc-chat"')
    end
    if svConfig.versionChecker == true then
        PerformHttpRequest('https://api.github.com/repos/Concept-Collective/cc-chat/releases/latest', function (err, data, headers)
            local data = json.decode(data)
            if data.tag_name ~= 'v'..GetResourceMetadata(GetCurrentResourceName(), 'version', 0) then
                print('\n^1================^0')
                print('^1CC Chat ('..GetCurrentResourceName()..') is outdated!^0')
                print('Current version: (^1v'..GetResourceMetadata(GetCurrentResourceName(), 'version', 0)..'^0)')
                print('Latest version: (^2'..data.tag_name..'^0) '..data.html_url)
                print('Release notes: '..data.body)
                print('^1================^0')
            end
        end, 'GET', '')
    end
TriggerEvent('chat:addSuggestion', -1, '/ooc', 'Out of character command', {
      { name="Message", help="The message you would like to send to the chat" }
    })
    TriggerEvent('chat:addSuggestion', -1, '/tweet', 'Komanda za pisanje tweeta u chat', {
      { name="Message", help="Vasa poruka." }
    })

end)


RegisterCommand('ooc', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(5)
    sendChatMessage('#3498db', 'fa-solid fa-globe', 'OOC | '..playerName, '', msg)
end, false)

    

function sendChatMessage(color, icon, subtitle, timestamp, msg)
    TriggerClientEvent('chat:addMessage', -1 , { templateId = 'ccChat', multiline = false, args = { color, icon, subtitle, timestamp, msg } })
end


RegisterCommand('tweet', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(6)
    sendChatMessage('#243a54', 'fa-solid fa-globe', 'TWETOVAO | '..playerName .. " [ " .. source .. " ]" , '', msg)
end, false)

function sendChatMessage(color, icon, subtitle, timestamp, msg)
    TriggerClientEvent('chat:addMessage', -1 , { templateId = 'ccChat', multiline = false, args = { color, icon, subtitle, timestamp, msg } })
end

RegisterCommand('ooc', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(5)
    sendChatMessage('#243a54', 'fa-solid fa-globe', 'OOC | '..playerName .. " [ " .. source .. " ]", '', msg)
end, false)

    TriggerEvent('chat:addSuggestion', -1, '/ooc', 'Komanda za pisanje u chat', {
      { name="Message", help="Vasa poruka." }
    })

function sendChatMessage(color, icon, subtitle, timestamp, msg)
    TriggerClientEvent('chat:addMessage', -1 , { templateId = 'ccChat', multiline = false, args = { color, icon, subtitle, timestamp, msg } })
end


-- Überschreibe das 'chat' Event, um die eingehenden Nachrichten abzufangen
  AddEventHandler('chatMessage', function(source, name, message)
  if string.sub(message, 1, 1) ~= "/" then
    local playerName = GetPlayerName(source)
    sendChatMessage('#243a54', 'fa-solid fa-globe', 'Poruka | '..playerName .. " [ " .. source .. " ]", '', message)
  end
end)





RegisterCommand('restartIncoming', function(source, args, rawCommand)
    if source == 0 then -- Überprüfen, ob der Befehl von der Live-Konsole ausgeführt wird
    TriggerClientEvent('chat:addMessage', -1, {
      templateId = 'ccChat',
      multiline = false,
      args = {
        '#e74c3c',
        'fa-solid fa-globe',
        'SERVER',
        '',
        'AUTOMATSKI RESTART JE ZA 1 MINUT, POSLE NJEGA SE ODMA OPET MOZETE CONNECTAT NA SERVER.'
      }
    })
    end
end, false)

