SnailIdleState = Class{__includes = BaseState}

function SnailIdleState:init(entity)
  self.animation = Animation {
    frames = { 1 },
    interval = 1
  }

  self.entity = entity
  self.entity.currentAnimation = self.animation
end

function SnailIdleState:update(dt)
  self.animation:update(dt)
end