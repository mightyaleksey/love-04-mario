TileMap = Class{}

-- 32 x 18: viewport size
function TileMap:init(width, height)
  -- map size
  self.width = width
  self.height = height
  -- tiles[columns][rows]
  self.tiles = {}
end

function TileMap:render(scrollX)
  -- render only visible map
  local leftX = math.max(math.floor(scrollX / TILE_SIZE), 1)
  local rightX = math.min(math.floor((scrollX + VIRTUAL_WIDTH) / TILE_SIZE) + 1, self.width)

  for x = leftX, rightX do
    for y = 1, #self.tiles[x] do
      self.tiles[x][y]:render()
    end
  end
end

--[[ helpers ]]

function TileMap:pointToMap(x, y)
  local mapX = math.floor(x / TILE_SIZE) + 1
  local mapY = math.floor((VIRTUAL_HEIGHT - y) / TILE_SIZE) + 1
  return mapX, mapY
end

function TileMap:pointToTile(x, y)
  local column, row = self:pointToMap(x, y)

  if
    column < 1 or column > self.width or
    row < 1 or row > self.height
  then
    return nil
  end

  return self.tiles[column][row]
end
