function genPoles(atlas)
  local spritesheet = {}
  local sheetCounter = 0

  for x = 1, 6 do
    for y = 1, 3 do
      sheetCounter = sheetCounter + 1
      spritesheet[sheetCounter] =
        love.graphics.newQuad(
          16 * (x - 1),
          16 * (y - 1) + 192,
          16,
          16,
          atlas:getDimensions()
        )
    end
  end

  return spritesheet
end

-- 7 * 5 * 6
function genTiles(atlas)
  local spritesheet = {}
  local sheetCounter = 0

  local map = {
    512, 592,
    496, 592,
    528, 592,
    496, 576,
    528, 576,
    480, 576
  }

  for x = 0, 5 do
    for y = 0, 9 do
      for k = 1, #map, 2 do
        sheetCounter = sheetCounter + 1
        spritesheet[sheetCounter] =
          love.graphics.newQuad(
            80 * x + map[k],
            64 * y + map[k + 1],
            16,
            16,
            atlas:getDimensions()
          )
      end
    end
  end

  return spritesheet
end

-- 5 * 6 * 9
function genTileTops(atlas)
  local spritesheet = {}
  local sheetCounter = 0

  local map = {
    16, 576,
    32, 576,
    48, 576,
    16, 592,
    16, 608,
    48, 592,
    48, 608
  }

  for x = 0, 5 do
    for y = 0, 17 do
      for k = 1, #map, 2 do
        sheetCounter = sheetCounter + 1
        spritesheet[sheetCounter] =
          love.graphics.newQuad(
            80 * x + map[k],
            64 * y + map[k + 1],
            16,
            16,
            atlas:getDimensions()
          )
      end
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