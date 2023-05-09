--------------------------------
--- RP Revive, Made by FAXES ---
--------------------------------

--- Config ---

local bypassRoles = { -- Discord Role ID(s) that can bypass the revive wait time. Leave this as it is if you don't want this function.
    "DISCORD_ROLE_ID",
}


--- Code ---

RegisterNetEvent('sendToDisc')
AddEventHandler('sendToDisc', function(color, name, title, message, footer)
  local embed = {
    {
      ["color"] = color,
      ["title"] = "**".. title .."**",
      ["description"] = message,
      ["footer"] = {
        ["text"] = footer
      }
    }
  }

  local jsonData = {
    username = name,
    embeds = embed
  }

  local headers = {
    ["Content-Type"] = "application/json"
  }

  PerformHttpRequest('https://discord.com/api/webhooks/1096167916669521940/G8xuuOFzhQNRmu-lkHPejHYh8i63OCVSllKPV0_-wwDDHOZ1ehD7KAU6RNBQsFz_QJph', function(err, text, headers) end, 'POST', json.encode(jsonData), headers)
end)





