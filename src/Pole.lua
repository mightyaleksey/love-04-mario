Pole = Class{__includes = Entity}

function Pole:init(opt)
  opt = opt or {}

  Entity.init(self, {
    -- position
    mapX = opt.mapX,
    mapY = opt.mapY,

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

  self.collidable = true
end

function Pole:render()
  Entity.render(self)
end

function Pole:update(dt)
  Entity.update(self, dt)
end

--[[ helpers ]]

function Pole:onCollide(player)
  if self.level.collectedFlags == self.level.availableFlags then
    player:changeState('hanging')
  end
end