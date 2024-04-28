SnailSlidingState = Class{__includes = BaseState}

function SnailSlidingState:init(entity)
  self.animation = Animation {
    frames = { 4 },
    interval = 1
  }

  self.entity = entity
  self.entity.currentAnimation = self.animation
end

function SnailSlidingState:enter()
  self.entity.dx = SNAIL_SLIDE_SPEED * (1 - 2 * self.entity.direction)
end

function SnailSlidingState:update(dt)
  self.entity.x = self.entity.x + self.entity.dx * dt

  if
    self.entity:hasWalkCollision() or
    not self.entity:hasFallCollision()
  then
    self.entity:changeState('escaping')
  end

  self.animation:update(dt)
end