------------------------------------------------------------------------------------------
-- AspectPosionBar ver 3.0
-- 日期: 2010-4-30 (2010-6-15)
-- 作者: dugu@bgifoot
-- 描述: 猎人守护动作条\盗贼的姿态条 + 毒药条\法师传送条
-- 版权所有 (c) duowan@com
------------------------------------------------------------------------------------------
AspectPosionBarFrame = LibStub("AceAddon-3.0"):NewAddon("AspectPosionBarFrame",  "AceEvent-3.0", "AceHook-3.0");
local L = {};
local A = AspectPosionBarFrame;
A._DEBUG = false;
A.name = "AspectPosionBar";
A.class = select(2, UnitClass("player"));
A.enable = true;
A.enablePos = true;
A.cacheY = 0;
local NUM_STANCE_SLOTS = 10;

if (GetLocale() == "zhCN") then
	L["左键 - 上毒主手"] = "左键 - 主手上毒";
	L["中键 - 上毒投掷"] = "中键 - 投掷上毒";
	L["右键 - 上毒副手"] = "右键 - 副手上毒";
	L["麻醉药膏"] = "麻醉药膏";
	L["速效药膏"] = "速效药膏";
	L["致伤药膏"] = "致伤药膏";
	L["致命药膏"] = "致命药膏";
	L["麻痹药膏"] = "麻痹药膏";
	L["减速药膏"] = "减速药膏";

	L["阿什兰"] = "阿什兰";
	L["埃索达"] = "埃索达";
	L["塞拉摩"] = "塞拉摩";
	L["奥格瑞玛"] = "奥格瑞玛";
	L["幽暗城"] = "幽暗城";
	L["斯通纳德"] = "斯通纳德";
	L["暴风城"] = "暴风城";
	L["沙塔斯"] = "沙塔斯";
	L["达拉然"] = "达拉然";
	L["达纳苏斯"] = "达纳苏斯";
	L["铁炉堡"] = "铁炉堡";
	L["银月城"] = "银月城";
	L["雷霆崖"] = "雷霆崖";
	L["托巴拉德"] = "托尔巴拉德";
	L["锦绣谷"] = "锦绣谷";
	L["暴风之盾"] = "暴风之盾";
	L["战争之矛"] = "战争之矛";
	L["传送门: "] = "传送门：";
	L["传送: "] = "传送：";
	L["左键 - 传送: "] = "左键 - 传送: ";
	L["右键 - 传送门: "] = "右键 - 传送门: ";
	L["恶魔支配"] = "恶魔支配";
	L["左键 - 普通召唤"] = "左键 - 普通召唤";
	L["右键 - 快速召唤"] = "右键 - 快速召唤";
	
	_G["BINDING_HEADER_ASPECTBAR"] = "职业守护条";
	for i = 1, 10 do
		_G["BINDING_NAME_CLICK AspectPosionBarButton".. i .. ":LeftButton"]  =  format("动作键%d", i);
	end
elseif (GetLocale() == "zhTW") then
	L["左键 - 上毒主手"] = "左鍵 - 主手上毒";
	L["中键 - 上毒投掷"] = "中键 - 投掷上毒";
	L["右键 - 上毒副手"] = "右鍵 - 副手上毒";	
	L["麻醉药膏"] = "麻醉毒藥";
	L["速效药膏"] = "速效毒藥";
	L["致伤药膏"] = "致傷毒藥";
	L["致命药膏"] = "致命毒藥";
	L["麻痹药膏"] = "麻痹毒藥";
	L["减速药膏"] = "致殘毒藥";

	L["阿什兰"] = "阿什蘭";
	L["埃索达"] = "艾克索達";
	L["塞拉摩"] = "塞拉摩";
	L["奥格瑞玛"] = "奧格瑪";
	L["幽暗城"] = "幽暗城";
	L["斯通纳德"] = "斯通納德";
	L["暴风城"] = "暴風城";
	L["沙塔斯"] = "撒塔斯";
	L["达拉然"] = "達拉然";
	L["达纳苏斯"] = "達納蘇斯";
	L["铁炉堡"] = "鐵爐堡";
	L["银月城"] = "銀月城";
	L["雷霆崖"] = "雷霆崖";
	L["托巴拉德"] = "托巴拉德";
	L["锦绣谷"] = "锦绣谷";
	L["暴风之盾"] = "暴風之盾";
	L["战争之矛"] = "戰爭之矛";
	L["传送门: "] = "傳送門:";
	L["传送: "] = "傳送:";
	L["左键 - 传送: "] = "左鍵 - 傳送:";
	L["右键 - 传送门: "] = "右鍵 - 傳送門:";
	L["恶魔支配"] = "惡魔支配";
	L["左键 - 普通召唤"] = "左鍵 - 普通召喚";
	L["右键 - 快速召唤"] = "右鍵 - 快速召喚";

	_G["BINDING_HEADER_ASPECTBAR"] = "職業守護條";
	for i = 1, 10 do
		_G["BINDING_NAME_CLICK AspectPosionBarButton".. i .. ":LeftButton"]  =  format("動作鍵%d", i);
	end	
else
	L["左键 - 上毒主手"] = "左键 - 主手上毒";
	L["中键 - 上毒投掷"] = "中键 - 投掷上毒";
	L["右键 - 上毒副手"] = "右键 - 副手上毒";	
	L["麻醉药膏"] = "Anesthetic Poison";
	L["速效药膏"] = "Instant Poison";
	L["致伤药膏"] = "Wound Poison";
	L["致命药膏"] = "Deadly Poison";
	L["麻痹药膏"] = "Mind-numbing Poison";
	L["减速药膏"] = "Crippling Poison";

	L["埃索达"] = "埃索达";
	L["塞拉摩"] = "塞拉摩";
	L["奥格瑞玛"] = "奥格瑞玛";
	L["幽暗城"] = "幽暗城";
	L["斯通纳德"] = "斯通纳德";
	L["暴风城"] = "暴风城";
	L["沙塔斯"] = "撒塔斯";
	L["达拉然"] = "達拉然";
	L["达纳苏斯"] = "达纳苏斯";
	L["铁炉堡"] = "铁炉堡";
	L["银月城"] = "银月城";
	L["雷霆崖"] = "雷霆崖";
	L["暴风之盾"] = "暴风之盾";
	L["托巴拉德"] = "托尔巴拉德";
	L["锦绣谷"] = "锦绣谷";
	L["传送门: "] = "传送门：";
	L["传送: "] = "传送：";
	L["左键 - 传送: "] = "左键 - 传送: ";
	L["右键 - 传送门: "] = "右键 - 传送门: ";
	L["恶魔支配"] = "Fel Domination";
	L["左键 - 普通召唤"] = "左键 - 普通召唤";
	L["右键 - 快速召唤"] = "右键 - 快速召唤";

	_G["BINDING_HEADER_DUOWANBAR"] = "Class ActionBar";
	for i = 1, 10 do
		_G["BINDING_NAME_CLICK AspectPosionBarButton".. i .. ":LeftButton"] =  format("Action Button %d", i);
	end
end

A.spellsDB = {
	["HUNTER"] = {
		[1] = 5118,		-- 猎豹守护
		[2] = 13159,		-- 豹群守护
		[3] = 172106, --灵狐守护
	},
	["ROGUE"] = {
		[1] = 1784,		-- 潜行
		[2] = 51713,		-- 暗影之舞
		-- 毒药(itemID可能获取不到信息...)
		[3] = 2823,--{t = "p", name = L["致命毒药"]},
		[4] = 157584,--{t = "p", name = L["速效药膏"]},
		[5] = 8679,--{t = "p", name = L["致伤药膏"]},
		[6] = 3408,--{t = "p", name = L["减速药膏"]},	
		[7] = 108211,--{t = "p", name = L["吸血药膏"]},
	},
	["MAGE"] = {
		[1] = {t = "d", name = L["埃索达"]},
		[2] = {t = "d", name = L["塞拉摩"]},
		[3] = {t = "d", name = L["奥格瑞玛"]},
		[4] = {t = "d", name = L["幽暗城"]},
		[5] = {t = "d", name = L["斯通纳德"]},
		[6] = {t = "d", name = L["暴风城"]},
		[7] = {t = "d", name = L["沙塔斯"]},
		[8] = {t = "d", name = L["达拉然"]},
		[9] = {t = "d", name = L["达纳苏斯"]},
		[10] = {t = "d", name = L["铁炉堡"]},	
		[11] = {t = "d", name = L["银月城"]},
		[12] = {t = "d", name = L["雷霆崖"]},
		[13] = {t = "d", name=L["托巴拉德"]},
		[14] = {t = "d", name=L["锦绣谷"]},
		[15] = {t = "d", name=L["阿什兰"]},
		[16] = {t = "d", name=L["暴风之盾"]},
		[17] = {t = "d", name=L["战争之矛"]},
	},
	["WARLOCK"] = {
		[1] = 103958,	-- 恶魔变形
		[2] = 688,		-- 召唤小鬼
		[3] = 697,		-- 召唤虚空领主
		[4] = 712,		-- 召唤破坏魔
		[5] = 691,		-- 召唤眼魔
		[6] = 30146,	-- 召唤恶魔卫士
		[7] = 1122,		-- 召唤地狱火
		[8] = 18540,	-- 召唤末日守卫
		[9] = 112921,	-- 召唤深渊魔
		[10] = 112927,	-- 召唤恐惧卫士
	},
};

A.CastableSpells = {
	[51713] = true,
	[1787] = true,
	[61610] = true,
};

A.SoulStonNum = {
	[697] = true,
	[712] = true,
	[691] = true,
	[30146] = true,
	[1122] = true,
	[18540] = true,
};

A.ROMAN = {" IX", " VIII", " VII", " VI", " V",  " IV", " III", " II", ""};
A.order = {"spells", "teleport", "items"};
A.actions = {
	spells = {};
	teleport = {};
	items = {};
};
A.tmp = {
	spells = {};
	teleport = {};
	items = {};
};
A.buttons = {};
A.hooks = {};
A.hooked = false;
A.loaded = false;

function A:debug(fmt, ...)
	if (self._DEBUG) then
		print(format(fmt, ...));
	end	
end

function AspectPosionButton_OnLoad(self)
	self:SetNormalTexture("");
	self:RegisterForClicks("AnyUp");	
	self.cooldown = _G[self:GetName() .. "Cooldown"];
	self.icon = _G[self:GetName() .. "Icon"];
	self.spellID = -1;
end

function AspectPosionButton_OnEnter(self)
	if ( GetCVar("UberTooltips") == "1" ) then
		GameTooltip_SetDefaultAnchor(GameTooltip, self);
	else
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	end
	local link, isItem, isSummon;
	if (self:GetAttribute("type") == "macro") then
		if (select(2, UnitClass("player")) == "WARLOCK" and self.spellID ~= 61610) then
			isSummon = true;			
		else
			if (self.spellID) then
				link = GetSpellLink(self.spellID);
			end
		end
	elseif (self:GetAttribute("type") == "spell") then
		if (self.teleportID) then
			isteleport = true;
		elseif (self.spellID) then
			link = GetSpellLink(self.spellID);
		end
	elseif (self:GetAttribute("type") == "item" and self.itemID) then
		-- _, link = GetItemInfo(self.itemID);
		isItem = true;
	end
	if (link) then
		GameTooltip:SetHyperlink(link);
	else
		GameTooltip:SetText(self.spellName);
		if (isItem) then
			GameTooltip:AddLine(L["左键 - 上毒主手"], 0.7, 0.7, 0.7);
			GameTooltip:AddLine(L["右键 - 上毒副手"], 0.7, 0.7, 0.7);
			GameTooltip:AddLine(L["中键 - 上毒投掷"], 0.7, 0.7, 0.7);
		elseif (isteleport) then					
			GameTooltip:AddLine(L["左键 - 传送: "] .. self.spellName, 0.7, 0.7, 0.7);
			GameTooltip:AddLine(L["右键 - 传送门: "] .. self.spellName, 0.7, 0.7, 0.7);
		elseif	(isSummon) then
			GameTooltip:AddLine(L["左键 - 普通召唤"], 0.7, 0.7, 0.7);
			GameTooltip:AddLine(L["右键 - 快速召唤"], 0.7, 0.7, 0.7);
		end
	end
	
	GameTooltip:Show();
end

function AspectPosionButton_PostClick(self)
	if (self.isActive) then
		self:SetChecked(true);
	else
		self:SetChecked(false);
	end
end

function A:CreateButton(index)
	if (index <= NUM_STANCE_SLOTS) then
		local button = _G["AspectPosionBarButton" .. index];
		return button;
	end
	return false;
end

function A:CheckSpell(spellID)
	if spellID == "传送 :托尔巴拉德" then
		spellID = 88344;
	end
	--[[
	local i = 1;
	local spell = GetSpellInfo(spellID);
	local spellName = GetSpellBookItemName(i, BOOKTYPE_SPELL);
	while (spellName) do
		if (spellName == spell) then
			return true;
		end
		i = i + 1;
		spellName = GetSpellBookItemName(i, BOOKTYPE_SPELL);
	end
	]]
	local spellLink = GetSpellLink(spellID);
	spellID = spellLink and strmatch(spellLink, "spell:(%d*)");
	return spellID and IsSpellKnown(spellID);
end

function A:CheckItem(itemName)
	local id;
	if (itemName) then			
		local count = GetItemCount(itemName);
		if (count and count >= 0) then
			return true, itemName;
		end
	end	
	return false;
end

function A:hasNewSpell()
	if (#(self.actions) ~= #(self.tmp) or #(self.actions.spells) ~= #(self.tmp.spells) or #(self.actions.teleport) ~= #(self.tmp.teleport) or #(self.actions.items) ~= #(self.tmp.items)) then
		return true;
	end
	return false;
end

function A:CloneTable(t)
	assert(t and type(t) == "table", "CloneTable #! param must be a table value");
	local tmp = {};
	for k, v in pairs(t) do
		if (type(v) == "table") then
			tmp[k] = self:CloneTable(v);
		else
			tmp[k] = v;
		end
	end
	return tmp;
end

function A:UpdateAspect()
	self.tmp.spells = {};
	self.tmp.teleport = {};
	self.tmp.items = {};	
	if (self.spellsDB[self.class]) then
		for i, spellID in ipairs(self.spellsDB[self.class]) do
			if (type(spellID) == "table") then				
				if (spellID.t and spellID.t == "p") then		-- 毒药
					local hasItem, name = self:CheckItem(spellID.name)
					if (hasItem) then
						tinsert(self.tmp.items, name);
					end
				elseif (spellID.t and spellID.t == "d") then	-- 传送门
					local check1, check2 = self:CheckSpell(L["传送门: "] .. spellID.name), self:CheckSpell(L["传送: "] .. spellID.name);
					--if (spellID.name == L["托巴拉德"]) then
					--	check2 = check1;						
					--end
					if (check1 or check2) then
						tinsert(self.tmp.teleport, spellID.name);
					end
				end
			else
				if (self:CheckSpell(spellID)) then
					tinsert(self.tmp.spells, spellID);	
				end
			end
		end	
	end

	if (self:hasNewSpell()) then
		self.actions = self:CloneTable(self.tmp);
		return true;
	end

	return false;
end

function A:CreateBar()
	for i = 1, NUM_STANCE_SLOTS do
		A.buttons[i] = self:CreateButton(i);
	end
end

function A:GetNumShapeshiftForms()
	local num = #(self.actions.spells) + #(self.actions.items) + #(self.actions.teleport);
	num = (num > 0 and num) or GetNumShapeshiftForms() or 0;
	if (num > NUM_STANCE_SLOTS) then
		num = NUM_STANCE_SLOTS;	-- 猜测有错误
	end

	return tonumber(num);
end

function A:IsBuffActive(name)
	local i = 1;
	local buffName = UnitBuff("player", i);
	while (buffName) do
		if (buffName == name) then
			return i;
		end
		i = i +1;
		buffName = UnitBuff("player", i);
	end

	return false;	
end

function A:GetShapeshiftFormInfo(buttonId)
	local isActive, isCastable, name, _, texture, type, spellID;	
	local sn = #(self.actions.spells)
	local tn = #(self.actions.teleport);
	
	if (self.actions["spells"][buttonId]) then		
		name, _, texture = GetSpellInfo(self.actions.spells[buttonId]);
		isActive = self:IsBuffActive(name);
		if (self.CastableSpells[self.actions.spells[buttonId]] and GetShapeshiftFormInfo(buttonId)) then
			texture, name, isActive, isCastable = GetShapeshiftFormInfo(buttonId);
		else
			isCastable = true;
		end	

		spellID = self.actions.spells[buttonId];
		type = "spell";
	elseif (self.actions["teleport"][buttonId - sn]) then
		_, _, texture = GetSpellInfo(L["传送: "] .. self.actions.teleport[buttonId - sn]);
		texture = texture or select(3,GetSpellInfo(L["传送门: "] .. self.actions.teleport[buttonId - sn]));
		name = self.actions.teleport[buttonId - sn];
		isActive = false;
		isCastable = true;
		type = "teleport";
	elseif (self.actions["items"][buttonId - sn - tn]) then
		name, _, _, _, _, _, _, _, _, texture = GetItemInfo(self.actions.items[buttonId - sn - tn]);
		isActive = false;
		isCastable = true;
		type = "item";		
	end

	if (not texture) then
		texture, name, isActive, isCastable = GetShapeshiftFormInfo(buttonId);
	end
	
	--self:debug("texture: %s name: %s", texture, name);	
	return texture, name, isActive, isCastable, type, spellID;
end

function A:GetShapeshiftForm(var)
	local texture, name, isActive, isCastable;
	for i=1, NUM_STANCE_SLOTS, 1 do
		texture, name, isActive, isCastable = self:GetShapeshiftFormInfo(i);
		if (isActive) then
			return i;
		end
	end
end

local function GetItemCooldown(item)
	local name, link = GetItemInfo(item);	
	local itemID = name and strmatch(link, "|c%x+|Hitem:(%d+):") or nil;
	if (itemID) then
		return _G.GetItemCooldown(itemID);
	end
end

function A:GetShapeshiftFormCooldown(buttonId)
	local sn = #(self.actions.spells);
	local tn = #(self.actions.teleport);
	if (self.actions.spells and self.actions.spells[buttonId]) then
		local name = GetSpellInfo(self.actions.spells[buttonId]);
		return GetSpellCooldown(name);
	elseif (self.actions.teleport and self.actions.teleport[buttonId - sn]) then
		local name = GetSpellInfo(self.actions.teleport[buttonId - sn]);
		return 0;	-- GetSpellCooldown(name, BOOKTYPE_SPELL);
	elseif (self.actions.items and self.actions.items[buttonId - sn - tn]) then
		return GetItemCooldown(self.actions.items[buttonId - sn - tn]);
	end

	return GetShapeshiftFormCooldown(buttonId);	
end

function A:UpdateAspectCooldown()
	local numForms = self:GetNumShapeshiftForms();
	local start, duration, enable, cooldown, button;
	for i=1, numForms do
		button = self.buttons[i];
		cooldown = _G[button:GetName() .. "Cooldown"];
		start, duration, enable = self:GetShapeshiftFormCooldown(i);
		if (cooldown and start and duration) then
			CooldownFrame_SetTimer(cooldown, start, duration, enable);
		end
	end
end

function A:AspectBarUpdate()	
	local needSecureCall = false;
	local numForms = self:GetNumShapeshiftForms();
	if (numForms > 0) then
		if ( numForms == 1 ) then
			AspectPosionBarMiddle:Hide();
			AspectPosionBarRight:SetPoint("LEFT", "AspectPosionBarLeft", "LEFT", 12, 0);
			if (self.enablePos) then
				if (InCombatLockdown()) then
					needSecureCall = true;
				else
					AspectPosionBarButton1:ClearAllPoints();
					AspectPosionBarButton1:SetPoint("BOTTOMLEFT", "AspectPosionBar", "BOTTOMLEFT", 12, 3);	
					needSecureCall = false;
				end				
			end			
		elseif ( numForms == 2 ) then
			AspectPosionBarMiddle:Hide();
			AspectPosionBarRight:SetPoint("LEFT", "AspectPosionBarLeft", "RIGHT", 0, 0);
		else
			AspectPosionBarMiddle:Show();
			AspectPosionBarMiddle:SetPoint("LEFT", "AspectPosionBarLeft", "RIGHT", 0, 0);
			AspectPosionBarMiddle:SetWidth(37 * (numForms-2));
			AspectPosionBarMiddle:SetTexCoord(0, numForms-2, 0, 1);
			AspectPosionBarRight:SetPoint("LEFT", "AspectPosionBarMiddle", "RIGHT", 0, 0);
		end
		if (InCombatLockdown()) then
			needSecureCall = true;
		else
			AspectPosionBar:Show();
			needSecureCall = false;
		end
	else
		if (InCombatLockdown()) then
			needSecureCall = true;
		else
			AspectPosionBar:Hide();
			needSecureCall = false;
		end
	end
	
	self:AspectBarUpdateState();
	if (needSecureCall) then
		dwSecureCall(self.AspectBarUpdate, self);
	end
end

function A:AspectBarUpdateState()
	local needSecureCall = false;
	local numForms = self:GetNumShapeshiftForms();
	self:debug("number forms %d", numForms);
	local texture, name, isActive, isCastable, type;
	local button, icon, cooldown, ssb;
	local start, duration, enable;
	local sn = #(self.actions.spells);
	local tn = #(self.actions.teleport);
	
	for i=1, NUM_STANCE_SLOTS do
		button =self.buttons[i];		
		if ( i <= numForms ) then			
			texture, name, isActive, isCastable, type, spellID = self:GetShapeshiftFormInfo(i);		
			button.icon:SetTexture(texture);
			
			button.spellID = spellID;
			if ( texture ) then
				button.cooldown:Show();
			else
				button.cooldown:Hide();
			end
			self:UpdateAspectCooldown();
			
			if ( isActive ) then
				button:SetChecked(true);
				button.isActive = true;
			else
				button:SetChecked(false);
				button.isActive = false;
			end

			if ( isCastable ) then
				button.icon:SetVertexColor(1.0, 1.0, 1.0);
			else
				button.icon:SetVertexColor(0.4, 0.4, 0.4);
			end

			if (button.spellName ~= name) then
				if (InCombatLockdown()) then
					needSecureCall = true;
				else				
					if (type == "spell") then
						button:SetAttribute("type", "macro");
						if (select(2, UnitClass("player")) == "WARLOCK" and spellID ~= 61610) then
							button:SetAttribute("macrotext", "/cast [button:2]"..L["恶魔支配"].."\n/stopcasting\n/cast "..name);
						else							
							button:SetAttribute("macrotext", "/cast "..name);
						end
						
						button.spellID = self.actions.spells[i];
					elseif (type == "teleport") then
						button:SetAttribute("type", "spell");	
						--if (name == L["托巴拉德"]) then
						--	button:SetAttribute("spell1", 88344);
						--else
							button:SetAttribute("spell1", L["传送: "] .. name);
						--end					
						button:SetAttribute("spell2", L["传送门: "] .. name);
						button.teleportID = true;
					elseif (type == "item") then
						button:SetAttribute("type", "item");
						button:SetAttribute("item", name);
						button:SetAttribute("target-slot1", "16");
						button:SetAttribute("target-slot2", "17");
						button:SetAttribute("target-slot3", "18");
						button.itemID = self.actions.items[i - sn - tn];
					end

					button.spellName = name;
				end
			end
			if (not button:IsShown()) then
				if (InCombatLockdown()) then
					needSecureCall = true;
				else	
					button:Show();
					needSecureCall = false;
				end
			end			
		else
			if (button:IsShown()) then
				if (InCombatLockdown()) then
					needSecureCall = true;
				else
					button:Hide();
					needSecureCall = false;
				end
			end			
		end
	end

	self:UpdateItemCount();
	if (needSecureCall) then
		dwSecureCall(self.AspectBarUpdateState, self);
		return;
	end
	UIParent_ManageFramePositions();
end

function A:UpdateItemCount()
	local button, count, label;
	for i=1, NUM_STANCE_SLOTS do
		button =self.buttons[i];
		if (button:IsShown() and (button:GetAttribute("type") == "item"--[[ or (button.spellID and self.SoulStonNum[button.spellID])]])) then
			label = _G[button:GetName() .. "Count"];
			if (button:GetAttribute("type") == "item") then
				count = GetItemCount(button:GetAttribute("item"));
				if (count > 9) then
					label:SetTextColor(0.0, 1.0, 0.0)
				elseif (count > 4) then
					label:SetTextColor(1.0, 1.0, 0.0)
				elseif (count > 0) then
					label:SetTextColor(1.0, 0.0, 0.0)
				end
			else
				count = GetItemCount(6265);	-- 灵魂碎片
				label:SetTextColor(1.0, 1.0, 1.0)
			end			
			
			label:SetText(count);			
		end
	end
end

function A:UNIT_AURA(event, unit)
	if (unit == "player") then
		self:AspectBarUpdate();
	end	
end

function A:LEARNED_SPELL_IN_TAB()
	if (self:UpdateAspect()) then
		self:AspectBarUpdate();
		RePositionPetActionBar();
	end
end

function A:ACTIONBAR_UPDATE_USABLE()
	self:AspectBarUpdate();
end

function A:ACTIONBAR_UPDATE_COOLDOWN()
	self:UpdateAspectCooldown();
end

function A:UPDATE_BINDINGS()
	if (InCombatLockdown()) then
		dwSecureCall(self.UPDATE_BINDINGS, self);
		return;
	end
	local numForms = self:GetNumShapeshiftForms();
	--ClearOverrideBindings(ShapeshiftBarFrame);
	for i = 1, numForms do
		local buttonName = "AspectPosionBarButton" .. i;
		local key1, key2 = GetBindingKey("SHAPESHIFTBUTTON"..i);
		if (key1) then
			SetOverrideBindingClick(AspectPosionBar, true, key1, buttonName);
		end
		if (key2) then
			SetOverrideBindingClick(AspectPosionBar, true, key2, buttonName);
		end
	end
	self:UnregisterEvent("UPDATE_BINDINGS");
end

function A:SPELLS_CHANGED()
	if (self:UpdateAspect()) then
		self:AspectBarUpdate();
		RePositionPetActionBar();
	end
	self:UnregisterEvent("SPELLS_CHANGED");
end

function A:PLAYER_SPECIALIZATION_CHANGED()
	if (self:UpdateAspect()) then
		self:AspectBarUpdate();
		RePositionPetActionBar();
	end
end

function A:BAG_UPDATE()
	if (self:UpdateAspect()) then
		self:AspectBarUpdate();
		RePositionPetActionBar();
	else
		self:UpdateItemCount();
	end
end

function A:PLAYER_ENTERING_WORLD()
	self:AspectBarUpdate();
end

-----------------------------------------
--	OnX
-----------------------------------------
local HideFrame = CreateFrame("Frame", "AspectPositionHideFrame", UIParnet);
HideFrame:Hide();

function A:OnModuleEnable()
	self:RegisterEvent("UNIT_AURA");	
	self:RegisterEvent("SPELLS_CHANGED");
	self:RegisterEvent("LEARNED_SPELL_IN_TAB");
	self:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED");
	self:RegisterEvent("ACTIONBAR_UPDATE_USABLE");
	self:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN");
	self:RegisterEvent("UPDATE_BINDINGS");
	self:RegisterEvent("BAG_UPDATE");
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	StanceBarFrame:SetParent(HideFrame);
	self.enable = true;
	RegisterStateDriver(AspectPosionBar, "visibility", "[target=vehicle,exists]hide;[overridebar]hide;[petbattle]hide;show");
	self:AspectBarUpdate();
	self:SecureHook("UIParent_ManageFramePositions");
end

function A:OnModuleDisable()	
	self:UnregisterAllEvents();
	self:AspectBarUpdate();
	StanceBarFrame:SetParent(MainMenuBar);
	RegisterStateDriver(AspectPosionBar, "visibility", "hide");
	--dwSecureCall(AspectPosionBar.Hide, AspectPosionBar);
	StanceBar_Update();
	self.enable = false;
	self:Unhook("UIParent_ManageFramePositions");
end

function A:UIParent_ManageFramePositions()
	if (not self.enablePos) then return end

	local hasBottomLeft;
	
	if ( MultiBarBottomLeft:IsShown() ) then			
		hasBottomLeft = 1;
	end
	local YOffset = hasBottomLeft and 42 or 0;
	if ( ReputationWatchBar:IsShown() and MainMenuExpBar:IsShown() ) then
		YOffset = YOffset + 10;
	end
	if ( MainMenuBarMaxLevelBar:IsShown() ) then
		YOffset = YOffset + 1;
	end
	if ( hasBottomLeft  or (AspectPosionBar:GetBottom() > MultiBarBottomLeft:GetTop()) or self:GetNumShapeshiftForms() <= 0 ) then		
		if ( AspectPosionBar ) then
			AspectPosionBarLeft:SetAlpha(0);
			AspectPosionBarRight:SetAlpha(0);
			AspectPosionBarMiddle:SetAlpha(0);
		end
	else
		if ( AspectPosionBar ) then
			if ( self:GetNumShapeshiftForms() > 2 ) then
				AspectPosionBarMiddle:SetAlpha(1);
			end
			AspectPosionBarLeft:SetAlpha(1);
			AspectPosionBarRight:SetAlpha(1);
		end
	end

	if (InCombatLockdown()) then
		dwSecureCall(UIParent_ManageFramePositions);
		return;
	end
	self.cacheY = YOffset;
	AspectPosionBar:ClearAllPoints();
	if (IsPossessBarVisible()) then			
		AspectPosionBar:SetPoint("BOTTOMLEFT", "PossessButton2", "TOPLEFT", 30, YOffset);	
	else
		AspectPosionBar:SetPoint("BOTTOMLEFT", "MainMenuBar", "TOPLEFT", 30, YOffset);	
	end	
end

function A:ToggleManageFrame(switch)
	if (switch) then
		self.enablePos = true;
	else
		self.enablePos = false;	
	end
end

function A:OnInitialize()
	if (not self.loaded) then
		self.loaded = true;
		self:UpdateAspect();
		self:CreateBar();
	end
end

function AspectPosionBar_OnLoad(self)
	
end

function AspectPosionBar_OnEvent(self, event, arg1)
	
end

function AspectPosionBar_OnShow(self)
	dwSecureCall(UIParent_ManageFramePositions);
end

function AspectPosionBar_OnHide(self)
	dwSecureCall(UIParent_ManageFramePositions);
end

function AspectPosionBar_Toggle(switch)
	if (switch) then
		A:OnModuleEnable();
	else		
		A:OnModuleDisable();
	end
	dwSecureCall(UIParent_ManageFramePositions);
end

function AspectPosionBar_Jieguan(switch)
	if (InCombatLockdown()) then
		dwSecureCall(AspectPosionBar_Jieguan, switch);
		return;
	end
	local apb, ssb, la;
	for i=1, NUM_STANCE_SLOTS do
		apb = _G["AspectPosionBarButton" .. i];
		ssb = _G["StanceButton" .. i];
		if (switch) then
			if (i == 1) then
				apb:ClearAllPoints();
				apb:SetPoint("TOPLEFT", ssb, "TOPLEFT", 0, 0);
			end
		else
			apb:ClearAllPoints();
			if (i == 1) then
				apb:SetPoint("BOTTOMLEFT", AspectPosionBar, "BOTTOMLEFT", 10, 3);
			else				
				apb:SetPoint("LEFT", la, "RIGHT", 8, 0);
			end
			la = apb;
		end
		
	end

	if (switch) then	
		AspectPosionBarFrame:ToggleManageFrame(false);
	else
		AspectPosionBarFrame:ToggleManageFrame(true);
	end
	UIParent_ManageFramePositions();
end
