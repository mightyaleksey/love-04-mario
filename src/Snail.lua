Snail = Class{__includes = Entity}

function Snail:init(opt)
  opt = opt or {}

  Entity.init(self, {
    -- position
    x = opt.x or 0,
    y = opt.y or 0,

    -- dimentions
    width = 16,
    height = 12,
    frames = gFrames['snail'],
    texture = gTextures['main'],

    -- available states
    stateMachine = StateMachine {
      idle = function () return SnailIdleState(self) end,
      walking = function () return SnailWalkingState(self) end
    },

    -- environment
    tileMap = opt.tileMap
  })

  self.stateMachine:change('walking')
end

function Snail:render()
  Entity.render(self)
end

function Snail:update(dt)
  Entity.update(self, dt)
end
