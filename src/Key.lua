Key = Class{__includes = Entity}

function Key:init(opt)
  opt = opt or {}

  Entity.init(self, {
    -- position
    x = TILE_SIZE * ((opt.mapX or 1) - 1),
    y = VIRTUAL_HEIGHT - TILE_SIZE * (opt.mapY or 1),

    -- dimentions
    width = TILE_SIZE,
    height = TILE_SIZE,
    frame = opt.frame or 1,
    frames = 'keys',
    texture = 'main',

    -- available states
    stateMachine = StateMachine {},

    -- environment
    level = opt.level,
    tileMap = opt.tileMap
  })

  self.consumable = true
end

function Key:render()
  Entity.render(self)
end

function Key:update(dt)
  Entity.update(self, dt)
end