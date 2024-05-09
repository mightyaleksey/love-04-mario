Key = Class{__includes = Entity}

function Key:init(opt)
  opt = opt or {}

  Entity.init(self, {
    -- position
    mapX = opt.mapX,
    mapY = opt.mapY,

    -- dimentions
    width = TILE_SIZE,
    height = TILE_SIZE,
    frame = opt.frame or 1,
    frames = 'keys',
    texture = 'main',

    -- available states
    stateMachine = StateMachine {},

    -- environment
    level = opt.level
  })

  self.consumable = true
end

function Key:render()
  Entity.render(self)
end

function Key:update(dt)
  Entity.update(self, dt)
end