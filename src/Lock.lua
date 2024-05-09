Lock = Class{__includes = Entity}

function Lock:init(opt)
  opt = opt or {}

  Entity.init(self, {
    -- position
    x = TILE_SIZE * ((opt.mapX or 1) - 1),
    y = VIRTUAL_HEIGHT - TILE_SIZE * (opt.mapY or 1),

    -- dimentions
    width = TILE_SIZE,
    height = TILE_SIZE,
    frame = opt.frame or 1,
    frames = 'locks',
    texture = 'main',

    -- available states
    stateMachine = StateMachine {},

    -- environment
    level = opt.level
  })

  self.collidable = true
  self.solid = true
end

function Lock:render()
  Entity.render(self)
end

function Lock:update(dt)
  Entity.update(self, dt)
end

--[[ helpers ]]

function Lock:onCollide(player)
  -- check if player has necessary key and open the lock
  for index, item in ipairs(player.items) do
    if
      item.frames == 'keys' and
      item.frame == self.frame
    then
      table.remove(player.items, index)
    end
  end
end