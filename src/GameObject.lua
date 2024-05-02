GameObject = Class{}

function GameObject:init(opt)
  -- position
  self.x = TILE_SIZE * (opt.mapX - 1)
  self.y = VIRTUAL_HEIGHT - TILE_SIZE * opt.mapY
  -- dimensions
  self.width = opt.width or TILE_SIZE
  self.height = opt.height or TILE_SIZE
  self.frame = opt.frame or 1
  self.frames = opt.frames
  self.texture = 'main'
  -- map coordinates
  defineProperties(self, opt, { 'mapX', 'mapY' })
end

function GameObject:render()
  love.graphics.draw(
    gTextures[self.texture],
    gFrames[self.frames][self.frame],
    self.x,
    self.y
  )
end