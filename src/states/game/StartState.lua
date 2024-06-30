StartState = Class{__includes = BaseState}

function StartState:enter()
  self.level = LevelMaker.generate(26, 18)
  self.level.entities = {}
end

function StartState:render()
  -- reset color
  love.graphics.setColor(1, 1, 1, 1)

  local x, y, backgroundWidth, backgroundHeight = gFrames['bg'][1]:getViewport()
  local scale = VIRTUAL_HEIGHT / backgroundHeight
  local loopPoint = backgroundWidth * scale

  -- render background
  love.graphics.draw(
    gTextures['main'], gFrames['bg'][1],
    0, 0, 0, scale, scale
  )
  love.graphics.draw(
    gTextures['main'], gFrames['bg'][1],
    loopPoint - 1, 0, 0, scale, scale
  )

  self.level:render(0)

  love.graphics.setFont(gFonts['large'])
  love.graphics.printf(
    'Super 50 Bros.',
    0, 0.4 * VIRTUAL_HEIGHT, VIRTUAL_WIDTH,
    'center'
  )
  love.graphics.setFont(gFonts['medium'])
  love.graphics.printf(
    'Press Enter',
    0, 0.6 * VIRTUAL_HEIGHT, VIRTUAL_WIDTH,
    'center'
  )
end

function StartState:update()
  if Keys.wasPressed('escape') then
    love.event.quit()
  end

  if Keys.wasPressed('return') then
    gStateMachine:change('play')
  end
end