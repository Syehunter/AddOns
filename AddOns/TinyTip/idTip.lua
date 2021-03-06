-- Title: idTip
-- Version: 6.1.7
-- Author: Silverwind
if IsAddOnLoaded('idTip') then return; end

local hooksecurefunc, select, UnitBuff, UnitDebuff, UnitAura, UnitGUID, GetGlyphSocketInfo, tonumber, strfind =
      hooksecurefunc, select, UnitBuff, UnitDebuff, UnitAura, UnitGUID, GetGlyphSocketInfo, tonumber, strfind

local types = {
    spell       = EX_XCLSALERT_SPELL or "SpellID:",
    item        = "ID:",
    glyph       = "ID:",
    unit        = "ID:",
    quest       = "ID:",
    talent      = "ID:",
    achievement = "ID:",
    ability     = "ID:"
}

local function addLine(tooltip, id, type)
    local found = false
	if dwGetCVar("TinyTip", "TINYTIP_ID") ~= 1 then return; end
    -- Check if we already added to this tooltip. Happens on the talent frame
    for i = 1,15 do
        local frame = _G[tooltip:GetName() .. "TextLeft" .. i]
        local text
        if frame then text = frame:GetText() end
        if text and text == type then found = true break end
    end
	
	if EX_XCLSALERT_SPELL and type == types.spell then return; end
	if not EX_XCLSALERT_SPELL then types.spell = "ID:"; end
	
    if not found then
        tooltip:AddDoubleLine(type, "|cffffffff" .. id)
        tooltip:Show()
    end
end

-- All types, primarily for linked tooltips
local function onSetHyperlink(self, link)
    local type, id = string.match(link,"^(%a+):(%d+)")
    if not type or not id then return end
    if type == "spell" or type == "enchant" or type == "trade" then
        addLine(self, id, types.spell)
    elseif type == "glyph" then
        addLine(self, id, types.glyph)
    elseif type == "talent" then
        addLine(self, id, types.talent)
    elseif type == "quest" then
        addLine(self, id, types.quest)
    elseif type == "achievement" then
        addLine(self, id, types.achievement)
    elseif type == "item" then
        addLine(self, id, types.item)
    end
end

hooksecurefunc(ItemRefTooltip, "SetHyperlink", onSetHyperlink)
hooksecurefunc(GameTooltip, "SetHyperlink", onSetHyperlink)

-- Spells
hooksecurefunc(GameTooltip, "SetUnitBuff", function(self, ...)
    local id = select(11, UnitBuff(...))
    if id then addLine(self, id, types.spell) end
end)

hooksecurefunc(GameTooltip, "SetUnitDebuff", function(self,...)
    local id = select(11, UnitDebuff(...))
    if id then addLine(self, id, types.spell) end
end)

hooksecurefunc(GameTooltip, "SetUnitAura", function(self,...)
    local id = select(11, UnitAura(...))
    if id then addLine(self, id, types.spell) end
end)

hooksecurefunc("SetItemRef", function(link, ...)
    local id = tonumber(link:match("spell:(%d+)"))
    if id then addLine(ItemRefTooltip, id, types.spell) end
end)

GameTooltip:HookScript("OnTooltipSetSpell", function(self)
    local id = select(3, self:GetSpell())
    if id then addLine(self, id, types.spell) end
end)

-- NPCs
GameTooltip:HookScript("OnTooltipSetUnit", function(self)
    if C_PetBattles.IsInBattle() then return end
    local unit = select(2, self:GetUnit())
    if unit then
        local guid = UnitGUID(unit) or ""
        local id   = tonumber(guid:match("-(%d+)-%x+$"), 10)
        if id and guid:match("%a+") ~= "Player" then addLine(GameTooltip, id, types.unit) end
    end
end)

-- Items
local function attachItemTooltip(self)
    local link = select(2, self:GetItem())
    if link then
        local id = select(3, strfind(link, "^|%x+|Hitem:(%-?%d+):(%d+):(%d+).*"))
        if id then addLine(self, id, types.item) end
    end
end

GameTooltip:HookScript("OnTooltipSetItem", attachItemTooltip)
ItemRefTooltip:HookScript("OnTooltipSetItem", attachItemTooltip)
ItemRefShoppingTooltip1:HookScript("OnTooltipSetItem", attachItemTooltip)
ItemRefShoppingTooltip2:HookScript("OnTooltipSetItem", attachItemTooltip)
ShoppingTooltip1:HookScript("OnTooltipSetItem", attachItemTooltip)
ShoppingTooltip2:HookScript("OnTooltipSetItem", attachItemTooltip)

-- Glyphs
hooksecurefunc(GameTooltip, "SetGlyph", function(self, ...)
    local id = select(4, GetGlyphSocketInfo(...))
    if id then addLine(self, id, types.glyph) end
end)

hooksecurefunc(GameTooltip, "SetGlyphByID", function(self, id)
    if id then addLine(self, id, types.glyph) end
end)

-- Achievement Frame Tooltips
local f = CreateFrame("frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(_, _, what)
    if what == "Blizzard_AchievementUI" then
        for i,button in ipairs(AchievementFrameAchievementsContainer.buttons) do
            button:HookScript("OnEnter", function()
                GameTooltip:SetOwner(button, "ANCHOR_NONE")
                GameTooltip:SetPoint("TOPLEFT", button, "TOPRIGHT", 0, 0)
                addLine(GameTooltip, button.id, types.achievement)
                GameTooltip:Show()
            end)
            button:HookScript("OnLeave", function()
                GameTooltip:Hide()
            end)
        end
    end
end)

-- Pet battle buttons
hooksecurefunc("PetBattleAbilityButton_OnEnter", function(self)
    local petIndex = C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY);
    if ( self:GetEffectiveAlpha() > 0 ) then
        local id = select(1, C_PetBattles.GetAbilityInfo(LE_BATTLE_PET_ALLY, petIndex, self:GetID()));
        if id then
            local oldText = PetBattlePrimaryAbilityTooltip.Description:GetText(id);
            PetBattlePrimaryAbilityTooltip.Description:SetText(oldText .. "\r\r" .. types.ability .. "|cffffffff " .. id .. "|r")
        end
    end
end)

-- Pet battle auras
hooksecurefunc("PetBattleAura_OnEnter", function(self)
    local parent = self:GetParent();
    local id = select(1, C_PetBattles.GetAuraInfo(parent.petOwner, parent.petIndex, self.auraIndex))
    if id then
        local oldText = PetBattlePrimaryAbilityTooltip.Description:GetText(id);
        PetBattlePrimaryAbilityTooltip.Description:SetText(oldText .. "\r\r" .. types.ability .. "|cffffffff " .. id .. "|r")
    end
end)