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
  -- handle input
  if
    Keys.wasHolding('left') or
    Keys.wasHolding('right')
  then
    self.entity.direction = Keys.wasHolding('left')
      and DIRECTION_LEFT or DIRECTION_RIGHT
  elseif
    not Keys.wasHolding('left') and
    not Keys.wasHolding('right')
  then
    self.entity:changeState('idle')
  end

  if Keys.wasPressed('space') then
    self.entity:changeState('jump')
  end

  -- update state
  self.entity.dx = PLAYER_WALK_SPEED * (1 - 2 * self.entity.direction)
  self.entity.x = math.min(
    math.max(self.entity.x + self.entity.dx * dt, 0),
    TILE_SIZE * self.entity.level.tileMap.width - self.entity.width
  )
  if self.entity:hasWalkCollision() then
    self.entity:fixWalkPosition()
  end

  if not self.entity:hasFallCollision() then
    self.entity:changeState('falling')
  end

  self.animation:update(dt)
end