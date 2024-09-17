--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

if isClient() then return end

require "Map/SGlobalObject"


-- Funzione per verificare se la temperatura rientra nel range min e max
--- @param currentTemp int
--- @return boolean
function STrapGlobalObject:isTemperatureSuitable(currentTemp)
    return currentTemp >= self.animal.minTemp and currentTemp <= self.animal.maxTemp
end


-- Funzione per calcolare la probabilità di cattura
---@param currentTemp float
---@return float
function STrapGlobalObject:calculateTempChance(currentTemp)
    local deltaTemp
    if currentTemp < self.animal.minTemp then
        deltaTemp = self.animal.minTemp - currentTemp
    else
        deltaTemp = currentTemp - self.animal.maxTemp
    end
    -- Supponiamo che ogni grado fuori dal range riduca la probabilità del 5%
    local chanceMultiplier = math.max(0, 1 - (deltaTemp * 0.05))
    print(self.animal.type .. " catch chance reduced by " .. deltaTemp .. "°C: " .. chanceMultiplier)
    return chanceMultiplier
end


--funzione originale
-- check if an animal is caught (every hour)
function STrapGlobalObject:checkForAnimal(square)
    -- you won't find an animal if a player is near the trap, so we check the trap only if it's streamed
    if square then
        -- (note turbo) if square~=nil do a check to see if theres any hoppables near the trap, this is an exploit to make traps invincible to zombie damage.
        -- when placing the trap it does check for hoppables, but a window frame could be placed afterwards.
        -- when this is the case, remove bait and animals if any.
        if self:checkForWallExploit(square) then
            self:removeAnimal();
            self:removeBait()
        end
        return;
    end
    if self.destroyed then
        return;
    end
    -- first, get which animal we'll attract
    local animalsList = {};

    -- Recupera la temperatura corrente una sola volta per trappola
    local currentTemp = ClimateManager.getInstance():getTemperature()

    for i,v in ipairs(Animals) do
        -- check if at this hour we can get this animal
        local timesOk = self:checkTime(v);
--        local timesOk = true;
        if v.traps[self.trapType] and
                v.baits[self.bait] and ZombRand(100) < (v.traps[self.trapType] + v.baits[self.bait] + (self.trappingSkill * 1.5)) and
                timesOk and v.zone[self.zone] and ZombRand(100) < (v.zone[self.zone] + (self.trappingSkill * 1.5)) then -- this animal can be caught by this trap and we have the correct bait for it
            -- now check if the bait is still fresh
            if self:checkBaitFreshness() then
--                print("can catch " .. v.type);
                table.insert(animalsList, v);
            end
        end
    end
    -- random an animal
    if #animalsList > 0 then
        local int = ZombRand(#animalsList) + 1;
        local testAnimal = animalsList[int];
        if testAnimal then
--            print("get animal : " .. testAnimal.type .. " in zone " .. self.zone);
            self:noise('trapped '..testAnimal.type..' '..self.x..','..self.y..','..self.z)
            self:setAnimal(testAnimal)
        end
    end
end
