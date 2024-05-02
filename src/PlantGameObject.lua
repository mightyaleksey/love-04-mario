PlantGameObject = Class{__includes = GameObject}

function PlantGameObject:init(opt)
  GameObject.init(self, {
    -- dimentions
    frame = opt.frame,
    frames = 'plants',
    texture = 'main',
    -- map coordinates
    mapX = opt.mapX,
    mapY = opt.mapY
  })
end

function PlantGameObject:render()
  GameObject.render(self)
end

function PlantGameObject:update(dt)
  GameObject.update(self, dt)
end