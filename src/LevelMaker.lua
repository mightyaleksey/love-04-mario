function isGroundPredicate(tile)
  return tile and tile:isGround()
end

function isIslandPredicate(column)
  return not column[1]:isWater()
end

function isSurfacePredicate(column)
  for index = 2, math.min(4, #column) do
    if column[index]:isGround() then
      return true
    end
  end

  return false
end

function generateEnvironment(collection, columnStart, columnEnd, row)
  for column = columnStart, columnEnd do
    local bushHeight = math.random(8) % 3
    if math.random(5) > 3 then
      for y = 1, bushHeight do
        local frame = bushHeight == 2
          and (y == 1 and 1 or (math.random(3) == 1 and 4 or 2))
          or 2

        table.insert(collection, BushGameObject {
          mapX = column,
          mapY = row + y,
          frame = frame
        })
      end
    end

    if
      bushHeight ~= 1 and
      math.random(5) ~= 1
    then
      table.insert(collection, PlantGameObject {
        mapX = column,
        mapY = row + 1,
        frame = math.random(6)
      })
    end
  end
end

local enemyDistance = math.random(5, 9)

function generateEnemies(collection, level, columnStart, columnEnd, row)
  for column = columnStart, columnEnd do
    if enemyDistance == 0 then
      table.insert(collection, Snail {
        mapX = column,
        mapY = row,

        -- environment
        level = level,
        tileMap = level.tileMap
      })

      enemyDistance = math.random(5, 9)
    end

    enemyDistance = enemyDistance - 1
  end
end

--[[ implementation ]]

LevelMaker = Class{}

-- 32 x 18: viewport size
function LevelMaker.generate(width, height)
  -- sets seed, so the level generation will reproducable
  -- math.randomseed(width, height)

  -- tiles[columns][rows]
  local tiles = {}

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
    table.insert(tiles, {})

    if surface[column] > 0 then
      for row = 1, surface[column] do
        tiles[column][row] = Tile(TILE_ID_GROUND, column, row)
      end

      if waterIndex == 1 then
        waterIndex = nil
      end

      if waterIndex ~= nil then
        local height = waterIndex > 1 and 6 - #tiles[waterIndex - 1] or 3

        for t = waterIndex + 2, column - 3 do
          for u = 2, height - 1 do
            tiles[t][u] = Tile(TILE_ID_EMPTY, t, u)
          end

          tiles[t][height] = Tile(TILE_ID_GROUND, t, height)
        end

        waterIndex = nil
      end
    else
      tiles[column][1] = Tile(TILE_ID_WATER, column, 1)

      if waterIndex == nil then
        waterIndex = column
      end
    end
  end


  local lastIslandTile = findLastIndex(tiles, isIslandPredicate)

  -- find flag pole position
  local polePosition = lastIslandTile - 2

  if #tiles[polePosition] == 1 then
    -- in case last island is short and pole ends in water, repeat the step
    polePosition = findLastIndex(tiles, isIslandPredicate, polePosition) - 2
  end

  -- add floating island
  local floatingIslandHeight = 9
  local ladderPosition = findIndex(tiles, isSurfacePredicate, polePosition - 7)
  local ladderStart = findLastIndex(tiles[ladderPosition], isGroundPredicate, floatingIslandHeight - 1)

  for column = polePosition - 8, polePosition - 3 do
    -- fill gaps in array
    for row = #tiles[column] + 1, floatingIslandHeight - 1 do
      tiles[column][row] = Tile(TILE_ID_EMPTY, column, row)
    end

    tiles[column][floatingIslandHeight] = Tile(TILE_ID_GROUND, column, floatingIslandHeight)
  end

  -- generate level
  local tileMap = TileMap(width, height, tiles)
  local level = GameLevel(tileMap)

  -- add ladder
  for f = ladderStart + 1, floatingIslandHeight do
    table.insert(level.entities, Ladder {
      mapX = ladderPosition,
      mapY = f,
      frame = f == floatingIslandHeight and 1 or 2,

      -- environment
      level = level,
      tileMap = level.tileMap
    })
  end

  -- add pole
  local surfaceHeight = #tiles[polePosition]
  for f = 1, 3 do
    table.insert(level.entities, Pole {
      mapX = polePosition,
      mapY = surfaceHeight + f,
      frame = 4 - f,

      -- environment
      level = level,
      tileMap = level.tileMap
    })
  end

  -- generate world
  local surfaceHeight = nil
  local columnStart = nil

  for column = 1, width do
    local currentHeight = surface[column]
    -- double check water level
    if currentHeight == 0 then
      currentHeight = findLastIndex(tiles[column], isGroundPredicate, floatingIslandHeight - 1)
    end

    if (currentHeight ~= surfaceHeight) then
      if surfaceHeight and surfaceHeight > 1 then
        generateEnvironment(level.objects, columnStart, column - 1, surfaceHeight)
        generateEnemies(level.entities, level, columnStart, column - 1, surfaceHeight)
      end

      surfaceHeight = currentHeight
      columnStart = column
    end
  end

  -- for the floating island
  generateEnvironment(level.objects, polePosition - 8, polePosition - 3, floatingIslandHeight)

  return level
end
