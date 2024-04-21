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
  self.entity.x = math.max(self.entity.x + self.entity.dx * dt, 0)
  self.entity:checkHorizontalCollisions()

  self.animation:update(dt)

  -- check falling
  local tileBottomLeft = self.entity:getBottomLeftTile()
  local tileBottomRight = self.entity:getBottomRightTile()

  if
    (not tileBottomLeft or not tileBottomLeft:collidable()) and
    (not tileBottomRight or not tileBottomRight:collidable())
  then
    self.entity:changeState('falling')
  end
end