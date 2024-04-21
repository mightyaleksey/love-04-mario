Tile = Class{}

function Tile:init(tileID, mapX, mapY)
  -- position
  self.x = TILE_SIZE * (mapX - 1)
  self.y = VIRTUAL_HEIGHT - TILE_SIZE * mapY
  -- dimentions
  self.width = TILE_SIZE
  self.height = TILE_SIZE

  self.mapX = mapX
  self.mapY = mapY
  self.tileID = tileID
end

function Tile:render()
  -- reset color
  love.graphics.setColor(1, 1, 1, 1)

  if self:isWater() then
    love.graphics.draw(
      gTextures['main'],
      gFrames['water'][self.tileID],
      self.x,
      self.y
    )
  end

  if self:isGround() then
    love.graphics.draw(
      gTextures['main'],
      gFrames['tiles'][183],
      self.x,
      self.y
    )

    if self.tileID == TILE_GROUND_TOP then
      love.graphics.draw(
        gTextures['main'],
        gFrames['tileTops'][387],
        self.x,
        self.y
      )
    end
  end
end

--[[ helpers ]]

function Tile:collidable()
  return self:isGround()
end

function Tile:isGround()
  return self.tileID > 20
end

function Tile:isWater()
  return self.tileID > 0 and self.tileID < 20
end