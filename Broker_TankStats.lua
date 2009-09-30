local TS = CreateFrame("Frame", "Broker_TankStats")
local LDB = LibStub("LibDataBroker-1.1")
TS.Dodge = LDB:NewDataObject("Dodge", {text = "0%"..L["DODGE"], value = "0%", suffix = L["DODGE"]})
TS.Bock = LDB:NewDataObject("Block", {text = "0%"..L["BOCK"], value = "0%", suffix = L["BOCK"]})
TS.Parry = LDB:NewDataObject("Parry", {text = "0%"..L["PARRY"], value = "0%", suffix = L["PARRY"]})
TS.Def = LDB:NewDataObject("Defense", {text = "0"..L["DEF"], value = "0", suffix = L["DEF"]})
TS.Exp = LDB:NewDataObject("Expertise", {text = "0"..L["EXP"], value = "0", suffix = L["EXP"]})
TS.Avoi = LDB:NewDataObject("Avoidance", {text = "0%"..L["AVOI"], value = "0%", suffix = L["AVOI"]})
LDB = nil

local format = string.format
local player = "player"
local two_fp = "%.2f%%"
local single = "%d"
local two = "%.2f"

TS:RegisterEvent("UNIT_MODEL_CHANGED")
TS:RegisterEvent("PLAYER_LEVEL_UP")
TS:RegisterEvent("UNIT_AURA")
TS:RegisterEvent("PLAYER_LOGIN")

TS:SetScript("OnEvent", function(self, event, unit)
	if unit and unit ~= player then return end

	local dodge = format(two_fp, GetDodgeChance())
	self.Dodge.text = dodge..L["DODGE"]
	self.Dodge.value = dodge

	local bock = format(two_fp, GetBlockChance())
	self.Bock.text = bock..L["BOCK"]
	self.Bock.value = bock

	local parry = format(two_fp, GetParryChance())
	self.Parry.text = parry..L["PARRY"]
	self.Parry.value = parry

	local base, modifier = UnitDefense(player)
	local def = format(single, base+modifier)
	self.Def.text = def..L["DEF"]
	self.Def.value = def

	local Exp = format(single, GetCombatRating(24))
	self.Exp.text = Exp..L["EXP"]
	self.Exp.value = Exp
	
	local avoi = format(two_fp, GetDodgeChance() + GetParryChance() + 5 + 1/(0.0625 + 0.956/(GetCombatRating(CR_DEFENSE_SKILL)/4.91850*0.04)))
	self.Avoi.text = bock..L["AVOI"]
	self.Avoi.value = avoi	
end)
