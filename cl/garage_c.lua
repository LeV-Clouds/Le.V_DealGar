
ESX = nil 

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent("esx:getSharedObject",function(obj)
                ESX = obj
        end)
       Wait(10)
    end
end)

local title = "Garage"
local submenu = 'garage_main'
local submenu2 = 'pound_main'

local Action = {Veh = {"Sortir", "Partager"}, index = 1}
local Zone = {
    {Garage = "Garage Centre", BlipName = "Garage Public",  Enter = vector3(230.49, -798.38, 30.57+1.0), EnterNot = "Appuyez sur ~INPUT_PICKUP~ pour gérer vos véhicule", Exit = vector3(214.52, -792.14, 30.84+1.0), ExitNot = "Appuyez sur ~INPUT_PICKUP~ pour rentrer le véhicule", Preview = vector3(227.57, -804.41, 30.06)},
    {Garage = "Garage Alta Street", BlipName = "Garage Public", Enter = vector3(274.47, -330.35, 44.92+1.0), EnterNot = "Appuyez sur ~INPUT_PICKUP~ pour gérer vos véhicule", Exit = vector3(290.96, -336.49, 44.92+1.0), ExitNot = "Appuyez sur ~INPUT_PICKUP~ pour rentrer le véhicule", Preview = vector3(287.66, -344.51, 44.92)},
    {Garage = "Garage Vespucci", BlipName = "Garage Public", Enter = vector3(-2030.52, -465.34, 11.6+1.0), EnterNot = "Appuyez sur ~INPUT_PICKUP~ pour gérer vos véhicule", Exit = vector3(-2037.44, -469.12, 11.44+1.0), ExitNot = "Appuyez sur ~INPUT_PICKUP~ pour rentrer le véhicule", Preview = vector3(-2029.24, -475.44, 11.44)},
    {Garage = "Garage RockFord Plaza", BlipName = "Garage Public", Enter = vector3(-350.35, -77.88, 45.66+1.0), EnterNot = "Appuyez sur ~INPUT_PICKUP~ pour gérer vos véhicule", Exit = vector3(-360.27, -76.13, 45.66+1.0), ExitNot = "Appuyez sur ~INPUT_PICKUP~ pour rentrer le véhicule", Preview = vector3(-356.47, -89.99, 45.64)},
    {Garage = "Garage Vinewood East", BlipName = "Garage Public", Enter = vector3(1089.01, 247.59, 80.99+1.0), EnterNot = "Appuyez sur ~INPUT_PICKUP~ pour gérer vos véhicule", Exit = vector3(1115.71, 243.56, 80.86+1.0), ExitNot = "Appuyez sur ~INPUT_PICKUP~ pour rentrer le véhicule", Preview = vector3(1102.14, 265.29, 80.86)},
    {Garage = "Garage Sandy Shores", BlipName = "Garage Public", Enter = vector3(1527.77, 3770.71, 34.51+1.0), EnterNot = "Appuyez sur ~INPUT_PICKUP~ pour gérer vos véhicule", Exit = vector3(1503.93, 3762.52, 33.99+1.0), ExitNot = "Appuyez sur ~INPUT_PICKUP~ pour rentrer le véhicule", Preview = vector3(1500.57, 3750.89, 33.95)},
    {Garage = "Garage Paleto Bay", BlipName = "Garage Public", Enter = vector3(119.99, 6626.09, 31.96+1.0), EnterNot = "Appuyez sur ~INPUT_PICKUP~ pour gérer vos véhicule", Exit = vector3(137.31, 6625.12, 31.72+1.0), ExitNot = "Appuyez sur ~INPUT_PICKUP~ pour rentrer le véhicule", Preview = vector3(132.46, 6611.52, 31.84)},
    {Garage = "Garage Coast East", BlipName = "Garage Public", Enter = vector3(2588.82, 429.53, 108.61+1.0), EnterNot = "Appuyez sur ~INPUT_PICKUP~ pour gérer vos véhicule", Exit = vector3(2587.93, 418.64, 108.46+1.0), ExitNot = "Appuyez sur ~INPUT_PICKUP~ pour rentrer le véhicule", Preview = vector3(2577.46, 418.83, 108.46)},
    {Garage = "Garage Chumash Plaza", BlipName = "Garage Public", Enter = vector3(-3156.46, 1094.8, 20.86+1.0), EnterNot = "Appuyez sur ~INPUT_PICKUP~ pour gérer vos véhicule", Exit = vector3(-3146.66, 1070.34, 20.63+1.0), ExitNot = "Appuyez sur ~INPUT_PICKUP~ pour rentrer le véhicule", Preview = vector3(-3147.79, 1086.47, 20.69)},
}

local ZoneFour = {
    {Garage = "Fourrière L.S", Enter = vector3(383.22, -1623.68, 29.29+1.0), EnterNot = "Appuyez sur ~INPUT_PICKUP~ pour accèdez à la fourrière", Preview = vector3(378.63, -1628.92, 28.41)},
    {Garage = "Fourrière B.C", Enter = vector3(1759.8, 3327.3, 41.39+1.0), EnterNot = "Appuyez sur ~INPUT_PICKUP~ pour accèdez à la fourrière", Preview = vector3(1766.76, 3307.91, 41.17)},
}

Citizen.CreateThread(function()

    RMenu.Add("core", submenu, RageUI.CreateMenu(title, "Gestion des véhicule"))
    RMenu:Get("core", submenu):SetRectangleBanner(39, 41, 39, 100)
    RMenu.Add('core', 'garage_main_perso', RageUI.CreateSubMenu(RMenu:Get("core", submenu), title, "Gestion des véhicule"))
    RMenu.Add('core', 'garage_main_voler', RageUI.CreateSubMenu(RMenu:Get("core", submenu), title, "Gestion des véhicule"))
    RMenu.Add('core', 'garage_main_partager', RageUI.CreateSubMenu(RMenu:Get("core", submenu), title, "Gestion des véhicule"))
    
    RMenu.Add("core", submenu2, RageUI.CreateMenu(title, "Liste"))
    RMenu:Get("core", submenu2):SetRectangleBanner(39, 41, 39, 100)

    while true do 
        RageUI.IsVisible(RMenu:Get("core", submenu), true, true, true, function()
            RageUI.Button("Mes véhicules", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    RMenu:Get('core', 'garage_main_perso'):SetTitle(GarageDed)
                end
            end, RMenu:Get('core', 'garage_main_perso'))
            RageUI.Button("Mes véhicules volés", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    RMenu:Get('core', 'garage_main_voler'):SetTitle(GarageDed)
                end
            end, RMenu:Get('core', 'garage_main_voler'))
            RageUI.Button("Mes véhicules partagé(s)", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    RMenu:Get('core', 'garage_main_partager'):SetTitle(GarageDed)
                end
            end, RMenu:Get('core', 'garage_main_partager'))
        end)
        RageUI.IsVisible(RMenu:Get("core", "garage_main_perso"), true, true, true, function()
            if ListeCall then
                if not table.empty(ListeCall) then 
                    for k,v in pairs(ListeCall) do
                        if v.rob == 1 then
                            v.status = "~o~Non propriétaire~s~"
                        else
                            v.status = "~g~Propriétaire~s~"
                        end
                        if v.etat == 1 then
                            v.ing = "~g~Ranger~s~"
                        else 
                            v.ing = "~r~Sortie~s~"
                        end
                        if v.etat == 4 then
                            v.ing = "~r~Dans le hangar concessionnaire~s~"
                        end
                        if v.rob == 0 then            
                            if v.etat == 0 then 
                                RageUI.Button("~c~" .. NomByModel(v.propriete.model),  "- Plaque numérisée : ~y~" .. v.plaque .. "~s~\n- Propriété : " .. v.status .. "~s~\n- État : " .. v.ing, {RightBadge = RageUI.BadgeStyle.Lock}, true, function(Hovered, Active, Selected)
                                end)
                            else 
                                RageUI.List(NomByModel(v.propriete.model), Action.Veh, Action.index,  "- Plaque numérisée : ~y~" .. v.plaque .. "~s~\n- Propriété : " .. v.status .. "~s~\n- État : " .. v.ing, {}, true, function(Hovered, Active, Selected, Index)
                                    if Selected then  
                                       if Index == 1 then
                                        if not ESX.Game.IsSpawnPointClear(PreviewZone, 5.0) then
                                            RageUI.Popup({message= "- ~r~Erreur~s~\n- Emplacement occupé ..."})
                                        else
                                            if v.etat == 4 then
                                                RageUI.Popup({message= "- ~r~Erreur~s~\n- Véhicule outre que dans le ..."})
                                            else 
                                                ESX.Game.SpawnVehicle(GetDisplayNameFromVehicleModel(v.propriete.model), PreviewZone, 160.05, function(Voiture)
                                                    ESX.Game.SetVehicleProperties(Voiture, v.propriete)
                                                end)
                                                TriggerServerEvent("core:GarageEntUp", v.plaque, false)
                                                Wait(1000)
                                                RefreshListeVehByGarage(GarageDed)
                                                RageUI.Popup({message= "- ~y~" .. GarageDed .. "~s~\n- ~b~" .. NomByModel(v.propriete.model) .. "~s~ sortie."})
                                            end
                                        end
                                       elseif Index == 2 then
                                            local player, distance = ESX.Game.GetClosestPlayer()
                                            if distance~=-1 and distance<= 3.0 then
                                                TriggerServerEvent("core:GarageGiveVeh", v.plaque, GetPlayerServerId(player), NomByModel(v.propriete.model), GarageDed)
                                            else 
                                                RageUI.Popup({message= "- ~r~Erreur~s~\n- Aucun individus à proximiter."})
                                            end
                                       end
                                    end
                                    Action.index = Index
                                end)
                            end
                        end 
                    end  
                else 
                    RageUI.CenterButton("~r~Aucun véhicule stocker dans le garage", nil, {}, true, function(Hovered, Active, Selected)
                    end)
                end
            end 
        end)
        RageUI.IsVisible(RMenu:Get("core", "garage_main_voler"), true, true, true, function()
            if ListeCall then
                if not table.empty(ListeCall) then 
                    for k,v in pairs(ListeCall) do
                        if v.rob == 1 then
                            v.status = "~o~Non propriétaire~s~"
                        else
                            v.status = "~g~Propriétaire~s~"
                        end
                        if v.etat == 1 then
                            v.ing = "~g~Ranger~s~"
                        else 
                            v.ing = "~r~Sortie~s~"
                        end
                        if v.etat == 4 then
                            v.ing = "~r~Dans le hangar concessionnaire~s~"
                        end
                        if v.rob == 1 then 
                            if v.etat == 0 then 
                                RageUI.Button("~c~" .. NomByModel(v.propriete.model) .. " ~r~Volé~c~",  "- Plaque numérisée : ~y~" .. v.plaque .. "~s~\n- Propriété : " .. v.status .. "~s~\n- État : " .. v.ing, {RightBadge = RageUI.BadgeStyle.Lock}, true, function(Hovered, Active, Selected)
                                end)
                            else 
                                RageUI.List(NomByModel(v.propriete.model) .. " ~r~Volé", Action.Veh, Action.index, "- Plaque numérisée : ~y~" .. v.plaque .. "~s~\n- Propriété : " .. v.status .. "~s~\n- État : " .. v.ing, {}, true, function(Hovered, Active, Selected, Index)
                                    if Selected then  
                                       if Index == 1 then
                                        if not ESX.Game.IsSpawnPointClear(PreviewZone, 5.0) then
                                            RageUI.Popup({message= "- ~r~Erreur~s~\n- Emplacement occupé ..."})
                                        else
                                            ESX.Game.SpawnVehicle(GetDisplayNameFromVehicleModel(v.propriete.model), PreviewZone, 160.05, function(Voiture)
                                                ESX.Game.SetVehicleProperties(Voiture, v.propriete)
                                            end)
                                            RageUI.Popup({message= "- ~y~" .. GarageDed .. "~s~\n- ~b~" .. NomByModel(v.propriete.model) .. "~s~ sortie."})
                                            TriggerServerEvent("core:DeleteVehTo", v.plaque)
                                            table.remove(ListeCall, k)
                                        end 
                                       elseif Index == 2 then
                                        local player, distance = ESX.Game.GetClosestPlayer()
                                        if distance~=-1 and distance<= 3.0 then
                                            TriggerServerEvent("core:GarageGiveVeh", v.plaque, GetPlayerServerId(player), NomByModel(v.propriete.model), GarageDed)
                                        else 
                                            RageUI.Popup({message= "- ~r~Erreur~s~\n- Aucun individus à proximiter."})
                                        end
                                       end
                                    end
                                    Action.index = Index
                                end)
                            end
                        end
                    end
                else 
                    RageUI.CenterButton("~r~Aucun véhicule stocker dans le garage", nil, {}, true, function(Hovered, Active, Selected)
                    end)
                end
            end   
        end)
        RageUI.IsVisible(RMenu:Get("core", "garage_main_partager"), true, true, true, function()
            if ListeCallPartage then
                if not table.empty(ListeCallPartage) then
                    for k,v in pairs(ListeCallPartage) do
                        if v.rob == 1 then
                            v.status = "~o~Non propriétaire~s~"
                        else
                            v.status = "~g~Propriétaire~s~"
                        end
                        if v.etat == 1 then
                            v.ing = "~g~Ranger~s~"
                        else 
                            v.ing = "~r~Sortie~s~"
                        end
                        if v.etat == 4 then
                            v.ing = "~r~Dans le hangar concessionnaire~s~"
                        end
                        if v.rob == 1 then 
                            if v.etat == 0 then 
                                RageUI.Button("~c~" .. NomByModel(v.propriete.model) .. " ~y~Partager~c~ | ~r~Volé~c~",  "- Plaque numérisée : ~y~" .. v.plaque .. "~s~\n- Propriété : " .. v.status .. "~s~\n- État : " .. v.ing, {RightBadge = RageUI.BadgeStyle.Lock}, true, function(Hovered, Active, Selected)
                                end)
                            else 
                                RageUI.Button(NomByModel(v.propriete.model) .. " ~y~Partager~s~ | ~r~Volé~c~",  "- Plaque numérisée : ~y~" .. v.plaque .. "~s~\n- Propriété : " .. v.status .. "~s~\n- État : " .. v.ing, {}, true, function(Hovered, Active, Selected)
                                    if Selected then
                                        if not ESX.Game.IsSpawnPointClear(PreviewZone, 5.0) then
                                            RageUI.Popup({message= "- ~r~Erreur~s~\n- Emplacement occupé ..."})
                                        else
                                            ESX.Game.SpawnVehicle(GetDisplayNameFromVehicleModel(v.propriete.model), PreviewZone, 160.05, function(Voiture)
                                                ESX.Game.SetVehicleProperties(Voiture, v.propriete)
                                            end)
                                            RageUI.Popup({message= "- ~y~" .. GarageDed .. "~s~\n- ~b~" .. NomByModel(v.propriete.model) .. "~s~ sortie."})
                                            TriggerServerEvent("core:DeleteVehTo", v.plaque)
                                            table.remove(ListeCall, k)
                                        end 
                                    end
                                end)
                            end
                        else 
                            if v.etat == 0 then 
                                RageUI.Button("~c~" .. NomByModel(v.propriete.model) .. " ~y~Partager~c~",  "- Plaque numérisée : ~y~" .. v.plaque .. "~s~\n- Propriété : " .. v.status .. "~s~\n- État : " .. v.ing, {RightBadge = RageUI.BadgeStyle.Lock}, true, function(Hovered, Active, Selected)
                                end)
                            else
                                RageUI.Button(NomByModel(v.propriete.model) .. " ~y~Partager~c~", nil, {}, true, function(Hovered, Active, Selected)
                                    if Selected then
                                        if not ESX.Game.IsSpawnPointClear(PreviewZone, 5.0) then
                                            RageUI.Popup({message= "- ~r~Erreur~s~\n- Emplacement occupé ..."})
                                        else
                                            if v.etat == 4 then
                                                RageUI.Popup({message= "- ~r~Erreur~s~\n- Véhicule outre que dans le ..."})
                                            else 
                                                ESX.Game.SpawnVehicle(GetDisplayNameFromVehicleModel(v.propriete.model), PreviewZone, 160.05, function(Voiture)
                                                    ESX.Game.SetVehicleProperties(Voiture, v.propriete)
                                                end)
                                                TriggerServerEvent("core:GarageEntUp", v.plaque, false)
                                                Wait(1000)
                                                RefreshListeVehByGarage(GarageDed)
                                                RageUI.Popup({message= "- ~y~" .. GarageDed .. "~s~\n- ~b~" .. NomByModel(v.propriete.model) .. "~s~ sortie."})
                                            end
                                        end
                                    end
                                end)
                            end
                        end
                    end
                else 
                    RageUI.CenterButton("~r~Aucun véhicule partager dans le garage", nil, {}, true, function(Hovered, Active, Selected)
                    end)
                end
            end
        end)
        RageUI.IsVisible(RMenu:Get("core", submenu2), true, true, true, function()
            if ListeCall then
                if not table.empty(ListeCall) then 
                    for k,v in pairs(ListeCall) do
                        if v.rob == 1 then
                            v.status = "~o~Non propriétaire~s~"
                        else
                            v.status = "~g~Propriétaire~s~"
                        end
                        if v.etat == 2 then
                            v.ing = "~o~Fourrière~s~"
                        end
                        if v.etat == 2 then 
                            RageUI.Button(NomByModel(v.propriete.model),  "- Plaque numérisée : ~y~" .. v.plaque .. "~s~\n- Propriété : " .. v.status .. "~s~\n- État : " .. v.ing, {}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    if not ESX.Game.IsSpawnPointClear(PreviewZone, 5.0) then
                                        RageUI.Popup({message= "- ~r~Erreur~s~\n- Emplacement occupé ..."})
                                    else
                                        ESX.Game.SpawnVehicle(GetDisplayNameFromVehicleModel(v.propriete.model), PreviewZone, 318.85, function(Voiture)
                                            ESX.Game.SetVehicleProperties(Voiture, v.propriete)
                                        end)
                                        RageUI.Popup({message= "- ~y~" .. GarageDed .. "~s~\n- ~b~" .. NomByModel(v.propriete.model) .. "~s~ sortie."})
                                        TriggerServerEvent("core:GarageEntUp", v.plaque, false)
                                        table.remove(ListeCall, k)
                                    end
                                end
                            end)
                        end 
                    end 
                else
                    RageUI.CenterButton("~r~Aucun véhicule dans la fourrière L.S", nil, {}, true, function(Hovered, Active, Selected)
                    end)
                end
            end
        end)
        Wait(0)
    end 
end)

Citizen.CreateThread(function()
    while true do
        local Open = false
        for t,f in pairs(Zone) do
            if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                if Vdist2(GetEntityCoords(GetPlayerPed(-1)), f.Exit) < 70 and not RageUI.Visible(RageUI.CurrentMenu) then
                    Open = true
                    DrawMarker(24, f.Exit, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.0, 0.2, 150, 50, 50, 200, 0, 0, 2, 1, nil, nil, 0)
                    if Vdist2(GetEntityCoords(GetPlayerPed(-1)), f.Exit) < 20 then 
                        NotificationHelp(f.ExitNot)
                        if IsControlJustPressed(1, 51) then
                            StoreVeh(f.Garage)
                        end
                    end
                end
            else
                if Vdist2(GetEntityCoords(GetPlayerPed(-1)), f.Enter) < 70 and not RageUI.Visible(RageUI.CurrentMenu) then
                    Open = true
                    DrawMarker(24, f.Enter, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.0, 0.2, 50, 150, 50, 200, 0, 0, 2, 1, nil, nil, 0)
                    if Vdist2(GetEntityCoords(GetPlayerPed(-1)), f.Enter) < 3 then  
                        NotificationHelp(f.EnterNot)
                        if IsControlJustPressed(1, 51) then
                            local source = source
                            RefreshListeVehByGarage(f.Garage)
                            RefreshListeVehPartagerByGarage(f.Garage)
                            RageUI.Visible(RMenu:Get("core", submenu), true)
                            RMenu:Get('core', submenu):SetTitle(f.Garage)
                            PreviewZone = f.Preview
                            GarageDed = f.Garage
                        end
                    end
                end
            end
        end
        for t,f in pairs(ZoneFour) do
            if not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                if Vdist2(GetEntityCoords(GetPlayerPed(-1)), f.Enter) < 70 and not RageUI.Visible(RageUI.CurrentMenu) then
                    Open = true
                    DrawMarker(24, f.Enter, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.0, 0.2,  223, 122, 14, 200, 0, 0, 2, 1, nil, nil, 0)
                    if Vdist2(GetEntityCoords(GetPlayerPed(-1)), f.Enter) < 3 then  
                        NotificationHelp(f.EnterNot)
                        if IsControlJustPressed(1, 51) then
                            local source = source
                            RefreshListeVehByGarage(f.Garage)
                            RefreshListeVehPartagerByGarage(f.Garage)
                            RageUI.Visible(RMenu:Get("core", submenu2), true)
                            RMenu:Get('core', submenu2):SetTitle(f.Garage)
                            PreviewZone = f.Preview
                            GarageDed = f.Garage
                        end
                    end
                end
            end
        end
        if Open then
            Wait(0)
        else
            Wait(500)
        end
    end
end)

Citizen.CreateThread(function()

    for _, f in pairs(Zone) do
      f.blip = AddBlipForCoord(f.Enter)
      SetBlipSprite(f.blip, 50)
      SetBlipDisplay(f.blip, 4)
      SetBlipScale(f.blip, 0.5)
      SetBlipColour(f.blip, 77)
      SetBlipAsShortRange(f.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(f.BlipName)
      EndTextCommandSetBlipName(f.blip)
    end

    for _, f in pairs(ZoneFour) do
        f.blip = AddBlipForCoord(f.Enter)
        SetBlipSprite(f.blip, 50)
        SetBlipDisplay(f.blip, 4)
        SetBlipScale(f.blip, 0.5)
        SetBlipColour(f.blip, 64)
        SetBlipAsShortRange(f.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(f.Garage)
        EndTextCommandSetBlipName(f.blip)
      end

end) 

StoreVeh = function(Garage)
    local Joueur = GetPlayerPed(-1)
    local Vehicule = GetVehiclePedIsIn(Joueur,false)
    local Propriete  = ESX.Game.GetVehicleProperties(Vehicule)
    Health = GetVehicleEngineHealth(Vehicule)/10
	local HealthEngine = math.floor(Health)
    local Nom = NomByModel(Vehicule)
    if Propriete ~= nil then
        if HealthEngine >= 750/10 then
            RageUI.Popup({message= "Vérification de la ~b~propriété~s~ ..."})
            TaskLeaveAnyVehicle(Joueur, 1, 1)
            SetVehicleUndriveable(Vehicule, true)
            SetVehicleDoorsLockedForAllPlayers(Vehicule, true)
            Wait(4500)
            ESX.TriggerServerCallback("core:GetOwnedVeh", function(Valide) 
                if Valide then
                    RageUI.Popup({message= "- ~y~" .. Garage .. "~s~\n- Type : ~b~Véhicule~s~\n- ~o~Non propriétaire~s~"})
                    SetEntityAlpha(Vehicule, 150)
                    Wait(2850)
                    TriggerServerEvent("core:GarageEntUp", Propriete.plate, true)
                    ESX.Game.DeleteVehicle(Vehicule)
                    ESX.ShowNotification("- Véhicule storée.\n- Plaque : ~y~" .. Propriete.plate)
                else 
                    RageUI.Popup({message= "- ~y~" .. Garage .. "~s~\n- Type : ~b~Véhicule~s~\n- ~g~Propriétaire~s~ reconnus"})
                    SetEntityAlpha(Vehicule, 150)
                    Wait(2850)
                    TriggerServerEvent("core:GarageEntUp", Propriete.plate, true)
                    ESX.Game.DeleteVehicle(Vehicule)
                    ESX.ShowNotification("- Véhicule storée.\n- Plaque : ~y~" .. Propriete.plate)
                end
            end, Propriete, Propriete.plate, Garage)
        else 
            ESX.ShowNotification("- ~r~Action impossible~s~\n- Véhicule trop ~o~endomager~s~.\n- Aller voir un(e)\n- ~g~mécanicien(ne)~s~")
        end
    end
end 

RefreshListeVehByGarage = function(Garage)
   ESX.TriggerServerCallback("core:GetlisteVeh", function(Liste)
        ListeCall = Liste
   end, Garage)
end

RefreshListeVehPartagerByGarage = function(Garage)
    ESX.TriggerServerCallback("core:GetlisteVehRelease", function(ListePartage)
         ListeCallPartage = ListePartage
    end, Garage)
 end