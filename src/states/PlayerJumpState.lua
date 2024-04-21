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
  self.entity.dy = -PLAYER_JUMP_VELOCITY
end

function PlayerJumpState:update(dt)
  -- handle input
  if
    Keys.wasHolding('left') or
    Keys.wasHolding('right')
  then
    self.entity.direction = Keys.wasHolding('left')
      and DIRECTION_LEFT or DIRECTION_RIGHT
    self.entity.dx = PLAYER_WALK_SPEED * (1 - 2 * self.entity.direction)
    self.entity.x = math.max(self.entity.x + self.entity.dx * dt, 0)
    self.entity:checkHorizontalCollisions()
  else
    self.entity.dx = 0
  end

  -- update state
  self.entity.dy = self.entity.dy + self.gravity
  self.entity.y = self.entity.y + self.entity.dy * dt

  if self.entity.dy >= 0 then
    self.entity:changeState('falling')
  end

  self.animation:update(dt)
end