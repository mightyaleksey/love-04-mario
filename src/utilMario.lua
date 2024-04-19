-- 7 * 5 * 6
function genTiles(atlas)
  local spritesheet = {}
  local sheetCounter = 0

  for x = 0, 2 do
    for y = 0, 9 do
      sheetCounter = sheetCounter + 1
      spritesheet[sheetCounter] =
        love.graphics.newQuad(80 * x + 512, 64 * y + 608, 16, 16, atlas:getDimensions())

      sheetCounter = sheetCounter + 1
      spritesheet[sheetCounter] =
        love.graphics.newQuad(80 * x + 512, 64 * y + 576, 16, 16, atlas:getDimensions())

      sheetCounter = sheetCounter + 1
      spritesheet[sheetCounter] =
        love.graphics.newQuad(80 * x + 480, 64 * y + 576, 16, 16, atlas:getDimensions())

      sheetCounter = sheetCounter + 1
      spritesheet[sheetCounter] =
        love.graphics.newQuad(80 * x + 496, 64 * y + 576, 16, 16, atlas:getDimensions())

      sheetCounter = sheetCounter + 1
      spritesheet[sheetCounter] =
        love.graphics.newQuad(80 * x + 528, 64 * y + 576, 16, 16, atlas:getDimensions())

      sheetCounter = sheetCounter + 1
      spritesheet[sheetCounter] =
        love.graphics.newQuad(80 * x + 496, 64 * y + 592, 16, 16, atlas:getDimensions())

      sheetCounter = sheetCounter + 1
      spritesheet[sheetCounter] =
        love.graphics.newQuad(80 * x + 528, 64 * y + 592, 16, 16, atlas:getDimensions())
    end
  end

  return spritesheet
end

-- 5 * 6 * 9
function genTileTops(atlas)
  local spritesheet = {}
  local sheetCounter = 0

  for x = 0, 2 do
    for y = 0, 17 do
      sheetCounter = sheetCounter + 1
      spritesheet[sheetCounter] =
        love.graphics.newQuad(80 * x + 0, 64 * y + 608, 16, 16, atlas:getDimensions())

      sheetCounter = sheetCounter + 1
      spritesheet[sheetCounter] =
        love.graphics.newQuad(80 * x + 16, 64 * y + 592, 16, 16, atlas:getDimensions())

      sheetCounter = sheetCounter + 1
      spritesheet[sheetCounter] =
        love.graphics.newQuad(80 * x + 16, 64 * y + 608, 16, 16, atlas:getDimensions())

      sheetCounter = sheetCounter + 1
      spritesheet[sheetCounter] =
        love.graphics.newQuad(80 * x + 48, 64 * y + 592, 16, 16, atlas:getDimensions())

      sheetCounter = sheetCounter + 1
      spritesheet[sheetCounter] =
        love.graphics.newQuad(80 * x + 48, 64 * y + 608, 16, 16, atlas:getDimensions())
    end
  end

  return spritesheet
end

-- 8x2
function genWater(atlas)
  local spritesheet = {}
  local sheetCounter = 0

  for x = 0, 7 do
    sheetCounter = sheetCounter + 1
    spritesheet[sheetCounter] =
      love.graphics.newQuad(16 * x + 208, 240, 16, 16, atlas:getDimensions())

    sheetCounter = sheetCounter + 1
    spritesheet[sheetCounter] =
      love.graphics.newQuad(16 * x + 208, 256, 16, 16, atlas:getDimensions())
  end

  return spritesheet
end