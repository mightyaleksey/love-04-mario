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
  self.entity.dx = SNAIL_WALK_SPEED
  self.entity.x = math.max(self.entity.x + self.entity.dx * dt, 0)

  self.animation:update(dt)
end