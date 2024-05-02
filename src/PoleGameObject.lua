PoleGameObject = Class{__includes = GameObject}

function PoleGameObject:init(opt)
  GameObject.init(self, {
    -- dimentions
    frame = opt.frame,
    frames = 'poles',
    texture = 'main',
    -- map coordinates
    mapX = opt.mapX,
    mapY = opt.mapY
  })
end

function PoleGameObject:render()
  GameObject.render(self)
end

function PoleGameObject:update(dt)
  GameObject.update(self, dt)
end