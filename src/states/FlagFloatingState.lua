FlagFloatingState = Class{__includes = BaseState}

function FlagFloatingState:init(entity)
  self.animation = Animation {
    frames = {},
    interval = 0.3
  }

  self.entity = entity
  self.entity.currentAnimation = self.animation

  -- generate frames based on color
  local startFrame = 3 * (self.entity.color - 1)
  for f = startFrame + 1, startFrame + 2 do
    table.insert(self.animation.frames, f)
  end
end

function FlagFloatingState:enter()
  -- update level state
  self.entity.level.collectedFlags = self.entity.level.collectedFlags + 1
end

function FlagFloatingState:update(dt)
  self.animation:update(dt)
end