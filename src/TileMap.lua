TileMap = Class{}

-- 32 x 18: viewport size
function TileMap:init(width, height, tileMap)
  -- map size
  self.width = width
  self.height = height
  -- tiles[columns][rows]
  self.tiles = tileMap or {}

  -- set topology
  for column = 1, width do
    for row = 1, #self.tiles[column] do
      self:updateTopology(column, row)
    end
  end
end

function TileMap:render(leftX, rightX)
  leftX = math.max(leftX or 1, 1)
  rightX = math.min(rightX or self.width, self.width)

  for x = leftX, rightX do
    for y = 1, #self.tiles[x] do
      local tile = self.tiles[x][y]

      if tile == nil then
        goto continue
      end

      tile:render()

      if DEBUG == 1 then
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setFont(gFonts['small'])
        -- love.graphics.print(tostring(x), tile.x, tile.y)
        -- love.graphics.print(tostring(y), tile.x, tile.y + 6)
        love.graphics.print(tostring(x), tile.x, tile.y)
        love.graphics.print(tostring(tile.topologyID), tile.x, tile.y + 6)
      end

      ::continue::
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

function TileMap:toTopology(mapX, mapY)
  -- https://stackoverflow.com/questions/53134234/creating-2d-angled-top-down-terrain-instead-of-fully-flat/53977115#53977115
  local localTopology = {
    getTopologyID(self.tiles, mapX - 1, mapY + 1),
    getTopologyID(self.tiles, mapX, mapY + 1),
    getTopologyID(self.tiles, mapX + 1, mapY + 1),

    getTopologyID(self.tiles, mapX - 1, mapY),
    getTopologyID(self.tiles, mapX, mapY),
    getTopologyID(self.tiles, mapX + 1, mapY),

    getTopologyID(self.tiles, mapX - 1, mapY - 1),
    getTopologyID(self.tiles, mapX, mapY - 1),
    getTopologyID(self.tiles, mapX + 1, mapY - 1)
  }
  return tonumber(table.concat(localTopology), 2)
end

function TileMap:updateTopology(mapX, mapY)
  local tile = self.tiles[mapX][mapY]

  if tile and not tile:isEmpty() then
    self.tiles[mapX][mapY].topologyID = self:toTopology(mapX, mapY)
  end
end

--[[ utils ]]

function getTopologyID(map, mapX, mapY)
  return (
    map[mapX] and
    map[mapX][mapY] and
    map[mapX][mapY].tileID == TILE_ID_GROUND and
    1 or 0
  )
end