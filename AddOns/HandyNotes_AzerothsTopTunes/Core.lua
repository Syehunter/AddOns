﻿
------------------------------------------
--  This addon was heavily inspired by  --
--    HandyNotes_Lorewalkers            --
--    HandyNotes_LostAndFound           --
--  by Kemayo                           --
------------------------------------------


-- declaration
local _, AzerothsTopTunes = ...
AzerothsTopTunes.points = {}


-- our db and defaults
local db
local defaults = { profile = { completed = false, icon_scale = 1.4, icon_alpha = 0.8 } }


-- upvalues
local _G = getfenv(0)

local GameTooltip = _G.GameTooltip
local GetQuestsCompleted = _G.GetQuestsCompleted
local IsControlKeyDown = _G.IsControlKeyDown
local gsub = _G.string.gsub
local LibStub = _G.LibStub
local next = _G.next
local UIParent = _G.UIParent
local WorldMapButton = _G.WorldMapButton
local WorldMapTooltip = _G.WorldMapTooltip

local HandyNotes = _G.HandyNotes
local TomTom = _G.TomTom

local completedQuests = {}
local points = AzerothsTopTunes.points


-- plugin handler for HandyNotes
local function infoFromCoord(mapFile, coord)
	mapFile = gsub(mapFile, "_terrain%d+$", "")

	local point = points[mapFile] and points[mapFile][coord]

	return point[2], point[3]
end

function AzerothsTopTunes:OnEnter(mapFile, coord)
	local tooltip = self:GetParent() == WorldMapButton and WorldMapTooltip or GameTooltip

	if self:GetCenter() > UIParent:GetCenter() then -- compare X coordinate
		tooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		tooltip:SetOwner(self, "ANCHOR_RIGHT")
	end

	local name, note = infoFromCoord(mapFile, coord)

	tooltip:SetText(name)
	tooltip:AddLine(note, 1, 1, 1)

	if TomTom then
		tooltip:AddLine(" ")
		tooltip:AddLine("Right-click to set a waypoint.", 1, 1, 1)
		tooltip:AddLine("Control-Right-click to set waypoints to every music roll.", 1, 1, 1)
	end

	tooltip:Show()
end

function AzerothsTopTunes:OnLeave()
	if self:GetParent() == WorldMapButton then
		WorldMapTooltip:Hide()
	else
		GameTooltip:Hide()
	end
end


local function createWaypoint(mapFile, coord)
	local x, y = HandyNotes:getXY(coord)
	local m = HandyNotes:GetMapFiletoMapID(mapFile)

	local name = infoFromCoord(mapFile, coord)

	TomTom:AddMFWaypoint(m, nil, x, y, { title = name })
	TomTom:SetClosestWaypoint()
end

local function createAllWaypoints()
	for mapFile, coords in next, points do
		for coord, questID in next, coords do
			if coord and (db.completed or not completedQuests[questID]) then
				createWaypoint(mapFile, coord)
			end
		end
	end
end

function AzerothsTopTunes:OnClick(button, down, mapFile, coord)
	if TomTom and button == "RightButton" and not down then
		if IsControlKeyDown() then
			createAllWaypoints()
		else
			createWaypoint(mapFile, coord)
		end
	end
end


do
	-- custom iterator we use to iterate over every node in a given zone
	local function iter(t, prestate)
		if not completedQuests[38356] or not completedQuests[37961] then return end
		if not t then return end

		local state, value = next(t, prestate)

		while state do -- have we reached the end of this zone?
			if (db.completed or not completedQuests[value[1]]) then
				return state, nil, "interface\\icons\\inv_misc_punchcards_yellow", db.icon_scale, db.icon_alpha
			end

			state, value = next(t, state) -- get next data
		end
	end

	local function iterCont(t, prestate)
		if not completedQuests[38356] or not completedQuests[37961] then return end
		if not t then return end

		local zone = t.Z
		local mapFile = HandyNotes:GetMapIDtoMapFile(t.C[zone])
		local state, value, data, cleanMapFile

		while mapFile do
			cleanMapFile = gsub(mapFile, "_terrain%d+$", "")
			data = points[cleanMapFile]

			if data then -- only if there is data for this zone
				state, value = next(data, prestate)

				while state do -- have we reached the end of this zone?
					if (db.completed or not completedQuests[value[1]]) then
						return state, mapFile, "interface\\icons\\inv_misc_punchcards_yellow", db.icon_scale, db.icon_alpha
					end

					state, value = next(data, state) -- get next data
				end
			end

			-- get next zone
			zone = next(t.C, zone)
			t.Z = zone
			mapFile = HandyNotes:GetMapIDtoMapFile(t.C[zone])
			prestate = nil
		end
	end

	function AzerothsTopTunes:GetNodes(mapFile)
		local C = HandyNotes:GetContinentZoneList(mapFile) -- Is this a continent?

		if C then
			local tbl = { C = C, Z = next(C) }
			return iterCont, tbl, nil
		else
			mapFile = gsub(mapFile, "_terrain%d+$", "")
			return iter, points[mapFile], nil
		end
	end
end


local L = {}
local Locale = GetLocale()
if Locale == 'zhCN' then
	L["Azeroth's Top Tunes"] = '歌曲位置';
	L["Music Scrolls for your Garrison Jukebox."] = '要塞点唱机歌曲位置';
	L["These settings control the look and feel of the icon."] = "这些设置是对地图上显示图标的控制";
	L["Show completed"] = '显示已完成的';
	L["Show icons for music scrolls you have already collected."] = '显示你已经收集的歌曲位置';
	L["Icon Scale"] = '图标缩放';
	L["Change the size of the icons."] = '改变图标的尺寸';
	L["Icon Alpha"] = '图标透明度';
	L["Change the transparency of the icons."] = '改变图标的透明度';
elseif Locale == 'zhTW' then
	L["Azeroth's Top Tunes"] = '歌曲位置';
	L["Music Scrolls for your Garrison Jukebox."] = '要塞點唱機歌曲位置';
	L["These settings control the look and feel of the icon."] = "這些設置是對地圖上顯示圖示的控制";
	L["Show completed"] = '顯示已完成的';
	L["Show icons for music scrolls you have already collected."] = '顯示你已經收集的歌曲位置';
	L["Icon Scale"] = '圖示縮放';
	L["Change the size of the icons."] = '改變圖示的尺寸';
	L["Icon Alpha"] = '圖示透明度';
	L["Change the transparency of the icons."] = '改變圖示的透明度';
else
	L["Azeroth's Top Tunes"] = "Azeroth's Top Tunes";
	L["Music Scrolls for your Garrison Jukebox."] = "Music Scrolls for your Garrison Jukebox.";
	L["These settings control the look and feel of the icon."] = "These settings control the look and feel of the icon.";
	L["Show completed"] = "Show completed";
	L["Show icons for music scrolls you have already collected."] = "Show icons for music scrolls you have already collected.";
	L["Icon Scale"] = "Icon Scale";
	L["Change the size of the icons."] = "Change the size of the icons.";
	L["Icon Alpha"] = "Icon Alpha";
	L["Change the transparency of the icons."] = "Change the transparency of the icons.";
end


-- config
local options = {
	type = "group",
	name = L["Azeroth's Top Tunes"],
	desc = L["Music Scrolls for your Garrison Jukebox."],
	get = function(info) return db[info[#info]] end,
	set = function(info, v)
		db[info[#info]] = v
		AzerothsTopTunes:Refresh()
	end,
	args = {
		desc = {
			name = L["These settings control the look and feel of the icon."],
			type = "description",
			order = 1,
		},
		completed = {
			name = L["Show completed"],
			desc = L["Show icons for music scrolls you have already collected."],
			type = "toggle",
			width = "full",
			arg = "completed",
			order = 2,
		},
		icon_scale = {
			type = "range",
			name = L["Icon Scale"],
			desc = L["Change the size of the icons."],
			min = 0.25, max = 2, step = 0.01,
			arg = "icon_scale",
			order = 3,
		},
		icon_alpha = {
			type = "range",
			name = L["Icon Alpha"],
			desc = L["Change the transparency of the icons."],
			min = 0, max = 1, step = 0.01,
			arg = "icon_alpha",
			order = 4,
		},
	},
}


-- initialise
function AzerothsTopTunes:OnEnable()
	local HereBeDragons = LibStub("HereBeDragons-1.0", true)
	if not HereBeDragons then
		HandyNotes:Print("Your installed copy of HandyNotes is out of date and the Azeroth's Top Tunes plug-in will not work correctly.  Please update HandyNotes to version 1.4.0 or newer.")
		return
	end

	HandyNotes:RegisterPluginDB("AzerothsTopTunes", self, options)

	completedQuests = GetQuestsCompleted(completedQuests)
	db = LibStub("AceDB-3.0"):New("HandyNotes_AzerothsTopTunesDB", defaults, "Default").profile

	AzerothsTopTunes:Refresh()
	AzerothsTopTunes:RegisterEvent("CRITERIA_UPDATE", "Refresh")
end

function AzerothsTopTunes:Refresh(_, questID)
	if questID then completedQuests[questID] = true end
	self:SendMessage("HandyNotes_NotifyUpdate", "AzerothsTopTunes")
end


-- activate
LibStub("AceAddon-3.0"):NewAddon(AzerothsTopTunes, "HandyNotes_AzerothsTopTunes", "AceEvent-3.0")
