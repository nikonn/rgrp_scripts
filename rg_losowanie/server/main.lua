ESX.RegisterUsableItem('kostka', function(source)
    TriggerClientEvent('rg_losowanie:mainEvent', -1, source, 'kostka')
end)

RegisterCommand('moneta', function(source)
    if source ~= 0 then 
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.getAccount('money').money > 0 then 
            TriggerClientEvent('rg_losowanie:mainEvent', -1, source, 'moneta')
        else 
            xPlayer.showNotification('Potrzebujesz przynajmniej $1 aby wykonać rzut monetą')
        end
    else 
        print('hej')
    end
end)