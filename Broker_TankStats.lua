local TS = CreateFrame("Frame", "Broker_TankStats")
local LDB = LibStub("LibDataBroker-1.1")
local L = L
TS.Dodge = LDB:NewDataObject("Dodge", {text = "0%"..L["DODGE"], value = "0%", suffix = L["DODGE"]})
TS.block = LDB:NewDataObject("Block", {text = "0%"..L["BLOCK"], value = "0%", suffix = L["BLOCK"]})
TS.Parry = LDB:NewDataObject("Parry", {text = "0%"..L["PARRY"], value = "0%", suffix = L["PARRY"]})
TS.Exp = LDB:NewDataObject("Expertise", {text = "0"..L["EXP"], value = "0", suffix = L["EXP"]})
TS.Avoi = LDB:NewDataObject("Avoidance", {text = "0%"..L["AVOI"], value = "0%", suffix = L["AVOI"]})
LDB = nil

local format = string.format
local player = "player"
local two_fp = "%.2f%%"
local single = "%d"
local two = "%.2f"

TS:RegisterEvent("UNIT_STATS")
TS:RegisterEvent("UNIT_MODEL_CHANGED")
TS:RegisterEvent("UNIT_INVENTORY_CHANGED")
TS:RegisterEvent("PLAYER_LEVEL_UP")
TS:RegisterEvent("UNIT_AURA")
TS:RegisterEvent("PLAYER_LOGIN")

TS:SetScript("OnEvent", function(self, event, unit)
	if (unit and unit ~= player) then return end

	local dodge = format(two_fp, GetDodgeChance())
	self.Dodge.text = dodge..L["DODGE"]
	self.Dodge.value = dodge

	local block = format(two_fp, GetBlockChance())
	self.block.text = block..L["BLOCK"]
	self.block.value = block

	local parry = format(two_fp, GetParryChance())
	self.Parry.text = parry..L["PARRY"]
	self.Parry.value = parry

	local Exp = format(single, GetCombatRating(24))
	self.Exp.text = Exp..L["EXP"]
	self.Exp.value = Exp
	
	if (UnitClass("player") == "Druid" and GetShapeshiftForm() == 1 and UnitRace("player") == "Night Elf") then
		avoi =  format(two_fp, GetDodgeChance() + 7 + 1/(0.0625 + 0.956/(GetCombatRating(CR_DEFENSE_SKILL)/4.91850*0.04)))
	elseif (UnitClass("player") == "Druid" and GetShapeshiftForm() == 1) then
		avoi = format(two_fp, GetDodgeChance() + 5 + 1/(0.0625 + 0.956/(GetCombatRating(CR_DEFENSE_SKILL)/4.91850*0.04)))
	else
		if (GetCombatRating(2) == 0) then
			avoi = format(two_fp, GetDodgeChance() + GetParryChance() + 5 + 1/(0.0625 + 0.956/4.91850*0.04))
		else
			avoi = format(two_fp, GetDodgeChance() + GetParryChance() + 5 + 1/(0.0625 + 0.956/(GetCombatRating(2)/4.91850*0.04)))
		end
	end
	self.Avoi.text = avoi..L["AVOI"]
	self.Avoi.value = avoi	
end)
