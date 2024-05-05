PlayerClimbingState = Class{__includes = BaseState}

function PlayerClimbingState:init(entity)
  self.animation = Animation {
    frames = { 6, 7 },
    interval = 0.3
  }

  self.entity = entity
  self.entity.currentAnimation = self.animation
  self.ladder = nil
end

function PlayerClimbingState:enter(ladder)
  self.ladder = ladder
end

function PlayerClimbingState:update(dt)

  if
    Keys.wasHolding('left') or
    Keys.wasHolding('right')
  then
    self.entity.dx = Keys.wasHolding('right') and PLAYER_CLIMB_SPEED or -PLAYER_CLIMB_SPEED
    self.entity.x = self.entity.x + self.entity.dx * dt
  end

  if
    Keys.wasHolding('down') or
    Keys.wasHolding('up')
  then
    self.entity.dy = Keys.wasHolding('down') and PLAYER_CLIMB_SPEED or -PLAYER_CLIMB_SPEED
    self.entity.y = self.entity.y + self.entity.dy * dt

    self.animation:update(dt)
  end

  if Keys.wasPressed('space') then
    self.entity:changeState('jump')
  end

  if not collides(self.entity, self.ladder) then
    self.entity:changeState('falling')
  end
end