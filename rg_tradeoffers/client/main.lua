RegisterNetEvent('rg_tradeoffer:sendTradeOffer')
AddEventHandler('rg_tradeoffer:sendTradeOffer', function(sourceId, itemName, tradeMoney)
    openTradeOfferMenu(sourceId, itemName, tradeMoney) 
end)

openTradeOfferMenu = function(sourceId, itemName, tradeMoney)
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'trademenu', {
        title = 'ID ' .. sourceId .. ' chce Ci przekazać ' .. itemName .. ' za $' .. tradeMoney .. '. Przyjmujesz ofertę?',
        align = 'center',
        elements = {
            {label = 'Zapłać gotówką', value = 'gotowka'},
            {label = 'Zapłać kartą', value = 'karta'},
            {label = 'Odrzuć ofertę', value = 'odrzuc'}
        }
    }, function(data, menu)
        if data.current.value == 'gotowka' then 
            TriggerServerEvent('rg_tradeoffer:akcept', sourceId, 'money', itemName, tradeMoney)
            menu.close()
        elseif data.current.value == 'karta' then 
            TriggerServerEvent('rg_tradeoffer:akcept', sourceId, 'bank', itemName, tradeMoney)
            menu.close()
        elseif data.current.value == 'odrzuc' then 
            TriggerServerEvent('rg_tradeoffer:odrzuc', sourceId)
            menu.close()
        end 
    end, function(data, menu)
        TriggerServerEvent('rg_tradeoffer:odrzuc', sourceId)
        menu.close()
    end)
end

RegisterNetEvent('rg_tradeoffer:tradeAnim')
AddEventHandler('rg_tradeoffer:tradeAnim', function()
    local playerPed = PlayerPedId()
    local dict, anim = 'mp_common', 'givetake1_a'

	ESX.Streaming.RequestAnimDict(dict, function()
		TaskPlayAnim(playerPed, dict, anim, 8.0, 8.0, 2000, 50, 0, false, false, false)
	end)
end)

TriggerEvent('chat:addSuggestion', '/trade', 'System wymiany dla biznesów', {
    { name = 'ID', help = 'ID docelowego gracza' },
    { name = 'item', help = 'Nazwa itemu z dokumentacji' },
    { name = 'cena', help = 'Kwota wymiany powyżej $2' }
})