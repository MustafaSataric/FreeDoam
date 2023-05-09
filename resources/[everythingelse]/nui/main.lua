local display = false


RegisterKeyMapping("glavni", "Ugasite informacije", "keyboard", "escape")
RegisterCommand("off", function(source)
  if display then
        TriggerEvent("nui:off", true)
        display = false
  else
    TriggerEvent("nui:on", true)
    display = true
  end
end)


  --[[ ////////////////////////////////////////// ]]

  RegisterNetEvent('nui:on')
  AddEventHandler('nui:on', function()
    SendNUIMessage({
      type = "ui",
      display = true
    })
  end)

  RegisterNetEvent('nui:off')
  AddEventHandler('nui:off', function()
    SendNUIMessage({
      type = "ui",
      display = false
    })
  end)
