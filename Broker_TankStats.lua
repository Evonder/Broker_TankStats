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
	dodge = format(two_fp, GetDodgeChance())
	block = format(two_fp, GetBlockChance())
	parry = format(two_fp, GetParryChance())
	exp = format(single, GetCombatRating(24))
	if (UnitClass("player") == "Druid" and GetShapeshiftForm() == 1 and UnitRace("player") == "Night Elf") then
		avoid =  format(two_fp, GetDodgeChance() + 7 + 1/(0.0625 + 0.956/(GetCombatRating(CR_DEFENSE_SKILL)/4.91850*0.04)))
	elseif (UnitClass("player") == "Druid" and GetShapeshiftForm() == 1) then
		avoid = format(two_fp, GetDodgeChance() + 5 + 1/(0.0625 + 0.956/(GetCombatRating(CR_DEFENSE_SKILL)/4.91850*0.04)))
	else
		if (GetCombatRating(2) == 0) then
			avoid = format(two_fp, GetDodgeChance() + GetParryChance() + 5 + 1/(0.0625 + 0.956/4.91850*0.04))
		else
			avoid = format(two_fp, GetDodgeChance() + GetParryChance() + 5 + 1/(0.0625 + 0.956/(GetCombatRating(2)/4.91850*0.04)))
		end
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
			self:AddLine(L["DODGE"] .. ": " .. dodge)
			self:AddLine(L["BLOCK"] .. ": " .. block)
			self:AddLine(L["PARRY"] .. ": " .. parry)
			self:AddLine(L["EXP"] .. ": " .. exp)
			self:AddLine(L["AVOID"] .. ": " .. avoid)
			self:AddLine(" ")
		end,
	})
end
