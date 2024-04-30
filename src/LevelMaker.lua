LevelMaker = Class{}

--[[
  Tile IDs:
  - 00: empty
]]

-- 32 x 18: viewport size
function LevelMaker.generate(width, height)
  -- sets seed, so the level generation will reproducable
  -- math.randomseed(width, height)

  -- tileMap[columns][rows]
  local tileMap = {}

  local surface = {}
  local surfaceType = round(math.random(0, 1))
  local waterLength = 0
  local islandLength = 0
  local islandHeight = 0
  local islandInterval = 0

  -- generate surface
  for column = 1, width do
    if islandLength == 0 and waterLength == 0 then
      if surfaceType == 0 then
        surfaceType = 1
        islandLength = math.random(10, 20)
      else
        surfaceType = 0
        waterLength = math.random(2, 10)
      end
    end

    if islandLength > 0 then
      if islandInterval == 0 then
        islandInterval = math.random(4, 6)
        islandHeight = math.random(2, 4)
      end

      surface[column] = islandHeight
      islandInterval = islandInterval - 1
      islandLength = islandLength - 1
    end

    if waterLength > 0 then
      surface[column] = 0
      waterLength = waterLength - 1
    end
  end

  local islandIndex = findIndex(surface, function (h) return h > 0 end)
  local waterIndex = nil

  -- generate matrix
  for column = 1, width do
    table.insert(tileMap, {})

    if surface[column] > 0 then
      for row = 1, surface[column] do
        tileMap[column][row] = Tile(TILE_ID_GROUND, column, row)
      end

      if waterIndex == 1 then
        waterIndex = nil
      end

      if waterIndex ~= nil then
        local height = waterIndex > 1 and 6 - #tileMap[waterIndex - 1] or 3

        for t = waterIndex + 2, column - 3 do
          for u = 2, height - 1 do
            tileMap[t][u] = Tile(TILE_ID_EMPTY, t, u)
          end

          tileMap[t][height] = Tile(TILE_ID_GROUND, t, height)
        end

        waterIndex = nil
      end
    else
      tileMap[column][1] = Tile(TILE_ID_WATER, column, 1)

      if waterIndex == nil then
        waterIndex = column
      end
    end
  end

  local map = TileMap(width, height, tileMap)
  local level = GameLevel(map)
  level.objects = populateEnvironment(tileMap)

  table.insert(
    level.entities,
    Snail {
      x = 10 * TILE_SIZE,
      y = VIRTUAL_HEIGHT - #tileMap[10] * TILE_SIZE - 12,
      level = level,
      tileMap = map
    }
  )

  return level
end

function populateEnvironment(tileMap)
  local objects = {}

  for column = 1, #tileMap do
    local surfaceHeight = #tileMap[column]

    -- skip water
    if surfaceHeight < 2 then
      goto continue
    end

    local bushHeight = math.random(8) % 3
    if math.random(5) > 3 then
      for y = 1, bushHeight do
        local frame = bushHeight == 2
          and (y == 1 and 1 or (math.random(3) == 1 and 4 or 2))
          or 2

        table.insert(objects, GameObject {
          x = column,
          y = surfaceHeight + y,
          texture = 'main',
          frames = 'bushes',
          frame = frame
        })
      end
    end

    if
      bushHeight ~= 1 and
      math.random(5) ~= 1
    then
      table.insert(objects, GameObject {
        x = column,
        y = surfaceHeight + 1,
        texture = 'main',
        frames = 'plants',
        frame = math.random(6)
      })
    end

    ::continue::
  end

  return objects
end