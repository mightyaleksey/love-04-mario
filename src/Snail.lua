Snail = Class{__includes = Entity}

function Snail:init(opt)
  opt = opt or {}

  Entity.init(self, {
    -- position
    x = TILE_SIZE * ((opt.mapX or 1) - 1),
    y = VIRTUAL_HEIGHT - TILE_SIZE * (opt.mapY or 1) - 12,

    -- dimentions
    width = 16,
    height = 12,
    frames = 'snail',
    texture = 'main',

    -- available states
    stateMachine = StateMachine {
      falling = function () return SnailFallingState(self) end,
      hidden = function () return SnailHiddenState(self) end,
      idle = function () return SnailIdleState(self) end,
      sliding = function () return SnailSlidingState(self) end,
      walking = function () return SnailWalkingState(self) end
    },

    -- environment
    level = opt.level
  })

  self.collidable = true

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
  local playerState = player.stateMachine.currentName

  if self.stateMachine.currentName == 'walking' then
    if playerState == 'falling' then
      self:changeState('hidden')
      player:changeState('bounce')
    elseif playerState ~= 'escaping' then
      player:changeState('escaping')
    end
  elseif self.stateMachine.currentName == 'hidden' then
    if
      playerState == 'falling' or
      playerState == 'walking'
    then
      local deltaX = self.x - player.x + 0.5 * (self.width - player.width)
      self.direction = deltaX > 0 and DIRECTION_RIGHT or DIRECTION_LEFT
      self.x = self.direction == DIRECTION_LEFT
        and player.x - self.width
        or player.x + player.width
      self:changeState('sliding')
    end
  elseif self.stateMachine.currentName == 'sliding' then
    if playerState ~= 'escaping' then
      player:changeState('escaping')
    end
  end
end