SnailFallingState = Class{__includes = BaseState}

function SnailFallingState:init(entity)
  self.animation = Animation {
    frames = { 4 },
    interval = 1
  }
  self.gravity = PLAYER_FALL_SPEED

  self.entity = entity
  self.entity.currentAnimation = self.animation
end

function SnailFallingState:update(dt)
  self.entity.dx = SNAIL_SLIDE_SPEED * (1 - 2 * self.entity.direction)
  self.entity.dy = self.entity.dy + self.gravity * dt
  self.entity.x = self.entity.x + self.entity.dx * dt
  self.entity.y = self.entity.y + self.entity.dy * dt
  if self.entity:hasWalkCollision() then
    self.entity:fixWalkPosition()
    self.entity:inverseDirection()
  end

  if
    self.entity:hasFallCollision()
  then
    self.entity:fixFallCollision()
    self.entity:changeState('sliding')
  end

  self.animation:update(dt)
end