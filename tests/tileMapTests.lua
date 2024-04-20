local T = require 'lib/knife.test'

Class = require 'lib/class'
require 'src/constants'
require 'src/util'
require 'src/TileMap'

local testCases = {
  { 0, 288, 1, 1 },
  { 0, 287, 1, 1 },
  { 0, 273, 1, 1 },
  { 0, 272, 1, 2 },
  { 1, 288, 1, 1 },
  { 15, 288, 1, 1 },
  { 16, 288, 2, 1 },
}

T('pointToMap', function (T)
  local tileMap = TileMap(32, 18)

  for _, testCase in ipairs(testCases) do
    local x, y, mapX, mapY = table.unpack(testCase)
    local currentMapX, currentMapY = tileMap:pointToMap(x, y)
    local testName =
      '('..tostring(x)..', '..tostring(y)..') -> '..
      '('..tostring(mapX)..', '..tostring(mapY)..')'

    T(testName, function (T)
      T:assert(currentMapX == mapX, 'mapX '..tostring(currentMapX)..' != '..tostring(mapX))
      T:assert(currentMapY == mapY, 'mapY '..tostring(currentMapY)..' != '..tostring(mapY))
    end)
  end
end)