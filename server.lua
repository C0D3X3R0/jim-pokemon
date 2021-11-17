QBCore = nil

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

local basicCards = {"bulbasaur", "ivysaur", "charmander", "charmeleon", "squirtle", "wartortle", "caterpie", "metapod", "butterfree", "weedle", "kaknua", "beedrill", "pidgey","pidgeotto", "pidgeot", "rattata", "raticate", "spearow", "fearow", "ekans", "arbok", "pikachu", "sandshrew", "sandslash", "nidoran", "nidorina", "nidoqueen", "nidorino", "clefairy","clefable", "vulpix", "ninetails", "zubat", "golbat", "oddish", "gloom", "vileplume", "paras", "parasect", "venonat", "venomoth", "diglett", "dugtrio", "meowth", "persian", "psyduck","golduck", "mankey", "primeape", "growlithe", "arcanine", "poliwag", "polywhirl", "poliwrath", "abra","machop", "machoke", "bellsprout", "weepinbell", "victreebel", "tentacool","tentacruel", "geodude", "graveler", "golem", "ponyta", "rapidash", "slowpoke", "slowbro", "magnemite", "magneton", "farfetchd", "doduo", "dodrio", "seel", "dewgong", "grimer", "muk", "shellder", "cloyster","gastly", "haunter", "gengar", "drowzee", "hypno", "krabby", "kingler", "voltorb", "electrode", "exeggcute", "exeggutor", "cubone", "marowak", "lickitung", "koffing", "weezing", "rhyhorn", "rhydon", "chansey", "tangela", "horsea", "seadra", "goldeen", "seaking", "staryu", "mr_mime",  "electabuzz", "magmar", "pinsir", "tauros", "magikarp"}
local rareCards = {"lapras", "eevee", "togepi", "vaporeon", "jolteon", "flareon", "jigglypuff","wigglytuff", "kadabra","raichu", "nidoking",  "jynx", "kangaskhan", "gyarados","ditto","starmie", "onix", "machamp", "scyther", "hitmonlee", "hitmonchan", "venusaur" }
local ultraCards = {"charizard", "blastoise","porygon", "omanyte", "omastar", "dragonite", "mewtwo", "mew", "snorlax", "articuno", "zapdos", "kabuto", "kabutops", "aerodactyl", "moltres", "dratini", "dragonair"}
local vCards = {"blastoisev", "charizardv", "mewv", "pikachuv", "snorlaxv", "venusaurv"}
local vmaxCards = {"blastoisevmax", "mewtwogx", "snorlaxvmax", "venusaurvmax", "vmaxcharizard", "vmaxpikachu"}
local rainbowCards = {"rainbowmewtwogx", "rainbowvmaxcharizard", "rainbowvmaxpikachu", "snorlaxvmaxrainbow"}

local basicTotal = #basicCards
local rareTotal = #rareCards
local ultraTotal = #ultraCards
local vTotal = #vCards
local vmaxTotal = #vmaxCards
local rainboxTotal = #rainbowCards

QBCore.Functions.CreateUseableItem("boosterbox", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.RemoveItem(item.name, 1, item.slot, item.info) then
        TriggerClientEvent("Cards:Client:OpenCards", source, item.name)
			local xPlayer = QBCore.Functions.GetPlayer(source)
				xPlayer.Functions.AddItem('boosterpack', 4)
                TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items["boosterbox"], "remove", 1)
                 Citizen.Wait(500)
                TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items["boosterpack"], "add", 4)
           --Citizen.Wait(4000)
        --TriggerClientEvent('QBCore:Notify', source, 'You got 4 booster packs!')
            Citizen.Wait(1000)
    end
end)

QBCore.Functions.CreateCallback("Cards:server:Menu",function(source,cb)
    local player = QBCore.Functions.GetPlayer(source)
    local item = "...."
        if player ~= nil then
            if player.Functions.GetItemByName(item) then
            cb(item,item.amount)
        end
    end
end)

--[[RegisterCommand('pokemon', function(source)
    TriggerClientEvent("Cards:client:openMenu")
end)]]


QBCore.Functions.CreateUseableItem("boosterpack", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)    
        --[[TriggerClientEvent("Cards:Client:OpenPack", source, item.name)
            Citizen.Wait(4000)
        local amount = Config.CardsInPack
        TriggerClientEvent('QBCore:Notify', source, 'You got '..amount..' cards!')]]
        CardGive()
end)

RegisterServerEvent('Cards:Server:rewarditem')
AddEventHandler('Cards:Server:rewarditem', function()
    local Player = QBCore.Functions.GetPlayer(source)
    local pack = Player.Functions.GetItemByName("boosterpack")
    local amount = Config.CardsInPack
        --Player.Functions.RemoveItem('boosterpack', 1)
        --TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items["boosterpack"], "remove", 1)
    while amount > 0 do
        Wait(1)
        amount = amount -1
		local randomChance = math.random(1, 1000)
        CardGive(randomChance)
        Wait(8000)
    end
end)


function CardGive(chance)
    if chance <= 5 then 
        local card = rainbowCards[math.random(1,#rainbowCards)]
    end
    if chance >= 6 and chance <= 19 then
        local card = vmaxCards[math.random(1, #vmaxCards)]
    end
    if chance >= 20 and chance <= 50 then
        local card = vCards[math.random(1, #vCards)]
    end
    if chance >= 51 and chance <= 100 then
        local card = ultraCards[math.random(1, #ultraCards)]
    end
    if chance >= 101 and chance <= 399 then
        local card = rareCards[math.random(1, #rareCards)]
    end
    if chance >= 400 and chance <= 1000 then
        local card = basicCards[math.random(1, #basicCards)]
    end
	cardShow(card)
end

function cardShow(card)
    local Player = QBCore.Functions.GetPlayer(source)
	TriggerClientEvent('gl-cards:openPackClient',source,card..'.png')
	Player.Functions.AddItem(card, 1)
end

RegisterServerEvent("Cards:server:badges")
AddEventHandler("Cards:server:badges", function(type)
    if badge[type] ~= nil then
        local total = 0
        local Player = QBCore.Functions.GetPlayer(source)
        for i = 1, #badge[type].cards do
            local card = Player.Functions.GetItemByName(badge[type].cards[i])
            if card == nil then
                TriggerClientEvent('QBCore:Notify', source, 'You dont have '..badge[type].cards[i]..'!')
            else
                if card.amount < 1 then
                    TriggerClientEvent('QBCore:Notify', source, 'You dont have '..badge[type].cards[i]..'!')
                else
                    total = total + 1
                end
            end
        end
        Citizen.Wait(1000)
        if total == #badge[type].cards then
            for i = 1, #badge[type].cards do
                Player.Functions.RemoveItem(badge[type].cards[i], 1)
                TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[badge[type].cards[i]], "remove", 1)
            end
            Player.Functions.AddItem(badge[type].reward, 1)
            TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[badge[type].reward], "add", 1)
            TriggerClientEvent('QBCore:Notify', source, 'You got a '..badge[type].label..'!')	
        else
            TriggerClientEvent('QBCore:Notify', source, 'Come back when you have all the items!')
        end	
    end
end)

QBCore.Functions.CreateUseableItem("pokebox", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("Cards:client:UseBox", source)
    TriggerEvent("qb-log:server:CreateLog", "pokebox", "PokeBox", "white", "Player Opened The Box **"..GetPlayerName(source).."** Citizen ID : **"..Player.PlayerData.citizenid.. "**", false)
end)

QBCore.Functions.CreateUseableItem("badgebox", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("Cards:client:UseBadgeBox", source)
end)

-- USE YOUR CARD COMMANDS -- USING FOR STATS

local ShowId = function(source, item, nui)
    local found = false
    local character = QBCore.Functions.GetPlayer(source)
    local PlayerPed = GetPlayerPed(source)
    local PlayerCoords = GetEntityCoords(PlayerPed)
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local TargetPed = GetPlayerPed(v)
        local dist = #(PlayerCoords - GetEntityCoords(TargetPed))
        if dist < 2.0 and PlayerPed ~= TargetPed then
            TriggerClientEvent('QBCore:Notify', source, "You showed your card to " .. v, "info")
            TriggerClientEvent('Cards:view', v, nui)
            found = true
            break
        end
    end
    if not found then
        TriggerClientEvent('Cards:view', source, nui)
    end
end

for i, card in ipairs(basicCards) do
	local registeredItem = card
	QBCore.Functions.CreateUseableItem(registeredItem, function(source, item) 
		local card = registeredItem
        local Player = QBCore.Functions.GetPlayer(source)
        TriggerClientEvent('QBCore:Notify', source, '</br>Card Info:</br>Name: '..item.label..'</br>Value: $'..Config.CardshopItems[card]..'</br>'..item.description)
        Citizen.Wait(1000)
        TriggerClientEvent('QBCore:Notify',source, item.name,"success")
        ShowId(source, item, card)
    end)
end
for i, card in ipairs(rareCards) do
	local registeredItem = card
	QBCore.Functions.CreateUseableItem(registeredItem, function(source, item) 
		local card = registeredItem
        local Player = QBCore.Functions.GetPlayer(source)
        TriggerClientEvent('QBCore:Notify', source, '</br>Card Info:</br>'..item.label..'</br>Value: $'..Config.CardshopItems[card]..'</br>'..item.description)
        Citizen.Wait(1000)        
        ShowId(source, item, card)
	end)
end
for i, card in ipairs(ultraCards) do
	local registeredItem = card
	QBCore.Functions.CreateUseableItem(registeredItem, function(source, item) 
		local card = registeredItem
        local Player = QBCore.Functions.GetPlayer(source)
        TriggerClientEvent('QBCore:Notify', source, '</br>Card Info:</br>'..item.label..'</br>Value: $'..Config.CardshopItems[card]..'</br>'..item.description)
        Citizen.Wait(1000)
        ShowId(source, item, card)
	end)
end
for i, card in ipairs(vCards) do
	local registeredItem = card
	QBCore.Functions.CreateUseableItem(registeredItem, function(source, item) 
		local card = registeredItem
        local Player = QBCore.Functions.GetPlayer(source)
        TriggerClientEvent('QBCore:Notify', source, '</br>Card Info:</br>'..item.label..'</br>Value: $'..Config.CardshopItems[card]..'</br>'..item.description)
        Citizen.Wait(1000)
        ShowId(source, item, card)
	end)
end
for i, card in ipairs(vmaxCards) do
	local registeredItem = card
	QBCore.Functions.CreateUseableItem(registeredItem, function(source, item) 
		local card = registeredItem
        local Player = QBCore.Functions.GetPlayer(source)
        TriggerClientEvent('QBCore:Notify', source, '</br>Card Info:</br>'..item.label..'</br>Value: $'..Config.CardshopItems[card]..'</br>'..item.description)
        Citizen.Wait(1000)
        ShowId(source, item, card)
	end)
end
for i, card in ipairs(rainbowCards) do
	local registeredItem = card
	QBCore.Functions.CreateUseableItem(registeredItem, function(source, item) 
		local card = registeredItem
        local Player = QBCore.Functions.GetPlayer(source)
        Citizen.Wait(1000)
        TriggerClientEvent('QBCore:Notify', source, '</br>Card Info:</br>'..item.label..'</br>Value: $'..Config.CardshopItems[card]..'</br>'..item.description)
        Citizen.Wait(1000)
        ShowId(source, item, card)
	end)
end


function CanItemBeSaled(item)
    local retval = false
    if Config.AllowedItems[item] ~= nil then
        retval = true
    end
    return retval
end

RegisterServerEvent("Cards:sellItem")
AddEventHandler("Cards:sellItem", function(itemName, amount, price)
	local xPlayer = QBCore.Functions.GetPlayer(source)
    
    if xPlayer.Functions.RemoveItem(itemName, amount) then
        xPlayer.Functions.AddMoney('cash', price, 'Card-sell')
        TriggerClientEvent("QBCore:Notify", source, "You sold " .. amount .. " " .. itemName .. " for $" .. price, "success", 500)
    end
end)


QBCore.Functions.CreateCallback('Cards:server:get:drugs:items', function(source, cb)
    local src = source
    local AvailableDrugs = {}
    local Player = QBCore.Functions.GetPlayer(src)
    for k, v in pairs(Config.CardshopItems) do
        local DrugsData = Player.Functions.GetItemByName(k)
        if DrugsData ~= nil then
            table.insert(AvailableDrugs, {['Item'] = DrugsData.name, ['Amount'] = DrugsData.amount})
        end
    end
    cb(AvailableDrugs)
end)


function tprint (t, s)
    for k, v in pairs(t) do
        local kfmt = '["' .. tostring(k) ..'"]'
        if type(k) ~= 'string' then
            kfmt = '[' .. k .. ']'
        end
        local vfmt = '"'.. tostring(v) ..'"'
        if type(v) == 'table' then
            tprint(v, (s or '')..kfmt)
        else
            if type(v) ~= 'string' then
                vfmt = tostring(v)
            end
            print(type(t)..(s or '')..kfmt..' = '..vfmt)
        end
    end
end 
