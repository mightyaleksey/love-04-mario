PlayerJumpState = Class{__includes = BaseState}

function PlayerJumpState:init(entity)
  self.animation = Animation {
    frames = { 3 },
    interval = 1
  }
  self.gravity = PLAYER_FALL_SPEED

  self.entity = entity
  self.entity.currentAnimation = self.animation
end

function PlayerJumpState:enter()
  gSounds['jump']:play()
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
    self.entity.x = math.min(
      math.max(self.entity.x + self.entity.dx * dt, 0),
      TILE_SIZE * self.entity.level.tileMap.width - self.entity.width
    )
    if self.entity:hasWalkCollision() then
      self.entity:fixWalkPosition()
    end
  else
    self.entity.dx = 0
  end

  -- update state
  self.entity.dy = self.entity.dy + self.gravity * dt
  self.entity.y = self.entity.y + self.entity.dy * dt

  if self.entity.dy >= 0 then
    self.entity:changeState('falling')
  end

  self.animation:update(dt)
end