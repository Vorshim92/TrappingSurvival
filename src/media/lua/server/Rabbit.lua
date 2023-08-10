---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lele.
--- DateTime: 09/08/23 09:41
---

-- SteamLibrary/steamapps/common/ProjectZomboid/projectzomboid/media/lua/server/Traps/TrapDefinition.lua

--local trap = require("server/Trap")
--local bait = require("server/Bait")
--local zone = require("server/Zone")

local trap = require("Trap")
local bait = require("Bait")
local zone = require("Zone")

local rabbit = {}
rabbit.baits = {}
rabbit.traps = {}
rabbit.zones = {}

--- ---------------------- Start Rabbit Default values -------------------------------

--                  ** BAIT **
local apple = 35
local banana = 35
local bellPepper = 40
local cabbage = 40
local carrots = 45
local corn = 35
local lettuce = 40
local peach = 35
local potato = 35
local tomato = 35

--                  ** ZONE **
local deepForest = 15
local forest = 12
local townZone = 2
local trailerPark = 2
local vegetation = 10

--                  ** TRAP **
local trapBox = 30
local trapCage = 40
local trapCrate = 30
local trapSnare = 30

--                  ** SIZE ANIMALS **
local minSize = 30
local maxSize = 100

--                  ** QUALCOSA **
rabbit.type = "rabbit";
-- after how many hour the animal will start to destroy the cage/escape
rabbit.strength = 24;
-- item given to the player
rabbit.item = "Base.DeadRabbit";
-- hour this animal will be out and when you can catch it
rabbit.minHour = 18;
rabbit.maxHour = 8;

--- ---------------------- Start Set Multiplier -------------------

--- **Set Bait Multiplier**
---@param multiplier int
local function setBaitMultiplier(multiplier)
    bait.setApple( apple * multiplier)
    bait.setBanana(banana * multiplier)
    bait.setBellPepper(bellPepper * multiplier)
    bait.setCabbage(cabbage * multiplier)
    bait.setCarrots(carrots * multiplier)
    bait.setCorn(corn * multiplier)
    bait.setLettuce(lettuce * multiplier)
    bait.setPeach(peach * multiplier)
    bait.setPotato(potato * multiplier)
    bait.setTomato(tomato * multiplier)
end

--- **Set Trap Multiplier**
---@param multiplier int
local function setTrapMultiplier(multiplier)
    trap.setTrapBox( trapBox * multiplier)
    trap.setTrapCage(trapCage * multiplier)
    trap.setTrapCrate(trapCrate * multiplier)
    trap.setTrapSnare(trapSnare * multiplier)
end

--- **Set Zone Multiplier**
---@param multiplier int
local function setZoneMultiplier(multiplier)
    zone.setDeepForest( deepForest * multiplier)
    zone.setForest(forest * multiplier)
    zone.setTownZone(townZone * multiplier)
    zone.setTrailerPark(trailerPark * multiplier)
    zone.setVegetation(vegetation * multiplier)
end

--- **Set "size" Multiplier**
--- Min and max "size" (understand hunger reduction) of the animal
---@param multiplier int
local function setSizeAnimalMultiplier(multiplier)
    rabbit.minSize = minSize * multiplier;
    rabbit.maxSize = maxSize * multiplier;
end

--- ---------------------- Start table bait/trap/zone -------------

--- **Create Bait**
---@param baitEnum Enum
---@param bait_ string
local function createBait(baitEnum, bait_)
    rabbit.baits[baitEnum] = bait_
end

--- **Create Trap**
---@param trapEnum Enum
---@param trap_ string
local function createTrap(trapEnum, trap_)
    rabbit.traps[trapEnum] = trap_
end

--- **Create Zone**
---@param zoneEnum Enum
---@param zone_ string
local function createZone(zoneEnum, zone_)
    rabbit.zones[zoneEnum] = zone_
end

--- ---------------------- Start init Bait -------------------
--- **Init Bait**
local function initBait()
    createBait(bait.bait.APPLE, bait.getApple())
    createBait(bait.bait.BANANA, bait.getBanana())
    createBait(bait.bait.BELL_PEPPER, bait.getBellPepper())
    createBait(bait.bait.CABBAGE, bait.getCabbage())
    createBait(bait.bait.CARROTS, bait.getCarrots())
    createBait(bait.bait.CORN, bait.getCorn())
    createBait(bait.bait.LETTUCE, bait.getLettuce())
    createBait(bait.bait.PEACH, bait.getPeach())
    createBait(bait.bait.POTATO, bait.getPotato())
    createBait(bait.bait.TOMATO, bait.getTomato())
end

--- **Init Trap**
local function initTrap()
    createTrap(trap.trap.BOX, trap.getTrapBox())
    createTrap(trap.trap.CAGE, trap.getTrapCage())
    createTrap(trap.trap.CRATE, trap.getTrapCrate())
    createTrap(trap.trap.SNARE, trap.getTrapSnare())
end

--- **Init Zone**
local function initZone()
    createZone(zone.zone.DEEP_FOREST, zone.getDeepForest())
    createZone(zone.zone.FOREST, zone.getForest())
    createZone(zone.zone.TOWN_ZONE, zone.getTownZone())
    createZone(zone.zone.TRAILER_PARK, zone.getTrailerPark())
    createZone(zone.zone.VEGETATION, zone.getVegetation())
end


--- **Init rabbit**
---@param value int
---@return table rabbit
local function init()
    local multiplier = SandboxVars.TrapCage.Multiplier

    --                  ** MULTIPLIER **
    setBaitMultiplier(multiplier)
    setTrapMultiplier(multiplier)
    setZoneMultiplier(multiplier)
    setSizeAnimalMultiplier(multiplier)

    --                  ** RABBIT BAIT/TRAP/ZONE **
    initBait()
    initTrap()
    initZone()

end

---**Get Rabbit**
---@return table Rabbit
function getRabbit()
    init()
    return rabbit
end