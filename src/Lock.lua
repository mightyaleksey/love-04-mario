Lock = Class{__includes = Entity}

function Lock:init(opt)
  opt = opt or {}

  Entity.init(self, {
    -- position
    mapX = opt.mapX,
    mapY = opt.mapY,

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

function Lock:findPole()
  for _, entity in ipairs(self.level.entities) do
    if
      getmetatable(entity) == Pole and
      entity.frame == 3
    then
      return entity
    end
  end
end

function Lock:onCollide(player)
  -- check if player has necessary key and open the lock
  for index, item in ipairs(player.items) do
    if
      item.frames == 'keys' and
      item.frame == self.frame
    then
      local pole = self:findPole()
      local flag = Flag {
        mapX = pole.mapX,
        mapY = pole.mapY,
        color = self.frame,
        -- environment
        level = self.level
      }

      table.insert(self.level.entities, flag)
      table.remove(player.items, index)

      gSounds['powerupReveal']:play()
    end
  end
end