
ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
		PlayerData = ESX.GetPlayerData()
    --[[SendNUIMessage({
      type = "hide"
    })]]
	end
end)


--kill and death commands for test

RegisterCommand("kill", function()
  SendNUIMessage({
      type = "sendKill"
  })
end)

RegisterCommand("death", function()
  SendNUIMessage({
      type = "sendDeath"
  })
end)

RegisterCommand("reset", function()
  SendNUIMessage({
      type = "resetStatus"
  })
end)



AddEventHandler('gameEventTriggered',function(name,args)
  GameEventTriggered(name,args)
end)

function GameEventTriggered(eventName, data)
  if eventName == "CEventNetworkEntityDamage" then
    print("test")
      victim = tonumber(data[1])
      attacker = tonumber(data[2])
      victimDied = tonumber(data[4]) == 1 and true or false

      victimhealth = GetEntityHealth(tonumber(data[1]))
      print(victimhealth)

      weaponHash = tonumber(data[5])
      isMeleeDamage = tonumber(data[10]) ~= 0 and true or false 
      vehicleDamageTypeFlag = tonumber(data[11]) 
      local FoundLastDamagedBone, LastDamagedBone = GetPedLastDamageBone(victim)
      local bonehash = -1 
      if FoundLastDamagedBone then
        print("test2")
          bonehash = tonumber(LastDamagedBone)
      end
      
      local PPed = PlayerPedId()
      local distance = IsEntityAPed(attacker) and #(GetEntityCoords(attacker) - GetEntityCoords(victim)) or -1
      print("test3")
      if victim == PPed then 
        print("test4")
          if victimhealth == 0 then
            print("test5")
            SendNUIMessage({
              type = "sendDeath"
            })
          end 
      elseif attacker == PPed then
        print("test6")
          if victimhealth == 0 then
            print("test7")
            SendNUIMessage({
              type = "sendKill"
            })
          end
      end 
  end
end


local acik = false -- If you want it, just press the z key and it will open.
Citizen.CreateThread(function()
    while true do
     Citizen.Wait(0)

        if IsControlJustPressed(0, 20) then
          if exports['redzone']:isinredzone() == true then

          else
            if acik == false then 
              SendNUIMessage({
                type = "goster"
              })
              acik = true
            else
             SendNUIMessage({
                type = "hide"
              })
              acik = false
            end
          end
        end
    end
end)