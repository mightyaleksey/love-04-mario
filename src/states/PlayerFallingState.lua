PlayerFallingState = Class{__includes = BaseState}

function PlayerFallingState:init(entity)
  self.animation = Animation {
    frames = { 4 },
    interval = 1
  }
  self.gravity = 6

  self.entity = entity
  self.entity.currentAnimation = self.animation
end

function PlayerFallingState:update(dt)
  if
    Keys.wasPressed('left') or
    Keys.wasPressed('right')
  then
    self.entity.direction = Keys.wasPressed('left')
      and DIRECTION_LEFT or DIRECTION_RIGHT
    self.entity.dx = 60 * (1 - 2 * self.entity.direction)
  else
    self.entity.dx = 0
  end

  self.entity.dy = self.entity.dy + self.gravity
  self.entity.y = self.entity.y + self.entity.dy * dt
  self.entity.x = self.entity.x + self.entity.dx * dt

  if self.entity.y > 100 then
    self.entity.y = 100
    self.entity:changeState('idle')
  end

  self.animation:update(dt)
end