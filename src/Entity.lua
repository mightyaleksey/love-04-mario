Entity = Class{}

function Entity:init(opt)
  -- position
  defineProperties(self, opt, { 'x', 'y' })
  -- dimensions
  defineProperties(self, opt, { 'width', 'height', 'frames', 'texture', 'stateMachine' })
  -- environment
  defineProperties(self, opt, { 'tileMap' })

  self.currentAnimation = nil
  self.direction = DIRECTION_LEFT

  -- velocity
  self.dx = 0
  self.dy = 0
end

function Entity:render()
  love.graphics.draw(
    self.texture,
    self.frames[self.currentAnimation:getCurrentFrame()],
    self.x + self.direction * self.width,
    self.y,
    0, -- rotate
    1 - 2 * self.direction, -- scaleX
    1 -- scaleY
  )
end

function Entity:update(dt)
  self.stateMachine:update(dt)
end

--[[ helpers ]]

function Entity:changeState(name, opt)
  self.stateMachine:change(name, opt)
end

function Entity:getBottomLeftTile()
  return self.tileMap:pointToTile(
    self.x + 1,
    self.y + self.height + 1
  )
end

function Entity:getBottomRightTile()
  return self.tileMap:pointToTile(
    self.x + self.width - 1,
    self.y + self.height + 1
  )
end

function Entity:getLeftTile()
  -- technically Y should be reduced by tile size as well,
  -- however, in this particular setup jumps work better
  return self.tileMap:pointToTile(
    self.x - 2,
    self.y + self.height - 2
  )
end

function Entity:getRightTile()
  -- technically Y should be reduced by tile size as well,
  -- however, in this particular setup jumps work better
  return self.tileMap:pointToTile(
    self.x + self.width + 2,
    self.y + self.height - 2
  )
end
