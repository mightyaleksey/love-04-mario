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

  -- initialize matrix
  for column = 1, width do
    table.insert(tileMap, {})
  end

  local islandLength = 0

  -- generate ground
  local column = math.random(0, 5)
  while column <= width do
    if islandLength == 0 then
      islandLength = math.random(10, 20)
    end

    -- todo: convert IDs to Tiles
    tileMap[column][2] = TILE_GROUND_DEPTH

    if islandLength == 1 then
      column = column + math.random(2, 10)
    end

    islandLength = islandLength - 1
    column = column + 1
  end

  -- normalize surface
  for column = 1, width do
    local surfaceIndex = findKey(tileMap[column],
      function (elem) return elem == TILE_GROUND_DEPTH end)

    if surfaceIndex == nil then
      tileMap[column][1] = Tile(TILE_WATER_TOP, column, 1)
    else
      for row = 1, surfaceIndex do
        tileMap[column][row] = Tile(TILE_GROUND_DEPTH, column, row)
      end

      tileMap[column][surfaceIndex] = Tile(TILE_GROUND_TOP, column, surfaceIndex)
    end
  end

  local map = TileMap(width, height)
  map.tiles = tileMap

  return map
end

-- [0, 0]: left bottom corner
function LevelMaker.renderTile(tileID, mapX, mapY)
  if tileID > 0 and tileID < 20 then
    love.graphics.draw(
      gTextures['main'], gFrames['water'][tileID],
      TILE_SIZE * (mapX - 1), VIRTUAL_HEIGHT - TILE_SIZE * mapY
    )
  end

  if tileID > 20 then
    love.graphics.draw(
      gTextures['main'], gFrames['tiles'][183],
      TILE_SIZE * (mapX - 1), VIRTUAL_HEIGHT - TILE_SIZE * mapY
    )

    if tileID == TILE_GROUND_TOP then
      love.graphics.draw(
        gTextures['main'], gFrames['tileTops'][191],
        TILE_SIZE * (mapX - 1), VIRTUAL_HEIGHT - TILE_SIZE * mapY
      )
    end
  end
end