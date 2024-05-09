Flag = Class{__includes = Entity}

function Flag:init(opt)
  opt = opt or {}

  Entity.init(self, {
    -- position
    mapX = opt.mapX,
    mapY = opt.mapY,
    x = TILE_SIZE * ((opt.mapX or 1) - 1) + 8,

    -- dimentions
    width = TILE_SIZE,
    height = TILE_SIZE,
    frames = 'flags',
    texture = 'main',

    -- available states
    stateMachine = StateMachine {
      floating = function () return FlagFloatingState(self) end,
      hanging = function () return FlagHangingState(self) end
    },

    -- environment
    level = opt.level
  })

  self.color = opt.color or 1

  self:changeState('hanging')
end

function Flag:render()
  Entity.render(self)
end

function Flag:update(dt)
  Entity.update(self, dt)
end