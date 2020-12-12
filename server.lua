--[[Discord : discord.gg/VhNxmgu]]
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterNetEvent('cr_ifruitshop:Buyphone')
AddEventHandler('cr_ifruitshop:Buyphone', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = 300 --Prix
    local xMoney = xPlayer.getMoney()

    if xMoney >= price then

        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem('tel', 1)
        TriggerClientEvent('esx:showNotification', source, "~g~Achats~w~ effectué !")
    else
         TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez ~r~d\'argent")
    end
end)

RegisterNetEvent('cr_ifruitshop:Buysim')
AddEventHandler('cr_ifruitshop:Buysim', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = 50 --Prix
    local xMoney = xPlayer.getMoney()

    if xMoney >= price then

        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem('sim', 1)
        TriggerClientEvent('esx:showNotification', source, "~g~Achats~w~ effectué !")
    else
         TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez ~r~d\'argent")
    end
end)

--[[Discord : discord.gg/VhNxmgu]]