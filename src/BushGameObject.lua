BushGameObject = Class{__includes = GameObject}

function BushGameObject:init(opt)
  GameObject.init(self, {
    -- dimentions
    frame = opt.frame,
    frames = 'bushes',
    texture = 'main',
    -- map coordinates
    mapX = opt.mapX,
    mapY = opt.mapY
  })
end

function BushGameObject:render()
  GameObject.render(self)
end

function BushGameObject:update(dt)
  GameObject.update(self, dt)
end