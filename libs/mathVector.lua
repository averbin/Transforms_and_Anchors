-----------------------------------------------------------------------------------------
--
-- mathVector.lua linear algebra for games, this section calculate vectors.
--
-----------------------------------------------------------------------------------------

local _M = {}

function _M.CalculateAngle(dotProduct, srcLength, dstLength)
  local angleRad = math.acos(
    dotProduct / (srcLength * dstLength)
  )
  print("Angle:\t" .. angleRad)
  return angleRad
end

function _M.CalculateDotProduct(srcObject, dstObject)
  local dotProduct = srcObject.x * dstObject.x + srcObject.y * dstObject.y
  print("Dot product: " .. dotProduct)
  return dotProduct
end

-- Calculate magnitude(length) of a vectors.
function _M.CalculateLength( object )
  local length = math.sqrt(
    math.pow(object.x, 2) + math.pow(object.y, 2)
  )
  print("Lenght:\t" .. length)
  return length
end

function _M.CalcualteNormalization( object )
  local length = _M.CalculateLength(object)
  local normalizeVector =
    {
      x = (object.x / length),
      y = (object.y / length)
    }
  print("Normalized: x " .. normalizeVector.x .. " y " .. normalizeVector.y)
  return normalizeVector
end

function _M.CrossProduct(A, B)
  local C = {}
  if not A.z then
    A.z = 0
  end
  if not B.z then
    B.z = 0
  end

  C.x = A.y * B.z - A.z * B.y
  C.y = A.z * B.x - A.x * B.z
  C.z = A.x * B.y - A.y * B.x
  return C
end

function _M.DistanceBetweenObjects(srcObject, dstObject)
  local distance = math.sqrt(
    math.pow((dstObject.x - srcObject.x), 2) +
    math.pow((dstObject.y - srcObject.y), 2)
  )
  print("Distance:\t" .. distance)
  return distance
end

function _M.Multiplication(A, B)
  return (A.x * B.x + A.y * B.y)
end

function _M.Subtraction(A, B)
  local C = {}
  C.x = B.x - A.x
  C.y = B.y - A.y
  return C
end

return _M
