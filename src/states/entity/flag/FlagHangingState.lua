FlagHangingState = Class{__includes = BaseState}

function FlagHangingState:init(entity)
  self.animation = Animation {
    frames = {},
    interval = 1
  }

  self.entity = entity
  self.entity.currentAnimation = self.animation

  -- generate frames based on color
  local startFrame = 3 * (self.entity.color - 1)
  table.insert(self.animation.frames, startFrame + 3)
end

function FlagHangingState:enter()
  Timer.tween(2 * MACRO_DURATION, {
    [self.entity] = { y = self.entity.y - 2 * TILE_SIZE }
  }):finish(function ()
    self.entity:changeState('floating')
  end)
end

function FlagHangingState:update(dt)
  self.animation:update(dt)

  -- required for animations to work
  Timer.update(dt)
end