local QBCore = nil
local assert = assert
local MenuV = assert(MenuV)

function CreateBlips()
        --[[for k, v in pairs(badge) do           
            local blip = AddBlipForCoord(v.location)
            SetBlipAsShortRange(blip, true)
            SetBlipSprite(blip, 546)
            SetBlipColour(blip, 46)
            SetBlipScale(blip, 0.6)
            SetBlipDisplay(blip, 6)

            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString(v.label)
            EndTextCommandSetBlipName(blip)
        end]]

        for k, v in pairs(Config.CardshopLocation) do
            local blip = AddBlipForCoord(v.location)
            SetBlipAsShortRange(blip, true)
            SetBlipSprite(blip, 500)
            SetBlipColour(blip, 2)
            SetBlipScale(blip, 0.3)
            SetBlipDisplay(blip, 6)

            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString(v.label)
            EndTextCommandSetBlipName(blip)
        end
    end

Citizen.CreateThread(function()
       CreateBlips()
end)

function DisplayTooltip(suffix)
    SetTextComponentFormat('STRING')
    AddTextComponentString('Press ~INPUT_PICKUP~ To ' .. suffix)
    EndTextCommandDisplayHelp(0, 0, 1, -1)
end

--[[Citizen.CreateThread(function()
    while true do
        Wait(1)
        local sleep = true
        local playerCoords = GetEntityCoords(GetPlayerPed(-1))
        
        for k, v in pairs(Config.CardshopLocation) do
            local loc = v.location
            local distance = GetDistanceBetweenCoords(playerCoords, loc, true)
            if distance < 2.5 then
                sleep = false
                DisplayTooltip('Sell Items')
                if IsControlJustPressed(1, 38) then
                    TriggerEvent('Cards:client:openMenu')
                    end
                end
            end
        
        for k, v in pairs(badge) do
            local loc = v.location
            local distance = GetDistanceBetweenCoords(playerCoords, loc, true)
            if distance < 2.5 then
                sleep = false
                DisplayTooltip('Trade for a '..v.label)
                if IsControlJustPressed(1, 38) then
            TriggerServerEvent('Cards:server:badges', k)
                end
            end
        end
    end
end)]]

RegisterNetEvent('Cards:server:tradeB')
AddEventHandler('Cards:server:tradeB', function()
    local playerCoords = GetEntityCoords(GetPlayerPed(-1))
    Wait(1)
    for k, v in pairs(badge) do
        local loc = v.location
        local distance = GetDistanceBetweenCoords(playerCoords, loc, true)
        if distance < 2.5 then
            TriggerServerEvent('Cards:server:badges', k)
        end
    end
end)

Citizen.CreateThread(function()
    Wait(1)
    for k, v in pairs(badge) do
        local loc = v.location
        exports['bt-target']:AddCircleZone("badge"..k, loc, 1.5, { name="badge"..k, debugPoly=false, useZ=true, },
        { options = { { event = "Cards:server:tradeB", icon = "fas fa-certificate", label = "Trade for "..v.label, }, },
            job = {"all"}, distance = 1
        })
    end
    exports['bt-target']:AddCircleZone("sellb", vector3(758.87,-816.09,26.29), 1.5, { name="sellb", debugPoly=false, useZ=true, },
    { options = { { event = "Cards:client:openMenu", icon = "fas fa-certificate", label = "Sell Cards", }, },
        job = {"all"}, distance = 1
    })
end)



Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if QBCore == nil then
            TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
            Citizen.Wait(200)
        end
    end
end)

RegisterNetEvent("Cards:Client:OpenPack")
AddEventHandler("Cards:Client:OpenPack", function(itemName)
    QBCore.Functions.Progressbar("drink_something", "opening pack..", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
       TriggerServerEvent("Cards:Server:rewarditem")       
    end)
end)

RegisterNetEvent("Cards:client:UseBox")
AddEventHandler("Cards:client:UseBox", function()
    TaskPlayAnim(PlayerPedId(), "clothingshirt", "try_shirt_positive_d", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
    --print('Box is Opening')
    --QBCore.Functions.Notify("Box is being opened...", "error")
    QBCore.Functions.Progressbar("use_bag", "Box is being opened", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        local RLBagData = {
            outfitData = {
                ["bag"]   = { item = 41, texture = 0},  -- Nek / Das
            }
        }
        --TriggerEvent('qb-clothing:client:loadOutfit', RallyBagData)
        --TriggerNetEvent('inventory:client:close')
        --Citizen.Wait(1500)
        TriggerServerEvent("inventory:server:OpenInventory", "pokeBox", "poke_"..QBCore.Functions.GetPlayerData().citizenid, {
            maxweight = 0,
            slots = 170,
        })
        TriggerEvent("inventory:client:SetCurrentStash", "poke_"..QBCore.Functions.GetPlayerData().citizenid)
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "invbag", 0.5)
        TaskPlayAnim(ped, "clothingshirt", "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
        --QBCore.Functions.Notify("Box has been opened successfully", "success")
    end)
end)

RegisterNetEvent("Cards:client:UseBadgeBox")
AddEventHandler("Cards:client:UseBadgeBox", function()
    TaskPlayAnim(PlayerPedId(), "clothingshirt", "try_shirt_positive_d", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
    QBCore.Functions.Progressbar("use_bag", "Badge Box is being opened", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        local RLBagData = {
            outfitData = {
                ["bag"]   = { item = 41, texture = 0},  -- Nek / Das
            }
        }
        TriggerServerEvent("inventory:server:OpenInventory", "pokeBox", "badge_"..QBCore.Functions.GetPlayerData().citizenid, {
            maxweight = 0,
            slots = 8,
        })
        TriggerEvent("inventory:client:SetCurrentStash", "badge_"..QBCore.Functions.GetPlayerData().citizenid)
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "invbag", 0.5)
        TaskPlayAnim(ped, "clothingshirt", "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
    end)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        QBCore.Functions.TriggerCallback("Cards:server:Menu",function(item,amount)
            print(item,amount)
        end)
    end
end)


--------------------------------------------------------
----------------MENU---------------------------------

--Config

local menu = MenuV:CreateMenu(false, 'Player Items', 'topright', 155, 0, 0, 'size-125', 'none', 'menuv', 'test3')
local menu2 = menu:InheritMenu({title = false, subtitle = 'Card Shop', theme = 'default' })
local menu_button = menu:AddButton({ icon = '🔖', label = 'Sell Cards/Badges', value = menu2, description = 'View List Of Items' })


--------------------------------------------------------------------

--[[RegisterCommand('openmenu', function() --test only--
    MenuV:OpenMenu(menu)
end)


RegisterCommand('closemenu', function()
    MenuV:CloseMenu(menu)
end)]]

RegisterNetEvent('Cards:client:openMenu')
AddEventHandler('Cards:client:openMenu', function()
    MenuV:OpenMenu(menu)
end)

menu_button:On('select', function(item)
    QBCore.Functions.TriggerCallback('Cards:server:get:drugs:items', function(CardsResult)
        for k, v in pairs(CardsResult) do
            local itemName = v['Item']
            local itemCount = v['Amount']
            local price = Config.CardshopItems[itemName]
            price = math.ceil(price * itemCount)

            local menu_button2 = menu2:AddButton({
                label = itemName .. " | Amount : " ..itemCount.." | $" .. price,
                name = itemName,
                value = {name = itemName, count = itemCount, price = price},

            select = function(btn)
                local select = btn.Value -- get all the values from v!
                TriggerServerEvent('Cards:sellItem', select.name, select.count, select.price)
                menu2:ClearItems(false)
                
            end})
        end
    end)
end)

RegisterNetEvent('Cards:view', function(nui)
    SetNuiFocusKeepInput(true)
    SetNuiFocus(true,false)
    SendNUIMessage({
        nui = nui,
        --information = info
    })
    Wait(5000)
    SetDisplay(false)
end)

RegisterNUICallback("escape", function()
    SetNuiFocus(false)
end)
