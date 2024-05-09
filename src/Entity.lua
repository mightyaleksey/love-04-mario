Entity = Class{}

function Entity:init(opt)
  -- position
  defineProperties(self, opt, { 'x', 'y' })
  -- dimensions
  defineProperties(self, opt, { 'width', 'height', 'frames', 'texture', 'stateMachine' })
  -- environment
  defineProperties(self, opt, { 'level' })

  self.collidable = false
  self.consumable = false
  self.solid = false

  -- rendering
  self.currentAnimation = nil
  self.inverseAnimation = 0 -- 0 no inverse, 1 inverse
  self.direction = DIRECTION_RIGHT
  self.frame = opt.frame

  -- velocity
  self.dx = 0
  self.dy = 0
end

function Entity:render()
  -- reset color
  love.graphics.setColor(1, 1, 1, 1)

  love.graphics.draw(
    gTextures[self.texture],
    gFrames[self.frames][self.currentAnimation
      and self.currentAnimation:getCurrentFrame()
      or self.frame],
    self.x + inverse(self.direction, self.inverseAnimation) * self.width,
    self.y,
    0, -- rotate
    1 - 2 * inverse(self.direction, self.inverseAnimation), -- scaleX
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

function Entity:getTile(offsetX, offsetY)
  -- point position: [   ]
  --  bottom-middle: [ x ]
  return self.level.tileMap:pointToTile(
    self.x + 0.5 * self.width + (offsetX or 0),
    self.y + self.height + (offsetY or 0)
  )
end

function Entity:inverseDirection()
  self.direction = self.direction == DIRECTION_LEFT
    and DIRECTION_RIGHT or DIRECTION_LEFT
end

function Entity:hasFallCollision()
  local bottomLeftTile = self:getTile(2 - 0.5 * self.width, 1)

  if
    bottomLeftTile and
    bottomLeftTile:collidable()
  then
    return true
  end

  local bottomRightTile = self:getTile(0.5 * self.width - 2, 1)

  if
    bottomRightTile and
    bottomRightTile:collidable()
  then
    return true
  end

  return false
end

function Entity:fixFallCollision()
  local bottomLeftTile = self:getTile(1 - 0.5 * self.width, 1)
  local bottomRightTile = self:getTile(0.5 * self.width - 1, 1)
  local groundY = math.min(
    bottomLeftTile and bottomLeftTile.y or VIRTUAL_HEIGHT,
    bottomRightTile and bottomRightTile.y or VIRTUAL_HEIGHT
  )

  self.dy = 0
  self.y = groundY - self.height
end

function Entity:hasWalkCollision()
  local horizontalTile = self:getTile(
    self.direction == DIRECTION_LEFT
      and -(1 + 0.5 * self.width)
      or 0.5 * self.width,
    -2
  )

  return (
    horizontalTile and
    horizontalTile:collidable() and
    collides(self, horizontalTile)
  )
end

function Entity:fixWalkPosition()
  local horizontalTile = self:getTile(
    self.direction == DIRECTION_LEFT
      and -(1 + 0.5 * self.width)
      or 0.5 * self.width,
    -2
  )

  self.dx = 0
  self.x = self.direction == DIRECTION_LEFT
    and math.max(horizontalTile.x + horizontalTile.width, self.x)
    or math.min(horizontalTile.x - self.width, self.x)
end

--[[ utils ]]

function inverse(a, b)
  -- updates direction modifier
  -- uses exclusive or

  if b == 1 then
    return 1 - a
  end

  return a
end