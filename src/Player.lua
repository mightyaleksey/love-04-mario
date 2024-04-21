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

  -- self.stateMachine:change('falling')
  self.stateMachine:change('idle')
end

function Player:render()
  Entity.render(self)
end

function Player:update(dt)
  Entity.update(self, dt)
end

--[[ helpers ]]

function Player:checkHorizontalCollisions()
  if self.direction == DIRECTION_LEFT then
    local leftTile = self:getLeftTile()

    if
      leftTile and
      leftTile:collidable() and
      collides(self, leftTile)
    then
      self.dx = 0
      self.x = leftTile.x + leftTile.width
    end
  else
    local rightTile = self:getRightTile()

    if
      rightTile and
      rightTile:collidable() and
      collides(self, rightTile)
    then
      self.dx = 0
      self.x = rightTile.x - self.width
    end
  end
end