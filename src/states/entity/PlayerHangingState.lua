PlayerHangingState = Class{__includes = BaseState}

function PlayerHangingState:init(entity)
  self.animation = Animation {
    frames = { 8 },
    interval = 1
  }

  self.entity = entity
  self.entity.currentAnimation = self.animation
end

function PlayerHangingState:update(dt)
  self.animation:update(dt)
end