SnailEscapingState = Class{__includes = BaseState}

function SnailEscapingState:init(entity)
  self.animation = Animation {
    frames = { 4 },
    interval = 1
  }
  self.gravity = PLAYER_FALL_SPEED

  self.entity = entity
  self.entity.currentAnimation = self.animation
end

function SnailEscapingState:enter()
  self.entity.dx = SNAIL_SLIDE_SPEED * (1 - 2 * self.entity.direction)
  self.entity.dy = self.gravity
end

function SnailEscapingState:update(dt)
  self.entity.dy = self.entity.dy + self.gravity
  self.entity.x = self.entity.x + self.entity.dx * dt
  self.entity.y = self.entity.y + self.entity.dy * dt

  self.animation:update(dt)
end