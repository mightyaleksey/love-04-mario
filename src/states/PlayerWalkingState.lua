PlayerWalkingState = Class{__includes = BaseState}

function PlayerWalkingState:init(entity)
  self.animation = Animation {
    frames = { 11, 10 },
    interval = 0.2
  }

  self.entity = entity
  self.entity.currentAnimation = self.animation
end

function PlayerWalkingState:update(dt)
  if
    Keys.wasPressed('left') or
    Keys.wasPressed('right')
  then
    self.entity.direction = Keys.wasPressed('left')
      and DIRECTION_LEFT or DIRECTION_RIGHT
  elseif
    not Keys.wasPressed('left') and
    not Keys.wasPressed('right')
  then
    self.entity:changeState('idle')
  end

  if Keys.wasPressed('space') then
    self.entity:changeState('jump')
  end

  self.entity.dx = 60 * (1 - 2 * self.entity.direction)
  self.entity.x = self.entity.x + self.entity.dx * dt

  self.animation:update(dt)
end