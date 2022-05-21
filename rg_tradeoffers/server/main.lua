RegisterCommand('trade', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetId, sourceId, itemName, tradeMoney = tonumber(args[1]), source, args[2], tonumber(args[3])
    local siemanko = xPlayer.getInventoryItem(itemName)
    local hehe, hehe2, hehe3 = GetPlayerName(source), GetPlayerIdentifier(source), source
    local xd1, xd2 = GetEntityCoords(GetPlayerPed(source)), GetEntityCoords(GetPlayerPed(targetId))
    local dystans = #(xd1 - xd2)
    if source ~= 0 then 
        if xPlayer.job.name == Config.NazwaJoba then 
            if targetId ~= nil then
                if siemanko ~= nil and siemanko.count > 0 then
                    if tradeMoney ~= nil and tradeMoney > 2 then 
                        if dystans < Config.TradeDystans then 
                            TriggerClientEvent('rg_tradeoffer:sendTradeOffer', targetId, sourceId, itemName, tradeMoney)
                            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Wysłano ofertę wymiany dla ID: ' .. targetId)
                        else 
                            if Config.Ostrzezenie then 
                                print(hehe .. ' | ' .. hehe2 .. ' | ID: ' .. hehe3 .. ' - proba wymiany na dystans wiekszy niz ' .. Config.TradeDystans) 
                            end
                        end
                    else 
                        xPlayer.showNotification('Minimalna kwota wymiany to $2')
                    end 
                else 
                    xPlayer.showNotification('Nie posiadasz podanego przedmiotu')
                end
            else 
                xPlayer.showNotification('Nie podano ID docelowego!')
            end
            if targetId ~= nil and GetPlayerPing(targetId) < 1 then 
                xPlayer.showNotification('Nie ma takiego ID na serwerze!')
            end 
        else 
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Ta opcja jest dostępna tylko dla biznesów.')
        end
    else 
        print('nie wolno z konsoli, pozdrawiam')
    end
end)

RegisterServerEvent('rg_tradeoffer:akcept')
AddEventHandler('rg_tradeoffer:akcept', function(target, account, itemName, tradeMoney)
    local sourceXPlayer = ESX.GetPlayerFromId(source)
    local targetXPlayer = ESX.GetPlayerFromId(target)

    if sourceXPlayer.getAccount(account).money > tradeMoney - 1 then 
        sourceXPlayer.removeAccountMoney(account, tradeMoney)
        targetXPlayer.addAccountMoney(account, tradeMoney)

        targetXPlayer.removeInventoryItem(itemName, 1)
        sourceXPlayer.addInventoryItem(itemName, 1)

        sourceXPlayer.triggerEvent('rg_tradeoffer:tradeAnim')
        targetXPlayer.triggerEvent('rg_tradeoffer:tradeAnim')

        TriggerClientEvent('esx:showNotification', target, 'ID ' .. source .. ' zaakceptował/a twoją ofertę')
        TriggerClientEvent('esx:showNotification', source, 'Zaakceptowano ofertę wymiany')
    else 
        TriggerClientEvent('esx:showNotification', target, 'ID ' .. source .. ' nie jest w stanie opłacić oferty')
        TriggerClientEvent('esx:showNotification', source, 'Nie jesteś w stanie opłacić oferty')
    end 
end)

RegisterServerEvent('rg_tradeoffer:odrzuc')
AddEventHandler('rg_tradeoffer:odrzuc', function(target)
    TriggerClientEvent('esx:showNotification', source, 'Odrzucono ofertę wymiany')
    TriggerClientEvent('esx:showNotification', target, 'ID ' .. source .. ' odrzucił/a twoją ofertę')
end)
