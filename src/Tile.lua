Tile = Class{}

function Tile:init(tileID, mapX, mapY)
  -- position
  self.x = TILE_SIZE * (mapX - 1)
  self.y = VIRTUAL_HEIGHT - TILE_SIZE * mapY
  -- dimentions
  self.width = TILE_SIZE
  self.height = TILE_SIZE

  self.tileID = tileID
  self.topologyID = nil
end

function Tile:render()
  -- reset color
  love.graphics.setColor(1, 1, 1, 1)

  if self:isGround() then
    love.graphics.draw(
      gTextures['main'],
      gFrames['tiles'][getTileID(self.topologyID)],
      self.x,
      self.y
    )

    local tileTop = getTileTopID(self.topologyID)
    if tileTop then
      love.graphics.draw(
        gTextures['main'],
        gFrames['tileTops'][tileTop],
        self.x,
        self.y
      )
    end
  end

  if self:isWater() then
    love.graphics.draw(
      gTextures['main'],
      gFrames['water'][7],
      self.x,
      self.y
    )
  end
end

--[[ helpers ]]

function Tile:collidable()
  return self:isGround()
end

function Tile:isGround()
  return self.tileID == TILE_ID_GROUND
end

function Tile:isWater()
  return self.tileID == TILE_ID_WATER
end

--[[ utils ]]

local topMask = 504
local isTop = { 16, 56, 120, 312, 376 }
local isTopLeft = { 24, 88 }
local isTopRight = { 48, 304 }

function getTileID(topologyID)
  return 277
end

function getTileTopID(topologyID)
  local patternTop = bit.band(topologyID, topMask)

  if includes(isTopLeft, patternTop) then
    return 386
  end

  if includes(isTopRight, patternTop) then
    return 388
  end

  if includes(isTop, patternTop) then
    return 387
  end
end