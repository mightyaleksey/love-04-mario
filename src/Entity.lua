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