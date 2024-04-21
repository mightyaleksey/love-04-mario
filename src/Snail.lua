Snail = Class{__includes = Entity}

function Snail:init(opt)
  opt = opt or {}

  Entity.init(self, {
    -- position
    x = opt.x or 0,
    y = opt.y or 0,

    -- dimentions
    width = 16,
    height = 20,
    frames = gFrames['snail'],
    texture = gTextures['main'],

    -- available states
    stateMachine = StateMachine {},

    -- environment
    tileMap = opt.tileMap
  })

  -- self.stateMachine:change('idle')
end