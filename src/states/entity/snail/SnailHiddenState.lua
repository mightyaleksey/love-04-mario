SnailHiddenState = Class{__includes = BaseState}

function SnailHiddenState:init(entity)
  self.animation = Animation {
    frames = { 3 },
    interval = 1
  }

  self.entity = entity
  self.entity.currentAnimation = self.animation
end

function SnailHiddenState:update(dt)
  self.animation:update(dt)
end