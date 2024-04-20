PlayerFallingState = Class{__includes = BaseState}

function PlayerFallingState:init(entity)
  self.animation = Animation {
    frames = { 4 },
    interval = 1
  }
  self.gravity = PLAYER_FALL_SPEED

  self.entity = entity
  self.entity.currentAnimation = self.animation
end

function PlayerFallingState:update(dt)
  -- handle input
  if
    Keys.wasPressed('left') or
    Keys.wasPressed('right')
  then
    self.entity.direction = Keys.wasPressed('left')
      and DIRECTION_LEFT or DIRECTION_RIGHT
    self.entity.dx = PLAYER_WALK_SPEED * (1 - 2 * self.entity.direction)
    self.entity.x = math.max(self.entity.x + self.entity.dx * dt, 0)
    self.entity:checkHorizontalCollisions()
  else
    self.entity.dx = 0
  end

  -- check landing
  local tileBottomLeft = self.entity:getBottomLeftTile()
  local tileBottomRight = self.entity:getBottomRightTile()

  if
    (tileBottomLeft and tileBottomLeft:collidable()) or
    (tileBottomRight and tileBottomRight:collidable())
  then
    self.entity.y = (tileBottomLeft or tileBottomRight).y - self.entity.height
    self.entity:changeState('idle')
  else
    -- update state
    self.entity.dy = self.entity.dy + self.gravity
    self.entity.y = self.entity.y + self.entity.dy * dt
  end

  self.animation:update(dt)

  if self.entity.y > VIRTUAL_HEIGHT then
    gStateMachine:change('play')
  end
end