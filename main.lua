-----------------------------------------------------------------------------------------
--
-- main.lua Transforms and Anchors
--
-----------------------------------------------------------------------------------------
local physics = require "physics"
local mathVector = require "libs.mathVector"
local ship = display.newImageRect("playerShip1_red.png", 99, 75)

ship.x = display.contentCenterX
ship.y = 450
ship:rotate(-180)
local cross = display.newImageRect("cross.png", 37, 37)

local lineToShip = display.newLine( 0, 0, ship.x, ship.y)
local lineToCross = display.newLine( 0, 0, cross.x, cross.y)
local lineDist = display.newLine(ship.x, ship.y, cross.x, cross.y)
local additionalVector = nil
local additionalAngle = nil

local tPrevious = system.getTimer()
--math.randomseed(os.time())

lineToShip:setStrokeColor(0, 0, 1)
lineToCross:setStrokeColor(1, 0, 0)
lineDist:setStrokeColor(0, 1, 0)

function tap(event)
  cross.x = event.x
  cross.y = event.y
  lineToCross:removeSelf()
  lineToCross = display.newLine( 0, 0, cross.x, cross.y)
  lineToCross:setStrokeColor(1, 0, 0)
  lineDist:removeSelf()
  lineDist = display.newLine(ship.x, ship.y, cross.x, cross.y)
  lineDist:setStrokeColor(0, 1, 0)

  if ship.y > 0 then
    additionalVector = {}
    additionalVector.x = display.contentCenterX
    additionalVector.y = 0

    local additionalToShipVec = mathVector.Subtraction(additionalVector, ship)
    local additionalToShipNormalVec = mathVector.CalcualteNormalization(additionalToShipVec)
    local unitVectorShip = mathVector.CalcualteNormalization(ship)
    local angle = math.acos(mathVector.Multiplication(unitVectorShip, additionalToShipNormalVec))
    additionalAngle = math.deg(angle)
    print("Additional Angle rad: " .. angle .. " Angle deg: " .. additionalAngle)
    local crossProdCrossShip =
        mathVector.CrossProduct(unitVectorShip, additionalToShipNormalVec)
    print("Additional : " .. crossProdCrossShip.z)
    if crossProdCrossShip.z > 0 then
      additionalAngle = additionalAngle * (-1)
    end
  end

  local vectorPointsToCross = mathVector.Subtraction(ship, cross)
  print("Dist: (" .. vectorPointsToCross.x ..
   " : " .. vectorPointsToCross.y .. ")")
  local unitVectorShipToCorss = mathVector.CalcualteNormalization(vectorPointsToCross)
  local unitVectorShip = mathVector.CalcualteNormalization(ship)
  local angle = math.acos(mathVector.Multiplication(unitVectorShipToCorss, unitVectorShip))
  local angleDeg = math.deg(angle)
  print("Angle rad: " .. angle .. " Angle deg: " .. angleDeg)
  local crossProdCrossShip = mathVector.CrossProduct(unitVectorShipToCorss, unitVectorShip)
  print("Z: " .. crossProdCrossShip.z)

  if crossProdCrossShip.z > 0 then
    -- rotate counterclockwise
    print("Angle before: " .. ship.rotation)
    ship.rotation = -90
    if additionalAngle ~= nil then
      print("counterclockwise additional ")
      ship:rotate(-(angleDeg) + additionalAngle - ship.rotation)
    else
      ship:rotate(-(angleDeg))
    end
    print("Angle after: " .. ship.rotation)
  else
    -- rotate clockwise
    print("Angle before: " .. ship.rotation)
    ship.rotation = -90
    if additionalAngle ~= nil then
      print("clockwise additional ")
      ship:rotate(angleDeg + additionalAngle - ship.rotation)
    else
      ship:rotate(angleDeg)
    end
    print("Angle after: " .. ship.rotation)
  end

  return true
end

local function DeltaTimeMove(event)
  local deltaTime = event.time - tPrevious
  tPrevious = event.time
  print("DeltaTime: " .. deltaTime)
  ship.y = ship.y - deltaTime * 0.01
end

Runtime:addEventListener("tap", tap)
--Runtime:addEventListener("enterFrame", DeltaTimeMove)
