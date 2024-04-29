-- generic container for the level
GameLevel = Class{}

function GameLevel:init(tileMap, entities)
  self.entities = entities or {}
  self.objects = {}
  self.tileMap = tileMap
end

function GameLevel:render(scrollX)
  -- render map
  self.tileMap:render(scrollX)

  -- render static objects
  for _, object in ipairs(self.objects) do
    object:render()
  end

  -- render entities
  for _, entity in ipairs(self.entities) do
    entity:render()
  end
end

function GameLevel:update(dt)
  for _, entity in ipairs(self.entities) do
    entity:update(dt)
  end
end