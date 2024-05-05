Ladder = Class{__includes = Entity}

function Ladder:init(opt)
  opt = opt or {}

  Entity.init(self, {
    -- position
    x = TILE_SIZE * ((opt.mapX or 1) - 1),
    y = VIRTUAL_HEIGHT - TILE_SIZE * (opt.mapY or 1),

    -- dimentions
    width = 16,
    height = 20,
    frame = opt.frame,
    frames = 'ladder',
    texture = 'main',

    -- available states
    stateMachine = StateMachine {},

    -- environment
    level = opt.level,
    tileMap = opt.tileMap
  })

  self.collidable = true
end

function Ladder:render()
  Entity.render(self)
end

function Ladder:update(dt)
  Entity.update(self, dt)
end

--[[ helpers ]]

function Ladder:onCollide(player)
  if
    Keys.wasHolding('up') and
    player.stateMachine.currentName ~= 'climbing'
  then
    player:changeState('climbing', self)
  end
end