Pole = Class{__includes = Entity}

function Pole:init(opt)
  opt = opt or {}

  Entity.init(self, {
    -- position
    x = TILE_SIZE * ((opt.mapX or 1) - 1),
    y = VIRTUAL_HEIGHT - TILE_SIZE * (opt.mapY or 1),

    -- dimentions
    width = TILE_SIZE,
    height = TILE_SIZE,
    frame = opt.frame,
    frames = 'poles',
    texture = 'main',

    -- available states
    stateMachine = StateMachine {},

    -- environment
    level = opt.level
  })
end

function Pole:render()
  Entity.render(self)
end

function Pole:update(dt)
  Entity.update(self, dt)
end

--[[ helpers ]]