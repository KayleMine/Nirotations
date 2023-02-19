local ni = ...
local queue = {
    "Inner Fire",
    "Power Word: Shield",
    "Vampiric Embrace",
    "Pause Rotation",
	"Shadow Form"
    "Silence"
    "Execute"
    "SWP Moving",
    "DVP Moving",
    "Vampiric Touch",
    "Shadow Word:Pain",
    "Devouring Plague",
    "Mind Blast",
    "Mind Flay",
}
local abilities = {
    ["Inner Fire"] = function()
            if ni.spell.available("Inner Fire")
            and not ni.unit.buff("player", "Inner Fire") then
                ni.spell.cast("Inner Fire")
            end
        
    end,

    ["Vampiric Embrace"] = function()
            if ni.spell.available("Vampiric Embrace")
            and not ni.unit.buff("player", "Vampiric Embrace") then
                ni.spell.cast("Vampiric Embrace")
            end
        
    end,


    ["Pause Rotation"] = function()
        if IsMounted()	
        or UnitIsDeadOrGhost("player")
				or not UnitAffectingCombat("player")
				or ni.unit.buff("player", "Drink") then
            return true;
        end
    end,


    ["Power Word: Shield"] = function()
        if not ni.unit.debuff("Weakened Soul", "player")
        and not ni.unit.debuff("Power Word: Shield", "player")
        and ni.spell.available("Power Word: Shield") then
            ni.spell.cast("Power Word: Shield", "player")
        end
    end,

    ["Shadow Form"] = function()
        if not ni.unit.buff("Shadow Form", "player")
        then ni.delayfor(1.5, function()
            ni.spell.cast("Shadow Bolt", "player")
        end);
        end
    end,
    ["Silence"] = function()
        if ni.spell.available("Silence")
        and ni.unit.iscasting("target") then
            ni.spell.cast("Silence", "target")
        end
    end,
    
    -- Here I need to make a list of spell to interrupts 


    ["Execute"] = function()
        if ni.spell.available("Shadow Word:Death")
        and ni.unit.hpraw ("target")> 2500 then 
            ni.player.useinventoryitems(10)
            ni.spell.cast("Shadow Word:Death", "target")
            ni.player.runtex("/castsequence [exists] !shoot,!shoot") 
        end
    end,
    ["SWP Moving"] = function()
        if ni.unit.ismoving("player")
        and ni.unit.debuffremaining("target" "Shadow Word:Death") <= 3
        then ni.spell.cast("Shadow Word:Death", "target")
        end
    end,

    ["DVP Moving"] = function()
        if ni.unit.ismoving("player")
        and ni.unit.debuffremaining("target" "Devouring Plage") <= 3
        then ni.spell.cast("Devouring Plague", "target")
        end
    end,
    ["Vampiric Touch"] = function()
        if ni.spell.available("Vampiric Touch")
        and ni.unit.debuffremaining("target" "Vampiric Touch") <= 1.5
        then ni.spell.cast("Vampiric Touch", "target")
        end
    end,
    ["Shadow Word:Pain"] = function()
        if ni.unit.debuffremaining("target" "Shadow Word:Death") <= 0.5
        then ni.spell.cast("Shadow Word:Death", "target")
        end
    end,
    ["Devouring Plague"] = function()
        if ni.unit.debuffremaining("target" "Devouring Plage") <= 0.5
        then ni.spell.cast("Devouring Plague", "target")
        end
    end,
    ["Mind Blast"] = function()
        if ni.spell.available ("Mind Blast")
        then ni.spell.cast("Mind Blast", "target")
        end
    end,
    ["Mind Flay"] = function()
        if ni.spell.available("Mind Flay")
        then ni.spell.cast("Mind Flay", "target")
        end
    end,
}
ni.bootstrap.profile("TaptoRotations - Shadow Helper", queue, abilities)


-- Shadow Form = 15487
-- Vampiric Embrace = 15286
-- Physic horror = 64044
-- Mind Flay = 48156
-- Mind Blast = 48127
-- Devoring plague = 48300
-- Shadow word:pain = 48125 
-- shadow word:death = 48158
-- Vampire Touch = 48160
-- Silence = 15487



-- TODO 
-- 1.- List of trinketed CC 
-- 2.- Use trinket when hp low
-- 3- Use Fade when inmobilized 
-- 4- List of Dispeleable buffs 
