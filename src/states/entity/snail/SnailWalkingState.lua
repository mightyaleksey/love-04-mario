SnailWalkingState = Class{__includes = BaseState}

function SnailWalkingState:init(entity)
  self.animation = Animation {
    frames = { 1, 2 },
    interval = 0.4
  }

  self.entity = entity
  self.entity.currentAnimation = self.animation
end

function SnailWalkingState:update(dt)
  self.entity.dx = SNAIL_WALK_SPEED * (1 - 2 * self.entity.direction)
  self.entity.x = math.max(self.entity.x + self.entity.dx * dt, 0)

  if self.entity:hasWalkCollision() then
    self.entity:fixWalkPosition()
    self.entity:inverseDirection()
  end

  -- check edges
  local horizontalTile = self.entity:getTile(
    self.entity.direction == DIRECTION_LEFT
      and -(1 + 0.5 * self.entity.width)
      or 0.5 * self.entity.width,
    1
  )

  if
    not horizontalTile or
    not horizontalTile:collidable()
  then
    self.entity.direction = self.entity.direction == DIRECTION_LEFT
      and DIRECTION_RIGHT or DIRECTION_LEFT
  end

  self.animation:update(dt)
end