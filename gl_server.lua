QBCore = nil

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

--[[RegisterNetEvent('gl-cards:showPlayer')
AddEventHandler('gl-cards:showPlayer',function(ID, targetID, card)
	local _source = QBCore.Functions.GetPlayer(source)
	TriggerClientEvent('gl-cards:drawNui', _source, card)
end)]]
