
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then
		ESX.PlayerData = ESX.GetPlayerData()
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

local VehiculeModelisation = {props = nil, entity = nil, model = nil, price = nil}
local Camera = false
local Stat = false
local VehiculeChoisie = {nil}
local ZoneConcess = {
    {position = vector3(-46.14, -1092.94, 26.39+1.0), markerid = 20, zone = "action", noti = "Appuyez sur ~INPUT_PICKUP~ pour intéragir.", rouge = 150, vert = 50, bleu = 50}, -- Menu Action
    {position = vector3(-51.8, -1063.76, 27.65+1.0), markerid = 20, zone = "hangar", noti = "Appuyez sur ~INPUT_PICKUP~ pour entrer dans le hangar.", rouge = 150, vert = 50, bleu = 50}, -- Menu Action
}
local invalidcode = 0
local charset = {} do
    for c = 65, 90  do table.insert(charset, string.char(c)) end
end
local function randomString(length)
    if not length or length <= 0 then return '' end
    return randomString(length - 1) .. charset[math.random(1, #charset)]
end
local GestionVeh = {Action = {"Attribuer"}, index = 1}
local VoitureSpawnZone1 = {[1] = {x= 192.0, y= -998.5, z= -99.0, h = 180.0},[2] = {x= 194.5, y= -998.5, z= -99.0, h = 180.0},[3] = {x= 197.0, y= -998.5, z= -99.0, h = 180.0},[4] = {x= 199.5, y= -998.5, z= -99.0, h = 180.0},[5] = {x= 202.0, y= -998.5, z= -99.0, h = 180.0},[6] = {x= 204.5, y= -998.5, z= -99.0, h = 180.0}}
local ListeVehCall
local Panel = { panel = {percentage = 1},Couleur = { [1] = 1, [2] = 1 },	CouleurSecondaire = { [1] = 1, [2] = 1 },CouleurBarbePrincipal = { [1] = 1, [2] = 1 },	CouleurSourcilPrincipal = { [1] = 1, [2] = 1 },	}

local vehicle = {
    {
       classe =  "Compacts",
        vehs = {
            {vehs= "blista", prix=7500},
            {vehs= "brioso", prix=4500},
            {vehs= "dilettante", prix=5500},
            {vehs= "issi2", prix=5000},
            {vehs= "issi3", prix=5500},
            {vehs= "panto", prix=3500},
            {vehs= "prairie", prix=9500},
            {vehs= "rhapsody", prix=8000},
        },
    },
    {
       classe =  "Coupes",
        vehs = {
            {vehs= "cogcabrio", prix=9500},
            {vehs= "exemplar", prix=9300},
            {vehs= "f620", prix=11500},
            {vehs= "felon", prix=10000},
            {vehs= "felon2", prix=11000},
            {vehs= "jackal", prix=12000},
            {vehs= "oracle", prix=9500},
            {vehs= "oracle2", prix=10500},
            {vehs= "sentinel", prix=10000},
            {vehs= "sentinel2", prix=10500},
            {vehs= "windsor", prix=13000},
            {vehs= "windsor2", prix=14000},
            {vehs= "zion", prix=12000},
            {vehs= "zion2", prix=12500},
        },
    },
    {
       classe =  "Muscle",
        vehs = {
            {vehs= "blade", prix=13500},
            {vehs= "buccaneer", prix=12500},
            {vehs= "buccaneer2", prix=13000},
            {vehs= "chino", prix=11500},
            {vehs= "chino2", prix=12000},
            {vehs= "clique", prix=14500},
            {vehs= "coquette3", prix=15000},
            {vehs= "deviant", prix=15000},
            {vehs= "dominator", prix=14000},
            {vehs= "dominator2", prix=14500},
            {vehs= "dominator3", prix=26000},
            {vehs= "dukes", prix=13500},
            {vehs= "faction", prix=12000},
            {vehs= "faction2", prix=13000},
            {vehs= "faction3", prix=13500},
            {vehs= "ellie", prix=13500},
            {vehs= "gauntlet", prix=13500},
            {vehs= "gauntlet2", prix=14000},
            {vehs= "hermes", prix=22000},
            {vehs= "hotknife", prix=14000},
            {vehs= "hustler", prix=18000},
            {vehs= "impaler", prix=14000},
            {vehs= "impaler2", prix=14500},
            {vehs= "impaler3", prix=15000},
            {vehs= "impaler4", prix=15500},
            {vehs= "imperator", prix=17000},
            {vehs= "imperator2", prix=17500},
            {vehs= "imperator3", prix=18000},
            {vehs= "moonbeam", prix=16000},
            {vehs= "moonbeam2", prix=17000},
            {vehs= "phoenix", prix=16000},
            {vehs= "picador", prix=15500},
            {vehs= "ratloader", prix=7800},
            {vehs= "ratloader2", prix=13500},
            {vehs= "ruiner", prix=18000},
            {vehs= "sabregt", prix=17500},
            {vehs= "sabregt2", prix=18000},
            {vehs= "slamvan", prix=17500},
            {vehs= "slamvan2", prix=18000},
            {vehs= "slamvan3", prix=18500},
            {vehs= "slamvan4", prix=19000},
            {vehs= "slamvan5", prix=19500},
            {vehs= "slamvan6", prix=20000},
            {vehs= "stalion", prix=18000},
            {vehs= "stalion2", prix=18500},
            {vehs= "tampa", prix=17500},
            {vehs= "tulip", prix=16500},
            {vehs= "vamos", prix=16000},
            {vehs= "vigero", prix=17500},
            {vehs= "virgo", prix=16500},
            {vehs= "virgo2", prix=17000},
            {vehs= "virgo3", prix=17500},
            {vehs= "voodoo", prix=19000},
            {vehs= "voodoo2", prix=20000},
            {vehs= "yosemite", prix=24000},
        },
    },
    {
       classe =  "Off-Road",
        vehs = {
            {vehs= "bfinjection", prix=9500},
            {vehs= "bifta", prix=11500},
            {vehs= "blazer", prix=7500},
            {vehs= "blazer2", prix=8000},
            {vehs= "blazer3", prix=8500},
            {vehs= "blazer4", prix=9000},
            {vehs= "bodhi2", prix=14000},
            {vehs= "brawler", prix=19000},
            {vehs= "brutus", prix=17500},
            {vehs= "brutus2", prix=18000},
            {vehs= "brutus3", prix=18500},
            {vehs= "dloader", prix=14500},
            {vehs= "dubsta3", prix=25000},
            {vehs= "freecrawler", prix=21000},
            {vehs= "kalahari", prix=13500},
            {vehs= "kamacho", prix=23500},
            {vehs= "marshall", prix=35000},
            {vehs= "mesa3", prix=21000},
            {vehs= "rancherxl", prix=18500},
            {vehs= "rebel", prix=17500},
            {vehs= "rebel2", prix=18000},
            {vehs= "riata", prix=21000},
            {vehs= "sandking", prix=25000},
            {vehs= "sandking2", prix=26000},
            {vehs= "trophytruck", prix=27000},
            {vehs= "trophytruck2", prix=28000},
        },
    },
    {
       classe =  "SUVs",
        vehs = {
            {vehs= "baller", prix=24000},
            {vehs= "baller2", prix=25000},
            {vehs= "baller3", prix=26000},
            {vehs= "baller4", prix=27500},
            {vehs= "bjxl", prix=21500},
            {vehs= "cavalcade", prix=20000},
            {vehs= "cavalcade2", prix=20500},
            {vehs= "contender", prix=36000},
            {vehs= "dubsta", prix=27800},
            {vehs= "dubsta2", prix=28000},
            {vehs= "fq2", prix=24500},
            {vehs= "granger", prix=26000},
            {vehs= "gresley", prix=21500},
            {vehs= "habanero", prix=19500},
            {vehs= "huntley", prix=15500},
            {vehs= "landstalker", prix=14500},
            {vehs= "mesa", prix=16500},
            {vehs= "patriot", prix=17800},
            {vehs= "radi", prix=14500},
            {vehs= "rocoto", prix=15000},
            {vehs= "seminole", prix=14000},
            {vehs= "serrano", prix=14500},
            {vehs= "toros", prix=45000},
            {vehs= "xls", prix=16500},
        },
    },
    {
       classe =  "Sedans",
        vehs = {
            {vehs= "asea", prix=11500},
            {vehs= "asterope", prix=12000},
            {vehs= "cog55", prix=15000},
            {vehs= "cognoscenti", prix=15500},
            {vehs= "emperor", prix=13500},
            {vehs= "emperor2", prix=12000},
            {vehs= "fugitive", prix=11500},
            {vehs= "glendale", prix=12000},
            {vehs= "ingot", prix=13000},
            {vehs= "intruder", prix=13500},
            {vehs= "premier", prix=12500},
            {vehs= "primo", prix=12500},
            {vehs= "primo2", prix=15000},
            {vehs= "regina", prix=11500},
            {vehs= "romero", prix=18500},
            {vehs= "stafford", prix=21000},
            {vehs= "stanier", prix=12500},
            {vehs= "stratum", prix=13500},
            {vehs= "stretch", prix=29000},
            {vehs= "superd", prix=23000},
            {vehs= "surge", prix=13500},
            {vehs= "tailgater", prix=12500},
            {vehs= "warrener", prix=11500},
            {vehs= "washington", prix=12500},
        },
    },
    {
       classe =  "Sports",
        vehs = {
            {vehs= "alpha", prix=34000},
            {vehs= "banshee", prix=36000},
            {vehs= "bestiagts", prix=35500},
            {vehs= "blista2", prix=24000},
            {vehs= "blista3", prix=24500},
            {vehs= "buffalo", prix=27000},
            {vehs= "buffalo2", prix=27500},
            {vehs= "buffalo3", prix=28000},
            {vehs= "carbonizzare", prix=38500},
            {vehs= "comet2", prix=48500},
            {vehs= "comet3", prix=49000},
            {vehs= "comet4", prix=49500},
            {vehs= "comet5", prix=50000},
            {vehs= "coquette", prix=41000},
            {vehs= "deveste", prix=128000},
            {vehs= "elegy", prix=38500},
            {vehs= "elegy2", prix=44000},
            {vehs= "feltzer2", prix=41500},
            {vehs= "flashgt", prix=43000},
            {vehs= "furoregt", prix=41500},
            {vehs= "fusilade", prix=41000},
            {vehs= "futo", prix=37500},
            {vehs= "gb200", prix=38500},
            {vehs= "hotring", prix=37000},
            {vehs= "italigto", prix=48500},
            {vehs= "jester", prix=45000},
            {vehs= "jester2", prix=46000},
            {vehs= "jester3", prix=47000},
            {vehs= "khamelion", prix=43500},
            {vehs= "kuruma", prix=42500},
            {vehs= "lynx", prix=43500},
            {vehs= "massacro", prix=44500},
            {vehs= "massacro2", prix=45000},
            {vehs= "neon", prix=43500},
            {vehs= "ninef", prix=42500},
            {vehs= "ninef2", prix=43500},
            {vehs= "omnis", prix=41000},
            {vehs= "pariah", prix=42500},
            {vehs= "penumbra", prix=39000},
            {vehs= "raiden", prix=41000},
            {vehs= "rapidgt", prix=41000},
            {vehs= "rapidgt2", prix=41500},
            {vehs= "raptor", prix=38500},
            {vehs= "revolter", prix=42000},
            {vehs= "ruston", prix=45000},
            {vehs= "schafter2", prix=41000},
            {vehs= "schafter3", prix=42000},
            {vehs= "schafter4", prix=43000},
            {vehs= "schlagen", prix=47000},
            {vehs= "schwarzer", prix=43000},
            {vehs= "sentinel3", prix=41500},
            {vehs= "seven70", prix=43500},
            {vehs= "specter", prix=42500},
            {vehs= "specter2", prix=43000},
            {vehs= "streiter", prix=44000},
            {vehs= "sultan", prix=32500},
            {vehs= "tampa2", prix=35000},
            {vehs= "tropos", prix=36000},
            {vehs= "verlierer2", prix=38000},

        },
    },
    {
       classe =  "Sports Classic",
        vehs = {
            {vehs= "ardent", prix=65000},
            {vehs= "btype", prix=55000},
            {vehs= "btype2", prix=54000},
            {vehs= "btype3", prix=58000},
            {vehs= "casco", prix=47000},
            {vehs= "cheetah2", prix=51000},
            {vehs= "coquette2", prix=53000},
            {vehs= "fagaloa", prix=24000},
            {vehs= "feltzer3", prix=58000},
            {vehs= "gt500", prix=48000},
            {vehs= "infernus2", prix=64000},
            {vehs= "mamba", prix=44000},
            {vehs= "manana", prix=31000},
            {vehs= "michelli", prix=32000},
            {vehs= "monroe", prix=36000},
            {vehs= "peyote", prix=29000},
            {vehs= "pigalle", prix=29500},
            {vehs= "rapidgt3", prix=31000},
            {vehs= "retinue", prix=31200},
            {vehs= "savestra", prix=31000},
            {vehs= "stinger", prix=36000},
            {vehs= "stingergt", prix=38000},
            {vehs= "stromberg", prix=48000},
            {vehs= "swinger", prix=44000},
            {vehs= "torero", prix=49000},
            {vehs= "tornado", prix=41000},
            {vehs= "tornado2", prix=42000},
            {vehs= "tornado3", prix=43000},
            {vehs= "tornado4", prix=44000},
            {vehs= "tornado5", prix=45000},
            {vehs= "tornado6", prix=46000},
            {vehs= "turismo2", prix=55000},
            {vehs= "viseris", prix=56000},
            {vehs= "z190", prix=51000},
            {vehs= "ztype", prix=65000},
            {vehs= "cheburek", prix=34000},
        },
    },
    {
       classe =  "Super",
        vehs = {
            {vehs= "adder", prix=525000},
            {vehs= "autarch", prix=550000},
            {vehs= "banshee2", prix=225000},
            {vehs= "bullet", prix=180500},
            {vehs= "cheetah", prix=235000},
            {vehs= "cyclone", prix=245000},
            {vehs= "entity2", prix=325000},
            {vehs= "entityxf", prix=320000},
            {vehs= "fmj", prix=321000},
            {vehs= "gp1", prix=324000},
            {vehs= "infernus", prix=265000},
            {vehs= "italigtb", prix=315000},
            {vehs= "italigtb2", prix=320000},
            {vehs= "le7b", prix=445000},
            {vehs= "nero", prix=365000},
            {vehs= "nero2", prix=370000},
            {vehs= "osiris", prix=445000},
            {vehs= "penetrator", prix=280000},
            {vehs= "pfister811", prix=315000},
            {vehs= "prototipo", prix=750000},
            {vehs= "reaper", prix=385000},
            {vehs= "sc1", prix=365000},
            {vehs= "sheava", prix=480000},
            {vehs= "sultanrs", prix=220000},
            {vehs= "sultan2", prix=250000},
            {vehs= "t20", prix=465000},
            {vehs= "taipan", prix=432000},
            {vehs= "tempesta", prix=395000},
            {vehs= "tezeract", prix=650000},
            {vehs= "turismor", prix=550000},
            {vehs= "tyrant", prix=565000},
            {vehs= "tyrus", prix=480000},
            {vehs= "vacca", prix=435000},
            {vehs= "vagner", prix=650000},
            {vehs= "visione", prix=375000},
            {vehs= "voltic", prix=225000},
            {vehs= "xa21", prix=385000},
            {vehs= "zentorno", prix=375000},
        },
    },
    {
       classe =  "Vans",
        vehs = {
            {vehs= "bison", prix=35000},
            {vehs= "bison2", prix=36000},
            {vehs= "bison3", prix=37000},
            {vehs= "burrito", prix=31000},
            {vehs= "burrito2", prix=32000},
            {vehs= "burrito3", prix=33000},
            {vehs= "burrito4", prix=34000},
            {vehs= "burrito5", prix=35000},
            {vehs= "gburrito", prix=36000},
            {vehs= "gburrito2", prix=37000},
            {vehs= "journey", prix=25000},
            {vehs= "minivan", prix=28000},
            {vehs= "minivan2", prix=32000},
            {vehs= "paradise", prix=28500},
            {vehs= "rumpo3", prix=36000},
            {vehs= "speedo", prix=24000},
            {vehs= "speedo4", prix=26000},
            {vehs= "surfer", prix=21000},
            {vehs= "surfer2", prix=23000},
            {vehs= "youga", prix=22000},
            {vehs= "youga2", prix=23000},

        },
    },
}

local ListeVehCall
local Panel = { panel = {percentage = 1},Couleur = { [1] = 1, [2] = 1 },	CouleurSecondaire = { [1] = 1, [2] = 1 },CouleurBarbePrincipal = { [1] = 1, [2] = 1 },	CouleurSourcilPrincipal = { [1] = 1, [2] = 1 },	}

Citizen.CreateThread(function()

    RMenu.Add("core", "concessionnaire_action_code", RageUI.CreateMenu("Gestion bancaire", "none"))
    RMenu:Get('core', 'concessionnaire_action_code'):SetRectangleBanner(39, 41, 39, 100)

    RMenu.Add("core", "concessionnaire_action_main", RageUI.CreateMenu("Action disponible", "none"))
    RMenu:Get('core', 'concessionnaire_action_main'):SetRectangleBanner(39, 41, 39, 100)
    RMenu.Add('core', 'concessionnaire_action_main_attribution', RageUI.CreateSubMenu(RMenu:Get('core', 'concessionnaire_action_main'), "Attribution de véhicule", "none"))
    RMenu.Add('core', 'concessionnaire_action_main_facture', RageUI.CreateSubMenu(RMenu:Get('core', 'concessionnaire_action_main'), "Facturation", "none"))
    RMenu.Add('core', 'concessionnaire_action_main_achatveh', RageUI.CreateSubMenu(RMenu:Get('core', 'concessionnaire_action_main'), "Catégories de classe", "none"))
    RMenu.Add('core', 'concessionnaire_action_main_achatveh2', RageUI.CreateSubMenu(RMenu:Get('core', 'concessionnaire_action_main_achatveh'), "Paiement", "none"))
    RMenu:Get('core', 'concessionnaire_action_main_achatveh2').Closed = function()
        VehiculeModelisation.model = nil
        DeleteVehicle(VehiculeModelisation.entity)
        Stat = false
        rotate = false
        Couleur = false
    end

    for k,v in pairs(vehicle) do
        RMenu.Add('core', v.classe, RageUI.CreateSubMenu(RMenu:Get('core', 'concessionnaire_action_main_achatveh'), "Liste des véhicule", "none"))
        RMenu:Get('core', v.classe).Closed = function()
            VehiculeModelisation.model = nil
            DeleteVehicle(VehiculeModelisation.entity)
            Stat = false
            rotate = false
            Couleur = false
        end
    end
    
    while true do
        local Open = false
            for k,v in pairs(ZoneConcess) do
                if Vdist2(GetEntityCoords(PlayerPedId(), false), v.position) < 2 and ESX.PlayerData.job.name == "concessionaire"  and not RageUI.Visible(RageUI.CurrentMenu) then
                    Open = true
                    NotificationHelp(v.noti)  
                    DrawMarker(v.markerid, v.position, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.0, 0.2, v.rouge, v.vert, v.bleu, 100, 0, 0, 2, 1, nil, nil, 0)
                    if IsControlJustPressed(1, 51) then
                        if v.zone == "action" then 
                            RageUI.Visible(RMenu:Get('core', 'concessionnaire_action_main'), true)
                        elseif v.zone == "hangar" then 
                            ESX.TriggerServerCallback("core:GetListeVehEntrepot", function(ListeVeh)
                                ListeVehCall = ListeVeh
                                hangarsortie = true
                                DoScreenFadeOut(500)
                                Wait(600)
                                SetEntityCoords(PlayerPedId(), 197.934, -1005.716, -99.000, 0.0, 0.0, 0.0, true)
                                Wait(1000)
                                DoScreenFadeIn(1000)
                                for k, v in pairs (ListeVehCall) do
                                    if v.attribuer == 1 then
                                        if DoesEntityExist(ListeVehCall[k].Voiture) then
                                            SetEntityAsMissionEntity(ListeVehCall[k].Voiture, false, true)
                                            DeleteVehicle(ListeVehCall[k].Voiture)
                                        end
                                        RequestModel(GetHashKey(ListeVehCall[k].model))  
                                        while not HasModelLoaded(GetHashKey(ListeVehCall[k].model)) do
                                            Citizen.Wait(100)
                                        end
                                        ListeVehCall[k].Voiture = CreateVehicle(GetHashKey(ListeVehCall[k].model), VoitureSpawnZone1[k].x, VoitureSpawnZone1[k].y, VoitureSpawnZone1[k].z, VoitureSpawnZone1[k].h, true, false)
                                        SetVehicleCustomPrimaryColour(ListeVehCall[k].Voiture, v.color1.CouleurPrinc.CouleurRed, v.color1.CouleurPrinc.CouleurGreen, v.color1.CouleurPrinc.CouleurBlue)
                                        SetVehicleCustomSecondaryColour(ListeVehCall[k].Voiture, v.color2.CouleurSec.CouleurSecondaireRed, v.color2.CouleurSec.CouleurSecondaireGreen, v.color2.CouleurSec.CouleurSecondaireBlue)
                                        SetEntityAsMissionEntity(ListeVehCall[k].Voiture, true, false)
                                        SetVehicleHasBeenOwnedByPlayer(ListeVehCall[k].Voiture, true)
                                        SetVehicleNeedsToBeHotwired(ListeVehCall[k].Voiture, false)
                                        SetVehRadioStation(ListeVehCall[k].Voiture, 'OFF')
                                        SetVehicleNumberPlateText(ListeVehCall[k].Voiture, v.plaque or v.id)
                                        SetModelAsNoLongerNeeded(GetHashKey(ListeVehCall[k].model))
                                    end
                                end
                            end)
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
    CarDeal = AddBlipForCoord(vector3(-53.51, -1093.01, 26.37))
    SetBlipSprite(CarDeal, 227)
    SetBlipDisplay(CarDeal, 4)
    SetBlipScale(CarDeal, 0.3)
    SetBlipColour(CarDeal, 66)
    SetBlipAsShortRange(CarDeal, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Motor Sport Premium")
    EndTextCommandSetBlipName(CarDeal)
end)

Citizen.CreateThread(function()
    while true do 

        if hangarsortie then
            if  ListeVehCall then 
                for k, v in pairs (ListeVehCall) do
                    if IsPedSittingInAnyVehicle(PlayerPedId()) then
                         NotificationHelp("Appuyez sur ~INPUT_PICKUP~ pour sortir.")    
                        if IsControlJustPressed(1, 51) then
                            hangarsortie = false
                            Stat = false
                            DoScreenFadeOut(500)
                            Wait(1000)
                            local Joueur = GetPlayerPed(-1)
                            local Vehicule = GetVehiclePedIsIn(Joueur,false)
                            local Propriete  = ESX.Game.GetVehicleProperties(Vehicule)
                            TriggerServerEvent("core:DelEntrepot", Propriete.plate)          
                            for height = 1, 1000 do
                                SetPedCoordsKeepVehicle(PlayerPedId(), -53.77, -1062.88, 27.46, height + 0.0)
                    
                                local foundGround, zPos = GetGroundZFor_3dCoord(-53.77, -1062.88, 27.46, height + 0.0)
                    
                                if foundGround then
                                    SetPedCoordsKeepVehicle(PlayerPedId(), -53.77, -1062.88, 27.46, height + 0.0)
                                    break
                                end
                                Wait(15)
                            end
                            Wait(1000)
                            DoScreenFadeIn(1000)
                        end
                    end
                end
            end
            if Vdist2(GetEntityCoords(PlayerPedId(), false), vector3(197.934, -1005.717, -99.000)) < 2 then
                 NotificationHelp("Appuyez sur ~INPUT_PICKUP~ pour sortir.")    
                DrawMarker(20, vector3(197.934, -1005.717, -99.000+1.0), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.0, 0.2, 50, 150, 50, 100, 0, 0, 2, 1, nil, nil, 0)
                if IsControlJustPressed(1, 51) then
                    Stat = false
                    DoScreenFadeOut(500)
                    Wait(1000)                
                    SetEntityCoords(PlayerPedId(), vector3(-51.8, -1063.76, 27.65))
                    Wait(1000)
                    DoScreenFadeIn(500)
                    for k, v in pairs (ListeVehCall) do
                        if DoesEntityExist(ListeVehCall[k].Voiture) then
                            SetEntityAsMissionEntity(ListeVehCall[k].Voiture, false, true)
                            DeleteVehicle(ListeVehCall[k].Voiture)
                        end
                    end
                end
            end
        end

        RageUI.IsVisible(RMenu:Get('core', 'concessionnaire_action_main') , true, true, true, function()
            RageUI.CenterButton("- ~r~Intéraction automobile~s~ -", nil, {}, true, function(Hovered, Active, Selected)
            end)
            if ESX.PlayerData.job.grade_name == 'gerant' then
                RageUI.Button("Acheter un véhicule", nil, {}, true, function(Hovered, Active, Selected)
                end, RMenu:Get('core', 'concessionnaire_action_main_achatveh'))
            else 
                RageUI.Button("~c~Acheter un véhicule", nil, {RightBadge = RageUI.BadgeStyle.Lock}, true, function(Hovered, Active, Selected)
                end)
            end
            RageUI.Button("Rédiger une facture", nil, {}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('core', 'concessionnaire_action_main_facture'))
            RageUI.Button("Attribuer un véhicule du hangar", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    RefreshListeVehConcessDispo()
                end
            end, RMenu:Get('core', 'concessionnaire_action_main_attribution'))
        end)
        RageUI.IsVisible(RMenu:Get('core', 'concessionnaire_action_main_achatveh') , true, true, true, function()
            RageUI.CenterButton("- ~b~Liste des classes~s~ -", nil, {}, true, function(Hovered, Active, Selected)
            end)
            for k,v in pairs(vehicle) do
                RageUI.Button(v.classe, nil, {}, true, function(Hovered, Active, Selected)
                    if Selected then
                        RMenu:Get('core', v.classe):SetTitle("Classe - [~b~".. v.classe.. "~s~]")
                        RMenu:Get('core', v.classe).EnableMouse = true
                    end
                end, RMenu:Get('core', v.classe))
            end
           
        end)
        for k,v in pairs(vehicle) do
            RageUI.IsVisible(RMenu:Get('core', v.classe), true, true, false, function()
                for k,v in pairs(v.vehs) do
                    RageUI.Button(NomByModel(v.vehs), nil, {RightLabel= "~g~" .. v.prix .. "$"}, true, function(Hovered, Active, Selected)
                        if Active then
							if VehiculeModelisation.model ~= GetHashKey(v.vehs) then
								DeleteVehicle(VehiculeModelisation.entity)
								CreateLocalVehConcess(GetHashKey(v.vehs), v.vehs, NomByModel(v.vehs))
                                Stat = true
                                Couleur = true 	
							end
                        end
                        if Selected then 
                            Couleur1 = json.encode{CouleurPrinc = CouleurPrinc}
                            Couleur2 = json.encode{CouleurSec = CouleurSec}
                            print(Couleur2)
                            VehiculeChoisie = v
                        end
                    end, RMenu:Get('core', 'concessionnaire_action_main_achatveh2'))
                end
                if Couleur then
                    
                    RageUI.ColourPanel("Couleur Principale", RageUI.PanelColour.HairCut, Panel.Couleur[1], Panel.Couleur[2] + 1, function(Hovered, Active, MinimumIndex, CurrentIndex)			
                        if Active then 		
                            Panel.Couleur[2] = CurrentIndex - 1
                            Panel.Couleur[1] = MinimumIndex
                            for k,v in pairs(RageUI.PanelColour.HairCut) do
                                if k == CurrentIndex then
                                    r, g, b = table.unpack(v)
                                    CouleurPrinc = {
                                        CouleurRed =  r,
                                        CouleurGreen =  g,
                                        CouleurBlue =  b
                                    }                                
                                end
                            end
                            SetVehicleCustomPrimaryColour(VehiculeModelisation.entity, CouleurPrinc.CouleurRed, CouleurPrinc.CouleurGreen, CouleurPrinc.CouleurBlue)
                        end
                    end)
                    RageUI.ColourPanel("Couleur Secondaire", RageUI.PanelColour.HairCut, Panel.CouleurSecondaire[1], Panel.CouleurSecondaire[2] + 1, function(Hovered, Active, MinimumIndex, CurrentIndexx)			
                        if Active then		
                            Panel.CouleurSecondaire[2] = CurrentIndexx - 1
                            Panel.CouleurSecondaire[1] = MinimumIndex
                            for k,v in pairs(RageUI.PanelColour.HairCut) do
                                if k == CurrentIndexx then
                                    r, g, b = table.unpack(v)
                                    CouleurSec = {
                                        CouleurSecondaireRed =  r,
                                        CouleurSecondaireGreen =  g,
                                        CouleurSecondaireBlue =  b
                                    }                                
                                end
                            end
                            SetVehicleCustomSecondaryColour(VehiculeModelisation.entity, CouleurSec.CouleurSecondaireRed, CouleurSec.CouleurSecondaireGreen, CouleurSec.CouleurSecondaireBlue)
                        end
                    end)
                end
            end)
        end
        RageUI.IsVisible(RMenu:Get('core', 'concessionnaire_action_main_facture') , true, true, true, function()
            RageUI.CenterButton("- ~y~Facturation~s~ -", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            end)
        end)
        RageUI.IsVisible(RMenu:Get('core', 'concessionnaire_action_main_attribution') , true, true, true, function()
            if ListeVehCall then 
                for k ,v in pairs(ListeVehCall) do
                    if v.attribuer == 1 then 
                        v.proprio = v.identite
                    else 
                        v.proprio = "~r~Aucun"
                    end
                    RageUI.List(v.nom, GestionVeh.Action, GestionVeh.index, nil, {}, true, function(Hovered, Active, Selected, Index)
                        if Selected then 
                            if Index == 1 then
                                if v.attribuer == 1 then 
                                    RageUI.Popup({message= "Véhicule déjà ~r~attribuer~s~ à un client ..."})
                                else 
                                    local player, distance = ESX.Game.GetClosestPlayer()
                                    if distance~=-1 and distance <=3.0 then
                                        TriggerServerEvent("core:GiveConcessVehicule", GetPlayerServerId(player), v.model, v.plaque, v.nom)
                                        Wait(2500)
                                        RefreshListeVehConcessDispo()
                                    else 
                                        RageUI.Popup({message= "Aucun ~b~client~s~ à proximité."})
                                    end
                                end
                            end
                        end
                        GestionVeh.index = Index
                    end)
                end
                for k,v in pairs(ListeVehCall) do 
                    local speed = GetVehicleModelMaxSpeed(v.model)*3.6
                    local speed = speed/220
                    local accel = GetVehicleModelAcceleration(v.model)*3.6
                    local accel = accel/220
                    local seats = GetVehicleModelNumberOfSeats(v.model)
                    local braking = GetVehicleModelMaxBraking(v.model)/2
                    RageUI.StatisticPanel(speed, "Vitesse maximum", k)
                    RageUI.StatisticPanel(accel*100, "Accélération", k)
                    RageUI.StatisticPanel(braking, "Freinage", k)
                    RageUI.BoutonPanel("Plaque numérisée :", "~y~" .. v.plaque, k)
                    RageUI.BoutonPanel("Propriétaire :", "~b~" .. v.proprio, k)
                end  
            end
        end)
        RageUI.IsVisible(RMenu:Get('core', 'concessionnaire_action_main_achatveh2') , true, true, true, function()
            RageUI.CenterButton("- ~b~Achat du véhicule~s~ -", nil, {}, true, function(Hovered, Active, Selected)
            end)
            RageUI.CenterButton("Acheter le véhicule ~b~" .. NomByModel(VehiculeChoisie.vehs), nil, {}, true, function(Hovered, Active, Selected)
                if Selected then                          
                    TriggerServerEvent("core:AchatVehConcess", VehiculeChoisie.vehs, NomByModel(VehiculeChoisie.vehs), ESX.PlayerData.job.name, VehiculeChoisie.prix, math.random(10, 99) .. randomString(3) .. math.random(100, 999), Couleur1, Couleur2)  
                end
            end)
        end)
        Wait(0)
    end
end)


RefreshListeVehConcessDispo  = function()
    ESX.TriggerServerCallback("core:GetListeVehEntrepot", function(ListeVeh)
        ListeVehCall = ListeVeh
    end)
end


CreateLocalVehConcess = function(model, vehs, nom)
	RequestModel(model)
	while not HasModelLoaded(model) do Wait(1) end
	local veh = CreateVehicle(model, -55.74, -1097.13,  27.37, 280.0, false, true)
	SetVehicleOnGroundProperly(veh)
	FreezeEntityPosition(veh, 1)
	if props then
		ESX.Game.SetVehicleProperties(vehicle, props)
	end
	--TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
	VehiculeModelisation.entity = veh
	VehiculeModelisation.model = model
	VehiculeModelisation.props = ESX.Game.GetVehicleProperties(veh)
	if name ~= nil then VehiculeModelisation.name = name end
	SetModelAsNoLongerNeeded(model)
	rotate = false
	Wait(50)
	RotateLocalVehConcess(vehs, nom)
end

RotateLocalVehConcess = function(vehs)
    rotate = true
	Citizen.CreateThread(function()
		while rotate do
			Wait(1)
			SetEntityHeading(VehiculeModelisation.entity, GetEntityHeading(VehiculeModelisation.entity) + 0.05)
		end
	end)
end

NomByModel = function(Vehicule)
    local Model = GetDisplayNameFromVehicleModel(Vehicule)
    local Nom = GetLabelText(Model)
    if Nom ~= "NULL" then
        return Nom
    end
    if Model ~= "CARNOTFOUND" then
        return Model
    end
    return Vehicule
end