PlayerIdleState = Class{__includes = BaseState}

function PlayerIdleState:init(entity)
  self.animation = Animation {
    frames = { 1 },
    interval = 1
  }

  self.entity = entity
  self.entity.currentAnimation = self.animation
end

function PlayerIdleState:update(dt)
  if
    Keys.wasHolding('left') or
    Keys.wasHolding('right')
  then
    self.entity:changeState('walking')
  end

  if Keys.wasPressed('space') then
    self.entity:changeState('jump')
  end

  self.animation:update(dt)
end