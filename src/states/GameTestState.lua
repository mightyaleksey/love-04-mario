function renderTilePack(frames, columns, columnWidth, offsetRow)
  local offsetX = (VIRTUAL_WIDTH - (columns - 1) * columnWidth - 16) / 2

  for k = 1, #frames do
    x = ((k - 1) % columns) * columnWidth + offsetX
    y = math.floor((k - 1) / columns + offsetRow) * columnWidth + 4

    love.graphics.draw(gTextures['main'], frames[k], x, y)
    love.graphics.print(tostring(k), x + 1, y + 11)
  end
end

--[[ implementation ]]

GameTestState = Class{__includes = BaseState}

function GameTestState:enter()
  self.scrollY = 0
end

function GameTestState:render()
  local columnWidth = 20
  local columns = math.floor(VIRTUAL_WIDTH / columnWidth)
  local offsetRow = 0

  local tilePacks = { gFrames['tiles'], gFrames['tileTops'], gFrames['water'] }

  love.graphics.translate(0, self.scrollY)
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.setFont(gFonts['small'])

  for _, frames in ipairs(tilePacks) do
    renderTilePack(frames, columns, columnWidth, offsetRow)
    offsetRow = offsetRow + math.floor(#frames / columns) + 2
  end
end

function GameTestState:update()
  if Keys.wasPressed('up') then
    self.scrollY = math.min(self.scrollY + 30, 0)
  elseif Keys.wasPressed('down') then
    self.scrollY = self.scrollY - 30
  end
end