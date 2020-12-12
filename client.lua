--[[Discord : discord.gg/VhNxmgu]]
ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(100)
    end
end)

local position = {
    {x = -657.01, y = -857.31, z = 24.49},
}

CRIfruit              = {}
CRIfruit.DrawDistance = 100
CRIfruit.Size         = {x = 1.0, y = 1.0, z = 1.0}
CRIfruit.Color        = {r = 255, g = 0, b = 0}
CRIfruit.Type         = 21

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local coords, letSleep = GetEntityCoords(PlayerPedId()), true

        for k in pairs(position) do
            if (CRIfruit.Type ~= -1 and GetDistanceBetweenCoords(coords, position[k].x, position[k].y, position[k].z, true) < CRIfruit.DrawDistance) then
                DrawMarker(CRIfruit.Type, position[k].x, position[k].y, position[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, CRIfruit.Size.x, CRIfruit.Size.y, CRIfruit.Size.z, CRIfruit.Color.r, CRIfruit.Color.g, CRIfruit.Color.b, 100, false, true, 2, false, false, false, false)
                letSleep = false
            end
        end

        if letSleep then
            Citizen.Wait(500)
        end
    end
end)


RMenu.Add('cr_ifruitshop', 'main', RageUI.CreateMenu("Boutique de Téléphone!", "~b~Téléphone et Carte SIM"))
RMenu.Add('cr_ifruitshop', 'tel', RageUI.CreateSubMenu(RMenu:Get('cr_ifruitshop', 'main'), "Achat Téléphone", "~b~Téléphone"))
RMenu.Add('cr_ifruitshop', 'sim', RageUI.CreateSubMenu(RMenu:Get('cr_ifruitshop', 'main'), "Achat SIM", "~b~Carte SIM"))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('cr_ifruitshop', 'main'), true, true, true, function()

            RageUI.Button("📞 Achat Téléphone", nil, {RightLabel = "→→"},true, function ()
            end, RMenu:Get('cr_ifruitshop', 'tel'))

            RageUI.Button("💳  Achat SIM", nil, {RightLabel = "→→"},true, function ()
            end, RMenu:Get('cr_ifruitshop', 'sim'))

            RageUI.Button("⏳~r~Fermer le menu", nil, {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    RageUI.CloseAll()
                end
            end)
        end, function()
        end)

        RageUI.IsVisible(RMenu:Get('cr_ifruitshop', 'tel'), true, true, true, function()
        
            RageUI.Button("📞 ~r~Téléphone", nil, {RightLabel = "~g~300 €"}, true, function(Hovered, Active, Selected) --Prix a modif ici et dans le server.lua
                if (Selected) then
                    TriggerServerEvent('cr_ifruitshop:Buyphone')
                end
            end)
        end, function()
        end)

        RageUI.IsVisible(RMenu:Get('cr_ifruitshop', 'sim'), true, true, true, function()
        
            RageUI.Button("💳  ~r~Carte SIM", nil, {RightLabel = "~g~50 €"}, true, function(Hovered, Active, Selected) --Prix a modif ici et dans le server.lua
                if (Selected) then
                    TriggerServerEvent('cr_ifruitshop:Buysim')
                end
            end)
        end, function()
        end)

        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
    
            for k in pairs(position) do
    
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
    
                if dist <= 1.0 then
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour parler au vendeur")
                    if IsControlJustPressed(1,51) then
                        RageUI.Visible(RMenu:Get('cr_ifruitshop', 'main'), not RageUI.Visible(RMenu:Get('cr_ifruitshop', 'main')))
                    end   
                end
            end
        end
    end)

    Citizen.CreateThread(function()
        local hash = GetHashKey("a_f_y_beach_01") --"a_f_y_beach_01" ped a modif: https://docs.fivem.net/docs/game-references/ped-models/
        while not HasModelLoaded(hash) do
        RequestModel(hash)
        Wait(20)
        end
        ped = CreatePed("PED_TYPE_CIVFEMALE", "a_f_y_beach_01", -657.16, -858.92, 23.49, true, true) --"a_f_y_beach_01" ped a modif: https://docs.fivem.net/docs/game-references/ped-models/
        SetBlockingOfNonTemporaryEvents(ped, true)
        FreezeEntityPosition(ped, true)
    end)
    
    local v1 = vector3(-657.16, -858.92, 25.49)
    
    function Draw3DText(x, y, z, text)
        local onScreen, _x, _y = World3dToScreen2d(x, y, z)
        local p = GetGameplayCamCoords()
        local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
        local scale = (1 / distance) * 2
        local fov = (1 / GetGameplayCamFov()) * 100
        local scale = scale * fov
        if onScreen then
            SetTextScale(0.0, 0.35)
            SetTextFont(0)
            SetTextProportional(1)
            SetTextColour(255, 255, 255, 255)
            SetTextDropshadow(0, 0, 0, 0, 255)
            SetTextEdge(2, 0, 0, 0, 150)
            SetTextDropShadow()
            SetTextOutline()
            SetTextEntry("STRING")
            SetTextCentre(1)
            AddTextComponentString(text)
            DrawText(_x,_y)
        end
    end
    
    local distance = 20
    
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            if Vdist2(GetEntityCoords(PlayerPedId(), false), v1) < distance then
                Draw3DText(v1.x,v1.y,v1.z, "Coucou bg!") --Text du ped
            end
        end
    end)

    local blips = {
         {title="~b~Boutique ~w~Téléphone", colour=2, id=459, x = -657.16, y = -858.92, z = 23.49}, --Blips doc: https://wiki.gtanet.work/index.php?title=Blips
      }
    
    Citizen.CreateThread(function()
    
        for _, info in pairs(blips) do
          info.blip = AddBlipForCoord(info.x, info.y, info.z)
          SetBlipSprite(info.blip, info.id)
          SetBlipDisplay(info.blip, 4)
          SetBlipScale(info.blip, 0.9)
          SetBlipColour(info.blip, info.colour)
          SetBlipAsShortRange(info.blip, true)
          BeginTextCommandSetBlipName("STRING")
          AddTextComponentString(info.title)
          EndTextCommandSetBlipName(info.blip)
        end
    end)
    
--[[Discord : discord.gg/VhNxmgu]]