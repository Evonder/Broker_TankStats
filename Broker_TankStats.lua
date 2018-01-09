local TS = CreateFrame("Frame", "Broker_TankStats")
local LDB = LibStub("LibDataBroker-1.1")
local L = L

local format = string.format
local player = "player"
local two_fp = "%.2f%%"
local single = "%d"
local two = "%.2f"
local dodge,block,parry,exp,avoid = 0

TS:RegisterEvent("UNIT_STATS")
TS:RegisterEvent("UNIT_MODEL_CHANGED")
TS:RegisterEvent("UNIT_INVENTORY_CHANGED")
TS:RegisterEvent("PLAYER_LEVEL_UP")
TS:RegisterEvent("UNIT_AURA")
TS:RegisterEvent("PLAYER_LOGIN")

TS:SetScript("OnEvent", function(self, event, unit)
	if (unit and unit ~= player) then return end
	strength = format(single, UnitStat("player", 1))
	dodge = format(two_fp, GetDodgeChance())
	block = format(two_fp, GetBlockChance())
	parry = format(two_fp, GetParryChance())
	haste = format(single, GetCombatRating(18))
	mastery = format(single, GetCombatRating(26))
	vers = format(single, GetCombatRating(29))
	crit = format(single, GetCombatRating(9))
	if (UnitClass("player") == "Druid" and GetShapeshiftForm() == 1 and UnitRace("player") == "Night Elf") then
		avoid =  format(two_fp, GetDodgeChance() + 7 + (GetCombatRatingBonus(CR_DEFENSE_SKILL) + 20)*0.04,1,0.5,0)
	else
		avoid = format(two_fp, GetDodgeChance() + 5 + (GetCombatRatingBonus(CR_DEFENSE_SKILL) + 20)*0.04,1,0.5,0)
	end
end)

if (LDB) then
	TSframe = CreateFrame("Frame", "LDB_TS")
	TSframe.obj = LDB:NewDataObject("TankStats", {
		type = "data source",
		icon = "Interface\\Icons\\Ability_Warrior_DefensiveStance",
		text = "TankStats",
		value = "TankStats",
		suffix = "SUFFIX",
		OnEnter = function(self)
			GameTooltip:SetOwner(self, "ANCHOR_NONE")
			GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMLEFT")
			GameTooltip:ClearLines()
			TF3Frame.obj.OnTooltipShow(GameTooltip)
			GameTooltip:Show()
		end,
		OnLeave = function(self)
			GameTooltip:Hide()
		end,
		OnTooltipShow = function(self)
			self:AddLine("Current TankStats")
			self:AddLine(" ")
			self:AddLine(L["STR"] .. ": " .. strength)
			self:AddLine(L["HASTE"] .. ": " .. haste)
			self:AddLine(L["MASTERY"] .. ": " .. mastery)
			self:AddLine(L["VERS"] .. ": " .. vers)
			self:AddLine(L["CRIT"] .. ": " .. crit)
			self:AddLine(L["AVOID"] .. ": " .. avoid)
			self:AddLine(" --- ")			
			self:AddLine(L["DODGE"] .. ": " .. dodge)
			self:AddLine(L["BLOCK"] .. ": " .. block)
			self:AddLine(L["PARRY"] .. ": " .. parry)
			self:AddLine(" ")
		end,
	})
end
