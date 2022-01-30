RegisterNetEvent('rg_zdrapki:animacja')
AddEventHandler('rg_zdrapki:animacja', function()
    local playerPed = PlayerPedId()
    local dict, anim = 'amb@code_human_wander_texting@male@base', 'base'

    ClearPedTasks(playerPed)

    ESX.Streaming.RequestAnimDict(dict, function()
		TaskPlayAnim(playerPed, dict, anim, 8.0, -8.0, -1, 49, 0.0)
	end)

    Citizen.Wait(Config.CzasZdrapywania * 1000)
    PlaySoundFrontend(-1, 'YES', 'HUD_FRONTEND_DEFAULT_SOUNDSET', false)
    ClearPedTasks(playerPed)
end)