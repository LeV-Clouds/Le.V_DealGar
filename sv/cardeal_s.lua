ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent("core:AchatVehConcess")
AddEventHandler("core:AchatVehConcess", function(model, nom, metier, prix, plaque, couleur1, couleur2)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT argentpropre FROM argent_entreprise WHERE metier=@metier', {['@metier'] = metier}, function(result)
        for k, v in pairs(result) do
            if v.argentpropre >= tonumber(prix) and tonumber(prix) > 0 then
              MySQL.Async.execute("UPDATE argent_entreprise SET argentpropre='" .. v.argentpropre - tonumber(prix) .. "' WHERE metier ='" .. metier .. "';", {}, function() end)
              TriggerClientEvent("esx:showNotification", xPlayer.source, "- Nouvelle Achat\n- Modèle : ~b~" .. nom .. "~s~\n- Plaque : ~y~" .. plaque .. "~s~\n- Prix : ~g~" .. prix .."$")
                MySQL.Async.execute('INSERT INTO entrepot_concess (nom, model, prix, plaque, color1, color2) VALUES (@nom, @model, @prix,  @plaque, @color1, @color2)', {
                    ['@nom'] = nom,
                    ['@model'] = model,
                    ['@prix'] = prix,
                    ['@plaque'] = plaque,
                    ['@color1'] = couleur1,
                    ['@color2'] = couleur2,
                })
            else 
                TriggerClientEvent("esx:showNotification", xPlayer.source, "- ~r~Erreur~s~\n- Modèle : ~b~" .. nom .. "~s~\n- Plaque : ~y~" .. plaque .. "~s~\n- Prix : ~g~" .. prix .."$")
                TriggerClientEvent("esx:showNotification", xPlayer.source, "- ~r~Erreur~s~\n- l'entreprise n'as pas ~r~l'argent~s~.")
            end
        end
    end)
end)

RegisterServerEvent("core:GiveConcessVehicule")
AddEventHandler("core:GiveConcessVehicule", function(joueur, model, plaque, Vehicule)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(joueur)
    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {['@identifier'] = xTarget.identifier}, function(GetId)
        for k,v in pairs(GetId) do
            MySQL.Async.execute("INSERT INTO joueur_vehicules (license, identite, propriete, plaque, etat, garage, rob) VALUES (@license, @identite, @propriete, @plaque, @etat, @garage, @rob);", {
                ["@license"] = xTarget.identifier, 
                ["@propriete"] = json.encode({model = GetHashKey(model), plate = plaque}), 
                ["@identite"] = v.firstname .. " " .. v.lastname, 
                ["@plaque"] = plaque,
                ["@etat"] = 4,
                ["@garage"] = "Garage Centre",
                ["@rob"] = 0
            })
            MySQL.Async.execute("UPDATE entrepot_concess SET attribuer = @attribuer, identite = @identite WHERE plaque = @plaque",{
                ['@attribuer'] = 1,
                ['@plaque'] = plaque,
                ['@identite'] = v.firstname .. " " .. v.lastname
            })
            TriggerClientEvent("RageUI:Popup", xPlayer.source, {message="- ~y~Concessionnaire~s~\n- ~b~" .. Vehicule .. "~s~\n- Plaque : ~g~" .. plaque .. "~s~\n- Type : ~g~Attribuer"})
            TriggerClientEvent("RageUI:Popup", xTarget.source, {message="- ~y~Concessionnaire~s~\n- ~b~" .. Vehicule .. "~s~\n- Plaque : ~g~" .. plaque .. "~s~\n- Type : ~g~Attribuer"})
        end
    end)
end)

ESX.RegisterServerCallback("core:GetListeVehEntrepot", function(source, CallBack)
    local Get = {}
    MySQL.Async.fetchAll('SELECT * FROM entrepot_concess', {}, function(GetInfos)
        for _,v in pairs(GetInfos) do
            table.insert(Get, {color1 = json.decode(v.color1), color2 = json.decode(v.color2), nom = v.nom, model = v.model, prix = v.prix, plaque = v.plaque, attribuer = v.attribuer, identite = v.identite})
        end
        CallBack(Get)
    end)
end)

RegisterServerEvent("core:DelEntrepot")
AddEventHandler("core:DelEntrepot", function(Plaque)
    MySQL.Async.execute("DELETE FROM `entrepot_concess` WHERE plaque='" .. Plaque .. "';", {}, function() end)
end)
