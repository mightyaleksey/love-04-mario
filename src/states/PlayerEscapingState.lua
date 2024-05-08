PlayerEscapingState = Class{__includes = BaseState}

function PlayerEscapingState:init(entity)
  self.animation = Animation {
    frames = { 5 },
    interval = 1
  }
  self.gravity = PLAYER_FALL_SPEED

  self.entity = entity
  self.entity.currentAnimation = self.animation
end

function PlayerEscapingState:enter()
  self.entity.dy = -math.floor(0.3 * PLAYER_JUMP_VELOCITY)
end

function PlayerEscapingState:update(dt)
  self.entity.dy = self.entity.dy + self.gravity * dt
  self.entity.dx = PLAYER_WALK_SPEED * (1 - 2 * self.entity.direction)
  self.entity.x = self.entity.x + self.entity.dx * dt
  self.entity.y = self.entity.y + self.entity.dy * dt
end