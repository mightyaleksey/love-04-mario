FlagGameObject = Class{__includes = GameObject}

function FlagGameObject:init(opt)
  GameObject.init(self, {
    -- dimentions
    frame = opt.frame,
    frames = 'flags',
    texture = 'main',
    -- map coordinates
    mapX = opt.mapX,
    mapY = opt.mapY
  })
end

function FlagGameObject:render()
  GameObject.render(self)
end

function FlagGameObject:update(dt)
  GameObject.update(self, dt)
end