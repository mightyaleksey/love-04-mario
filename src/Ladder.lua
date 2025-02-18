Ladder = Class{__includes = Entity}

function Ladder:init(opt)
  opt = opt or {}

  Entity.init(self, {
    -- position
    mapX = opt.mapX,
    mapY = opt.mapY,

    -- dimentions
    width = 16,
    height = 20,
    frame = opt.frame,
    frames = 'ladder',
    texture = 'main',

    -- available states
    stateMachine = StateMachine {},

    -- environment
    level = opt.level
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
    (Keys.wasHolding('down') or Keys.wasHolding('up')) and
    player.stateMachine.currentName ~= 'climbing'
  then
    player:changeState('climbing', self)
  end
end