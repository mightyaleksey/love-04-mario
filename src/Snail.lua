Snail = Class{__includes = Entity}

function Snail:init(opt)
  opt = opt or {}

  Entity.init(self, {
    -- position
    x = opt.x or 0,
    y = opt.y or 0,

    -- dimentions
    width = 16,
    height = 12,
    frames = gFrames['snail'],
    texture = gTextures['main'],

    -- available states
    stateMachine = StateMachine {
      falling = function () return SnailFallingState(self) end,
      hidden = function () return SnailHiddenState(self) end,
      idle = function () return SnailIdleState(self) end,
      sliding = function () return SnailSlidingState(self) end,
      walking = function () return SnailWalkingState(self) end
    },

    -- environment
    level = opt.level,
    tileMap = opt.tileMap
  })

  self.inverseAnimation = 1
  self.direction = DIRECTION_RIGHT

  self:changeState('walking')
end

function Snail:render()
  Entity.render(self)
end

function Snail:update(dt)
  Entity.update(self, dt)
end

--[[ helpers ]]

function Snail:onCollide(player)
  if self.stateMachine.currentName == 'walking' then
    if player.stateMachine.currentName == 'falling' then
      self:changeState('hidden')
      player:changeState('bounce')
    else
      player:changeState('escaping')
    end
  elseif self.stateMachine.currentName == 'hidden' then
    if
      player.stateMachine.currentName == 'falling' or
      player.stateMachine.currentName == 'walking'
    then
      local deltaX = self.x - player.x + 0.5 * (self.width - player.width)
      self.direction = deltaX > 0 and DIRECTION_RIGHT or DIRECTION_LEFT
      self.x = self.direction == DIRECTION_LEFT
        and player.x - self.width
        or player.x + player.width
      self:changeState('sliding')
    end
  elseif self.stateMachine.currentName == 'sliding' then
    player:changeState('escaping')
  end
end