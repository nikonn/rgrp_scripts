RegisterNetEvent('rg_losowanie:mainEvent')
AddEventHandler('rg_losowanie:mainEvent', function(id, type)
    local myId = PlayerId()
    local playerId = GetPlayerFromServerId(id)

    local monetaRandom, kostkaRandom = math.random(1, 2), math.random(1, 6)

    local monetaText 

    if monetaRandom == 1 then 
        monetaText = 'Heads'
    elseif monetaRandom == 2 then 
        monetaText = 'Tails'
    end

    if playerId == myId then
        if type == 'moneta' then 
            TriggerEvent('chat:addMessage', {
                template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(138, 132, 25, 0.5); "><i class="fas fa-coins"></i> [{0}] Wyrzuca: {1}</div>',
                args = { id, monetaText }
            })
        elseif type == 'kostka' then
            TriggerEvent('chat:addMessage', {
                template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(25, 117, 138, 0.5); "><i class="fas fa-dice"></i> [{0}] Wyrzuca {1} oczek</div>',
                args = { id, kostkaRandom }
            })
        end
    elseif #(GetEntityCoords(GetPlayerPed(myId)) - GetEntityCoords(GetPlayerPed(playerId))) < 19.9 then
        if type == 'moneta' then 
            TriggerEvent('chat:addMessage', {
                template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(138, 132, 25, 0.5); "><i class="fas fa-coins"></i> [{0}] Wyrzuca: {1}</div>',
                args = { id, monetaText }
            })
        elseif type == 'kostka' then
            TriggerEvent('chat:addMessage', {
                template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(25, 117, 138, 0.5); "><i class="fas fa-dice"></i> [{0}] Wyrzuca {1} oczek</div>',
                args = { id, kostkaRandom }
            })
        end
    end 
end)