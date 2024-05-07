Flag = Class{__includes = Entity}

function Flag:init(opt)
  opt = opt or {}

  Entity.init(self, {
    -- position
    x = TILE_SIZE * ((opt.mapX or 1) - 1),
    y = VIRTUAL_HEIGHT - TILE_SIZE * (opt.mapY or 1),

    -- dimentions
    width = TILE_SIZE,
    height = TILE_SIZE,
    frame = opt.frame or 1,
    frames = 'flags',
    texture = 'main',

    -- available states
    stateMachine = StateMachine {},

    -- environment
    level = opt.level,
    tileMap = opt.tileMap
  })
end

function Flag:render()
  Entity.render(self)
end

function Flag:update(dt)
  Entity.update(self, dt)
end