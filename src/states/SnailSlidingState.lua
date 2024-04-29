SnailSlidingState = Class{__includes = BaseState}

function SnailSlidingState:init(entity)
  self.animation = Animation {
    frames = { 4 },
    interval = 1
  }

  self.entity = entity
  self.entity.currentAnimation = self.animation
end

function SnailSlidingState:update(dt)
  self.entity.dx = SNAIL_SLIDE_SPEED * (1 - 2 * self.entity.direction)
  self.entity.x = self.entity.x + self.entity.dx * dt

  if self.entity:hasWalkCollision() then
    self.entity:inverseDirection()
  end

  if not self.entity:hasFallCollision() then
    self.entity:changeState('falling')
  end

  self.animation:update(dt)
end