Player = Class{__includes = Entity}

function Player:init(opt)
  opt = opt or {}

  Entity.init(self, {
    -- position
    x = opt.x or 0,
    y = opt.y or 0,

    -- dimentions
    width = 16,
    height = 20,
    frames = gFrames['player'],
    texture = gTextures['main'],

    -- available states
    stateMachine = StateMachine {
      falling = function () return PlayerFallingState(self) end,
      idle = function () return PlayerIdleState(self) end,
      jump = function () return PlayerJumpState(self) end,
      walking = function () return PlayerWalkingState(self) end
    },

    -- environment
    tileMap = opt.tileMap
  })

  self.stateMachine:change('idle')
end

function Player:render()
  Entity.render(self)
end

function Player:update(dt)
  Entity.update(self, dt)
end