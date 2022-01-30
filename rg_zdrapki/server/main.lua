ESX.RegisterUsableItem('zdrapka1', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('zdrapka1', 1)
    TriggerEvent('rg_zdrapki:zdrapZdrapke', xPlayer, 'liberty')
end)

ESX.RegisterUsableItem('zdrapka2', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('zdrapka2', 1)
    TriggerEvent('rg_zdrapki:zdrapZdrapke', xPlayer, 'rich')
end)

RegisterServerEvent('rg_zdrapki:zdrapZdrapke')
AddEventHandler('rg_zdrapki:zdrapZdrapke', function(xPlayer, zdrapka)
    zdrapujeZdrapke = true 

    if zdrapka == 'liberty' or zdrapka == 'rich' then   
        if zdrapka == 'liberty' then 
            hehe = Config.MaxKwoty.Liberty 
        elseif zdrapka == 'rich' then 
            hehe = Config.MaxKwoty.Rich 
        end
        xPlayer.showNotification('Zdrapujesz zdrapkę..')
        TriggerClientEvent('rg_zdrapki:animacja', xPlayer.source)
        math.randomseed(os.time())
        Citizen.Wait(Config.CzasZdrapywania * 1000)
        local kasa = math.random(1, hehe)
        xPlayer.showNotification('Wygrano $' .. kasa .. ' w zdrapce')
        xPlayer.addAccountMoney('money', kasa)
        Citizen.Wait(Config.ZdrapkaCooldown * 1000)
        zdrapujeZdrapke = false
    end
end)