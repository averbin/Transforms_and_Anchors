-----------------------------------------------------------------------------------------
--
-- main.lua Transforms and Anchors
--
-----------------------------------------------------------------------------------------
local ship = display.newImageRect("playerShip1_red.png", 75, 99)
ship.x = display.contentCenterX
ship.y = display.contentCenterY
ship:rotate(90)
local cross = display.newImageRect("laserRed11.png", 37, 37)

local lineToShip = display.newLine( 0, 0, ship.x, ship.y)
local lineToCross = display.newLine( 0, 0, cross.x, cross.y)
local lineDist = display.newLine(ship.x, ship.y, cross.x, cross.y)

lineToShip:setStrokeColor(0, 0, 1)
lineToCross:setStrokeColor(1, 0, 0)
lineDist:setStrokeColor(0, 1, 0)

-- Calculate magnitude(length) of vectors.
function CalculateMagnitude( object )
  local length = math.sqrt(
    math.pow(object.x, 2) + math.pow(object.y, 2)
  )
  print("Lenght:\t" .. length)
  return length
end

function CalcualteNormalization( object )
  local normalizeVector =
    {
      x = (object.x / CalculateMagnitude(object)),
      y = (object.y / CalculateMagnitude(object))
    }
  print("Normalized: x " .. normalizeVector.x .. " y " .. normalizeVector.y)
  return normalizeVector
end

function CalculateDotProduct(srcObject, dstObject)
  local dotProduct = srcObject.x * dstObject.x + srcObject.y * dstObject.y
  print("Dot product: " .. dotProduct)
  return dotProduct
end

function DistanceBetweenObjects(srcObject, dstObject)
  local distance = math.sqrt(
    math.pow((dstObject.x - srcObject.x), 2) +
    math.pow((dstObject.y - srcObject.y), 2)
  )
  print("Distance:\t" .. distance)
  return distance
end

function CalculateAngle(dotProduct, srcLength, dstLength)
  local angleRad = math.acos(
    dotProduct / (srcLength * dstLength)
  )
  print("Angle:\t" .. angleRad)
  return angleRad
end

function tap(event)
  cross.x = event.x
  cross.y = event.y
  lineToCross:removeSelf()
  lineToCross = display.newLine( 0, 0, cross.x, cross.y)
  lineToCross:setStrokeColor(1, 0, 0)
  lineDist:removeSelf()
  lineDist = display.newLine(ship.x, ship.y, cross.x, cross.y)
  lineDist:setStrokeColor(0, 1, 0)
  local crossLength = CalculateMagnitude(cross)
  CalcualteNormalization(cross)
  local shipLength = CalculateMagnitude(ship)
  CalcualteNormalization(ship)

  print("Distance between name cross and ship")
  local distance = DistanceBetweenObjects(cross , ship)
  print("Dot Product cross and ship")
  local dotProduct = CalculateDotProduct(cross, ship)
  local angle = CalculateAngle(dotProduct, crossLength, shipLength)
  print("In degrees:\t" .. math.deg(angle))
  --redShip:rotate(math.deg(angle))

  return true
end

Runtime:addEventListener("tap", tap)
