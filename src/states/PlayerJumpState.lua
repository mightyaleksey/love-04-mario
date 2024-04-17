PlayerJumpState = Class{__includes = BaseState}

function PlayerJumpState:init(entity)
  self.animation = Animation {
    frames = { 3 },
    interval = 1
  }
  self.gravity = 6

  self.entity = entity
  self.entity.currentAnimation = self.animation
end

function PlayerJumpState:enter()
  self.entity.dy = -150
end

function PlayerJumpState:update(dt)
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

  if self.entity.dy >= 0 then
    self.entity.stateMachine:change('falling')
  end

  self.animation:update(dt)
end