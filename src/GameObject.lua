GameObject = Class{}

function GameObject:init(opt)
  local x = opt.x or 0
  local y = opt.y or 0
  -- position
  self.x = TILE_SIZE * (x - 1)
  self.y = VIRTUAL_HEIGHT - TILE_SIZE * y
  -- dimentions
  self.width = TILE_SIZE
  self.height = TILE_SIZE
  self.frame = opt.frame
  self.frames = opt.frames
  self.texture = opt.texture
  -- map coordinates
  self.mapX = x
  self.mapY = y
end

function GameObject:render()
  love.graphics.draw(
    gTextures[self.texture],
    gFrames[self.frames][self.frame],
    self.x,
    self.y
  )
end