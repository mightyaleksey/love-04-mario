function genQuads(atlas, tileWidth, tileHeight, left, top, right, bottom)
  local atlasWidth = (right or atlas:getWidth()) - tileWidth
  local atlasHeight = (bottom or atlas:getHeight()) - tileHeight
  local spritesheet = {}
  local sheetCounter = 0

  for y = top or 0, atlasHeight, tileHeight do
    for x = left or 0, atlasWidth, tileWidth do
      sheetCounter = sheetCounter + 1
      spritesheet[sheetCounter] =
        love.graphics.newQuad(
          x, y, tileWidth, tileHeight, atlas:getDimensions()
        )
    end
  end

  return spritesheet
end
