--------------------------------
-- Tapto Rotation - Feral PVE
-- Version - 1.0.0
-- Author - Tapto
--------------------------------
-- Changelog
-- 1.0.0 Initial release
--------------------------------
-- In order to Work you need to make a macro with the word /shred 
--------------------------------
local ni = ...
local items = {
	settingsfile = "Taptoferalpvp.json",
	{
			type = "title",
			text = "|cffff00ffTapto |cffffffff- Feral insane dps",
	},
	{
			type = "separator",
	},
	{
			type = "title",
			text = "|cff71C671Main Settings",
	},
	{
			type = "entry",
			text = "\124T" .. select(3, GetSpellInfo(48566)) .. ":26:26\124t Use Mangle",
			tooltip = "Disble if there is a warrior, bear or other cat",
			enabled = true,
			key = "getSetting_UseMangle",
	},
	{
			type = "entry",
			text = "\124T" .. select(3, GetSpellInfo(44605)) .. ":26:26\124t Buff for Clear cast",
			tooltip = "Get Alot of spines for spamming",
			enabled = true,
			key = "getSetting_CCbuf",
	},
	{
			type = "entry",
			text = "\124T" .. select(3, GetSpellInfo(41119)) .. ":26:26\124t Use Saronite Bombs",
			tooltip = "Use Saronite Bombs",
			enabled = true,
			key = "getSetting_SaroBomb",
	},
}
local function GetSetting(name)
	for k, v in ipairs(items) do
			if v.type == "entry"
			and v.key ~= nil
			and v.key == name then
					return v.value, v.enabled
			end
	end
end

local function onload()
	ni.GUI.AddFrame("Taptoferal", items);
	print("Rotation \124cFF15E615Tapto Feral DPS PVP")
end

local function onunload()
	ni.GUI.DestroyFrame("Taptoferal");
	print("Rotation \124cFFE61515stopped!")
end

SLASH_PRIMARY1 = "/rotationprimary"
SlashCmdList["PRIMARY"] = function(msg)
	ni.toggleprofile(ni.vars.profiles.primary)
end 

SLASH_SECONDARY1 = "/rotationsecondary"
SlashCmdList["SECONDARY"] = function(msg)
	ni.toggleprofile(ni.vars.profiles.secondary);
end 

SLASH_GUI1 = "/rotationgui"
SlashCmdList["GUI"] = function(msg)
	ni.main_ui.main:Show();
end

SLASH_SHRED1 = "/shred"
SlashCmdList["SHRED"] = function(msg)
		if ni.unit.isbehind("player", "target") 
			 and ni.spell.available("48572")
			and GetComboPoints("player", "target") < 5 then
				ni.spell.cast ("48572")
		elseif not ni.unit.isbehind("player", "target")
		and GetComboPoints("player", "target") < 5
		and ni.player.powerraw("energy") >= 45 then
			ni.spell.cast("48566", "target")
		end
end 


local queue = {
	"Pounce",
	"Barkskin",
	"Survival",
	"INVI",
	"Hyperspeed Accelerators",
	"Berserkfear",
	"Interrupt",
	"Tigers Fury",
	"Faerie fire",
	"Ferocious Bite1",
	"Ferocious Bite2",
	"Shreadcc",
	"Shred100",
	"Saronite",
	--bear
	"FrenziedRegenerationBear",
}

local abilities = {

["Berserkfear"] = function ()
	if ni.spell.available("50334")
	and  ni.unit.debuff ("player", "10890", "player")
	or ni.unit.debuff ("player", "20511", "player") 
	or ni.unit.debuff ("player", "6215", "player") 
	or ni.unit.debuff ("player", "17928", "player")then
		ni.spell.cast("50334")
		return true;
	end
end,


	["Pounce"] = function ()
		if ni.spell.available (49803)
		and  ni.unit.buff ("player", "5215", "player")  then
			ni.spell.cast(49803)
			return true;
		end
	end,

	["INVI"] = function ()
		if ni.spell.available (5215)
		and not UnitAffectingCombat("player")
		and ni.unit.buff ("player", "768", "player") 
		and not  ni.unit.buff ("player", "5215", "player")  then
			ni.spell.cast(5215)
			return true;
		end
	end,


	["Cat form"] = function ()
		if ni.spell.available (768)
		and UnitAffectingCombat("player")
		and not ni.unit.buff ("player", "768", "player") 
		and not ni.unit.buff ("player", "9634", "player") then
			ni.spell.cast(768)
			return true;
		end
	end,



	["Auto Target"] = function()
		if UnitAffectingCombat("player")
		and ((ni.unit.exists("target")
		and UnitIsDeadOrGhost("target")
		and not UnitCanAttack("player", "target"))
		or not ni.unit.exists("target")) then
				ni.player.runtext("/targetenemy")
				return true;
		end
end,

			["Start Attack"] = function()
				if ni.unit.exists("target")
				and UnitCanAttack("player", "target")
				and not UnitIsDeadOrGhost("target")
				and UnitAffectingCombat("player")
				and ni.unit.buff ("player", "768", "player") 
				and not IsCurrentSpell(6603) then
						ni.spell.cast(6603)
						return true;
				end
		end,
	["Barkskin"] = function ()
		if ni.spell.available("22812")
		and UnitAffectingCombat("player")
		and ni.player.hp("player") <=50 then
			ni.spell.cast("22812")
					return true;
		end
	end,

	["Survival"] = function ()
		if ni.spell.available("61336")
		and UnitAffectingCombat("player")
		and ni.player.hp("player") <=30 then
			ni.spell.cast("61336")
			return true;
		end
	end,

	["Tigers Fury"] = function()
		if ni.spell.available("50213")
		and ni.player.power() < 30 then
			ni.spell.cast("50213", "target")
		return true;
		end
	end,
	
	["Savage Roar"] = function()
		if ni.spell.available("52610")
		and GetComboPoints("player", "target") >= 3
		and ni.unit.buffremaining("player", "52610", "player") <= 1
		then
			ni.spell.cast("52610", "target")
			return true;
		end
	end,

	["Mangle"] = function()
		local _, enabled = GetSetting("getSetting_UseMangle")
		if enabled then
			if ni.spell.available("48566")
			and ni.unit.debuffremaining("target", "48566", "player") <= 5
			and ni.unit.debuffremaining("target", "46857", "player") <= 3 
			and ni.unit.debuffremaining("target", "46856", "player") <= 3 
			and ni.unit.debuffremaining("target", "46855", "player") <= 3 
			and ni.unit.debuffremaining("target", "46854", "player") <= 3 
			and ni.unit.debuffremaining("target", "48564", "player") <= 3 then
			ni.spell.cast("48566", "target")
			end
		end
	end,

	["Faerie fire"] = function()
		if ni.spell.available("16857")
		and not ni.unit.buff ("player","16870", "player") 
		and ni.player.power() < 17 then
			ni.spell.cast("16857", "target")
			return true;
			end
		end,

		["Ferocious Bite1"] = function()
			if ni.spell.available("48577")
			and ni.unit.hpraw ("target") < 4000 
			and GetComboPoints("player", "target") >= 5 then
				ni.spell.cast("48577")
				return true;
					end
			end,

		["Ferocious Bite2"] = function()
			if ni.spell.available("48577")
			and ni.unit.hpraw ("target") < 2000 
			and GetComboPoints("player", "target") >= 4 then
				ni.spell.cast("48577")
				return true;
					end
			end,

		["Ferocious Bitettd"] = function()
			 if ni.spell.available("48577")
			 and GetComboPoints("player", "target") == 5 then
				 ni.spell.cast("48577")
				 return true;
					 end
			 end,

		["Shreadcc"] = function()
			if ni.spell.available("48572")
			and ni.unit.buffremaining ("player","16870", "player") >= 1
			and ni.unit.isbehind("player", "target")
			then ni.spell.cast ("48572")

				end
			end,

		["Rip"] = function ()
			if ni.spell.available("49800")
			and GetComboPoints("player", "target") == 5
			and ni.unit.debuffremaining ("target","49800", "player") <= 0.5 then
				ni.spell.cast (49800)
		    end
	    end,

        ["Interrupt"] = function ()
			if ni.spell.available("49802")
			and GetComboPoints("player", "target")  >= 1 
			and ni.unit.iscasting("target")
			and (ni.unit.castingpercent("target") >=70
			or ni.unit.ischanneling("target"))  then
				ni.spell.cast ("49802")
		end
	end,

	-- interruptspells = {
	-- 	Greater Heal --Priest Heal
	-- 	Penance--Priest Direct channel heal
	-- 	Flash Heal--Priest quick big heal&amp;quot;
	-- 	Heal--Priest normal heal
	-- 	Binding Heal--Priest heal for themself and another
	-- 	Lesser Heal--Priest small heal
	-- 	Prayer of Healing--Priest AoE heal
	-- 	Chain Heal--Shaman AoE heal
	-- 	Healing Wave--Shaman heal
	-- 	Lesser Healing Wave&ampShaman minor heal
	-- 	Flash of Light--Paladin quick heal
	-- 	Holy Light--Paladin small heal
	-- 	Nourish--Druid heals
	-- 	Healing Touch--Druid heal
	-- 	Regrowth--Druid AoE
	-- 	Rebirth--Druid brez
	-- 	Tranquility--Druid AoE heal
	-- 	Hex--Shaman CC
	-- 	Cyclone
	-- 	Polymorph
	-- 	}
	-- /Lua><RecastDelay>0</RecastDelay><Target>Focus</Target><CancelChannel>False</CancelChannel><LuaBefore></LuaBefore><LuaAfter></LuaAfter></Ability><Ability><Name>Cyclone</Name><Default>false</Default><SpellID>33786</SpellID><Actions></Actions><Lua>local _, _, _, PS = UnitBuffID(&amp;quot;player&amp;quot;, 69369)
	-- local inRange = IsSpellInRange(&amp;quot;Cyclone&amp;quot;, &amp;quot;focus&amp;quot;)
	
	-- if PS ~= nil and inRange == 1 and PQR_IsOutOfSight(focus) == false then
	-- 	RunMacro(&amp;quot;cyclonefocusss&amp;quot;)
	-- else
	-- 	return false

	-- 	unit.enemiesinrange = function(t, n)
	-- 		local enemiestable = {}
	-- 		t = true and UnitGUID(t) or t
	-- 		if t then
	-- 			for k, v in pairs(ni.objects) do
	-- 				if type(k) ~= "function" and (type(k) == "string" and type(v) == "table") then
	-- 					if k ~= t and v:canattack() and not UnitIsDeadOrGhost(k) and unit.readablecreaturetype(k) ~= "Critter" then
	-- 						local distance = v:distance(t)
	-- 						if (distance ~= nil and distance <= n) then
	-- 							tinsert(enemiestable, {guid = k, name = v.name, distance = distance})
	-- 						end
	-- 					end
	-- 				end
	-- 			end
	-- 		end
	-- 		return enemiestable
	-- 	end

	local enemies = ni.unit.enemiesinrange("player", 30)

for i = 1, #enemies do
  local target = enemies[i].guid
  local name = enemies[i].name
  local distance = enemies[i].distance
  -- Do something with the enemy target
end

	ni.player.lookat("target")
	if ni.unit.isfacing("player", "target") then
		ni.spell.cast ("forma Oso")
		ni.spell.cast("Feral Charge", "target")

		["Savager Roar"] = function ()
			if ni.spell.available("52610")
			and GetComboPoints("player", "target") == 5
			and ni.unit.buffremaining("player", "52610", "player") <= 1 
			then
				ni.spell.cast("52610", "target")

			end
		 end,

		["Rake"] = function ()
			if ni.spell.available("48574")
			and not ni.unit.debuff("target", "48574", "player") then
				ni.spell.cast ("48574")
			end
		end,

		["Shred"] = function ()
			if ni.spell.available("48572")
			and GetComboPoints("player", "target") < 5 
			and ni.unit.debuffremaining("target", "48574", "player") >= 1
			and ni.unit.isbehind("player", "target") then
				ni.spell.cast ("48572")
				return true;
			end
		end,

		["Shred2"] = function ()
			if ni.spell.available("48572")
			and GetComboPoints("player", "target") < 5 
			and ni.unit.isbehind("player", "target") then
				ni.spell.cast ("48572")
				return true;
			end
		end,

		["Manglenot"] = function ()
			if ni.spell.available("48566")
			and not ni.unit.isbehind("player", "target")
			and GetComboPoints("player", "target") < 5 then
				ni.spell.cast("48572", "target")
				return true;
			end
		end, 

		["Shred100"] = function ()
			if ni.spell.available("48572")
			and  ni.player.powerraw("energy") >= 99
			and ni.unit.isbehind("player", "target") then
				ni.spell.cast ("48572")
				return true;
			end
		end,

		["Ingrediente Secreto"] = function()
			if ni.spell.available("52610")
			and GetComboPoints("player", "target") >= 2
			and ni.unit.buffremaining("player", "52610", "player") <= 6
			and ni.unit.debuffremaining ("target","49800", "player") <= 7	
			and ni.unit.debuffremaining ("target","49800", "player") >= 4 then
				ni.spell.cast("52610", "target")
				return true;
			end
		end,


		["WILD"] = function()
			local _, enabled = GetSetting("getSetting_CCbuf")
			if enabled then
				if ni.spell.available("48470")
				and ni.player.power(3) < 20
				and not ni.unit.buff("player", "53909", "player")
				and not ni.unit.buff("player", "54758", "player")
				and not ni.unit.buff("player", "16870", "player")	
				and GetComboPoints("player", "target") < 5
				and ni.player.power(0) >= 40 then
					ni.spell.cast("48470")
					ni.player.runtext("/stopattack")
				return true;
				end
			end
		end,

			["FrenziedRegenerationBear"] = function ()
				if ni.spell.available("22842")
				and UnitAffectingCombat("player")
				and ni.player.hp("player") <= 70 then
					ni.spell.cast("22842")
					return true;
				end
			end,


			["Saronite"] = function ()
				local _, enabled = GetSetting("getSetting_SaroBomb")
				if enabled then
					if ni.player.itemcd(41119) == 0
					and ni.player.hasitem(41119)
					and ni.unit.exists("target")
					and UnitAffectingCombat("player") then
							ni.player.useitem(41119)
							ni.player.clickat("target")
							return true;
					end
				end
			end,

		["Hyperspeed Accelerators"] = function()
			if ni.unit.isboss("target")
			and ni.spell.available("48566")
			and ni.player.slotcd(10) == 0
			and ni.unit.buff("player", "60233", "player") 
				-- or ni.unit.buff("player", "71556", "player") 
				-- or ni.unit.buff("player", "71560", "player") 
			then
					ni.player.useinventoryitem(10)
					return true;
			end
	end,

			["Swipe"] = function ()
				if ni.spell.available("62078")
				and UnitAffectingCombat("player")
				and ni.unit.exists("target")
				and ni.unit.buffremaining("player", "52610", "player") <= 2 then
				 ni.spell.cast("62078","target")
				end
			end,

		["NatureGraspcc"] = function()
				if ni.spell.available("53312")
				and not ni.unit.buff ("player","16870", "player")
				and ni.player.power() < 20 then
					ni.spell.cast("53312")
					end
				end,
		}

		
ni.bootstrap.profile("TaptoRotations - Feral pvp", queue, abilities, onload, onunload)

----------------------------------------------------------------
-- TODO:
----------------------------------------------------------------
-- a function to interrupt with feral charge on arenas target if not use cyclone on important cast spells
-- list of CC to trinket 
-- Auto berserk on fear 
-- Auto Shapeshifter on roots and snares 
