-- generic container for the level
GameLevel = Class{}

function GameLevel:init(tileMap, entities, objects)
  -- collections
  self.entities = entities or {}
  self.objects = objects or {}
  self.tileMap = tileMap

  -- level state
  self.collectedFlags = 0
  self.availableFlags = 2
end

function GameLevel:render(scrollX)
  -- render only visible map
  local leftX = math.floor(scrollX / TILE_SIZE)
  local rightX = math.floor((scrollX + VIRTUAL_WIDTH) / TILE_SIZE) + 1

  -- render map
  self.tileMap:render(leftX, rightX)

  -- render static objects
  for _, object in ipairs(self.objects) do
    if object.mapX >= leftX and object.mapX <= rightX then
      object:render()
    end
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