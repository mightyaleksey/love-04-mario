-- generic container for the level
GameLevel = Class{}

function GameLevel:init(tileMap, entities)
  self.entities = entities or {}
  self.tileMap = tileMap
end

function GameLevel:render(scrollX)
  self.tileMap:render(scrollX)

  for _, entity in ipairs(self.entities) do
    entity:render()
  end
end

function GameLevel:update(dt)
  for _, entity in ipairs(self.entities) do
    entity:update(dt)
  end
end