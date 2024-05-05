Player = Class{__includes = Entity}

function Player:init(opt)
  opt = opt or {}

  Entity.init(self, {
    -- position
    x = TILE_SIZE * ((opt.mapX or 1) - 1),
    y = VIRTUAL_HEIGHT - TILE_SIZE * (opt.mapY or 1),

    -- dimentions
    width = 16,
    height = 20,
    frames = 'player',
    texture = 'main',

    -- available states
    stateMachine = StateMachine {
      idle = function () return PlayerIdleState(self) end,

      -- enemies interaction
      bounce = function () return PlayerBounceState(self) end,
      escaping = function () return PlayerEscapingState(self) end,

      -- ladder interaction
      climbing = function () return PlayerClimbingState(self) end,

      -- basic movement
      falling = function () return PlayerFallingState(self) end,
      jump = function () return PlayerJumpState(self) end,
      walking = function () return PlayerWalkingState(self) end
    },

    -- environment
    level = opt.level,
    tileMap = opt.tileMap
  })

  self:changeState('falling')
end

function Player:render()
  Entity.render(self)
end

function Player:update(dt)
  Entity.update(self, dt)
  self:checkEntityCollisions()
end

--[[ helpers ]]

function Player:checkEntityCollisions()
  for k, target in ipairs(self.level.entities) do
    if target.collidable then
      if collides(self, target) then
        target:onCollide(self)

        if target.consumable then
          -- consume
        else

        end
      end
    end

    if target.y > VIRTUAL_HEIGHT then
      -- remove entities out of viewport
      table.remove(self.level.entities, k)
    end
  end
end