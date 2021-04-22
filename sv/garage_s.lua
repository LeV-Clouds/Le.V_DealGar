ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback("core:GetlisteVeh", function(source, CallBack, Garage)
    local xPlayer = ESX.GetPlayerFromId(source)
    local Get = {}
    MySQL.Async.fetchAll("SELECT * FROM joueur_vehicules WHERE license = @license AND garage = @garage", {["@license"] = xPlayer.identifier, ["@garage"] = Garage}, function(GetInfos)
        for _,v in pairs(GetInfos) do
            local propriete = json.decode(v.propriete)
            table.insert(Get, {propriete = propriete, plaque = v.plaque, rob = v.rob, etat = v.etat, nom = v.firstname, identite = v.identite})
        end
        CallBack(Get)
    end)
end)

ESX.RegisterServerCallback("core:GetlisteVehRelease", function(source, CallBack, Garage)
    local xPlayer = ESX.GetPlayerFromId(source)
    local Get = {}
    MySQL.Async.fetchAll("SELECT * FROM joueur_vehicules WHERE partage = @partage AND garage = @garage", {["@partage"] = xPlayer.identifier, ["@garage"] = Garage}, function(GetInfos)
        for _,v in pairs(GetInfos) do
            local propriete = json.decode(v.propriete)
            table.insert(Get, {propriete = propriete, plaque = v.plaque, rob = v.rob, etat = v.etat, identite = v.identite})
        end
        CallBack(Get)
    end)
end)

ESX.RegisterServerCallback('core:GetOwnedVeh', function(source, callback, Propriete, Plaque, Garage, Nom)
    local xPlayer = ESX.GetPlayerFromId(source)
    local prop = json.encode(Propriete)
    MySQL.Async.fetchAll('SELECT * FROM joueur_vehicules WHERE plaque = @plaque AND license = @license', {
        ["@plaque"] = Plaque,
        ["@license"] = xPlayer.identifier,
    }, function(result)
        if result[1] ~= nil then
            callback(false)
            MySQL.Async.execute("UPDATE joueur_vehicules SET propriete = @propriete, garage  = @garage WHERE plaque = @plaque",{
                ['@propriete'] = prop,
                ['@plaque'] = Plaque,
                ['@garage'] = Garage
            })
        else
            callback(true)
            MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
                ["@identifier"] = xPlayer.identifier,
            }, function(ID)
                for k,v in pairs(ID) do
                    MySQL.Async.execute("INSERT INTO joueur_vehicules (license, identite, propriete, plaque, etat, garage, rob) VALUES (@license, @identite, @propriete, @plaque, @etat, @garage, @rob);", {
                        ["@license"] = xPlayer.identifier, 
                        ["@propriete"] = prop, 
                        ["@identite"] = v.firstname .. " " .. v.lastname, -- Trigger votre identité
                        ["@plaque"] = Plaque,
                        ["@etat"] = 1,
                        ["@garage"] = Garage,
                        ["@rob"] = 1
                    })
                end
            end)
        end
    end)
end)

RegisterServerEvent("core:RenameVeh") -- Renommer
AddEventHandler("core:RenameVeh", function(Plaque, Nom)
    MySQL.Async.execute("UPDATE joueur_vehicules SET nom = @nom WHERE plaque = @plaque",{
        ['@nom'] = Nom,
        ['@plaque'] = Plaque
    })
end)

RegisterServerEvent("core:GarageGiveVeh") --Partager
AddEventHandler("core:GarageGiveVeh", function(Plaque, Joueur, Vehicule, Garage)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(Joueur)
    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
        ["@identifier"] = xPlayer.identifier,
    }, function(ID)
        for k,v in pairs(ID) do
            MySQL.Async.execute("UPDATE joueur_vehicules SET partage = @partage WHERE plaque = @plaque",{
                ['@partage'] = xTarget.identifier,
                ['@plaque'] = Plaque
            })
            TriggerClientEvent("RageUI:Popup", xPlayer.source, {message="- ~y~" .. Garage .. "~s~\n- ~b~" .. Vehicule .. "~s~\n- Plaque : ~g~" .. Plaque .. "~s~\n- Type : ~o~Partagé"})
            TriggerClientEvent("RageUI:Popup", xTarget.source, {message="- ~y~" .. Garage .. "~s~\n- ~b~" .. Vehicule .. "~s~\n- Plaque : ~g~" .. Plaque .. "~s~\n- Type : ~o~Partage"})
        end 
    end)
end)

RegisterServerEvent("core:DeleteVehTo") -- Enlever de la table
AddEventHandler("core:DeleteVehTo", function(Plaque)
    MySQL.Async.execute("DELETE FROM joueur_vehicules WHERE plaque ='" .. Plaque .. "';", {}, function() end)
end)

RegisterNetEvent("core:GarageEntUp")  -- Change d'état le véhicule
AddEventHandler("core:GarageEntUp", function(plaque, etat)
    local _src = source
	MySQL.Async.execute("UPDATE joueur_vehicules SET `etat` =@etat WHERE plaque=@plaque",{
		['@etat'] = etat,
		['@plaque'] = plaque
	})
end)
