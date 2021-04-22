KeyboardInput = function(TextEntry, ExampleText, MaxStringLength) -- KeyBoard pour écrire
	AddTextEntry('FMMC_KEY_TIP1', TextEntry .. '')
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
	blockinput = true
	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		blockinput = false
		return result
	else
		Citizen.Wait(500)
		blockinput = false
		return nil
	end
end

NotificationHelp = function(msg) -- Notification au dessus
    AddTextEntry('HelpNotification', msg)
    DisplayHelpTextThisFrame('HelpNotification', false)
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

table.empty = function(self)
	for _,_  in pairs(self) do
		return false
	end
	return true
end