LevelCompleteState = Class{__includes = BaseState}

function LevelCompleteState:enter(opt)
  self.backgroundScale = opt.backgroundScale
  self.backgroundLoopingPoint = opt.backgroundLoopingPoint
  self.camX = opt.camX
  self.camY = opt.camY
  self.level = opt.level
  self.player = opt.player
end

function LevelCompleteState:render()
  -- reset color
  love.graphics.setColor(1, 1, 1, 1)

  self:renderBg()

  -- debug
  if DEBUG == 1 then
    displayFPS()

    love.graphics.setColor(0.6, 0.6, 1, 1)
    love.graphics.setFont(gFonts['small'])
    love.graphics.print('x: '..tostring(self.player.x), 5, 20)
    love.graphics.print('y: '..tostring(self.player.y), 5, 28)

    local mapX, mapY = self.tileMap:pointToMap(self.player.x, self.player.y)
    love.graphics.print('mapX: '..tostring(mapX), 5, 36)
    love.graphics.print('mapY: '..tostring(mapY), 5, 44)
  end

  -- emulate camera effect
  love.graphics.translate(-round(self.camX), -round(self.camY))

  self.level:render(self.camX)
  self.player:render()

  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.setFont(gFonts['large'])
  love.graphics.printf(
    'Level Completed!',
    self.camX, 0.5 * VIRTUAL_HEIGHT - 16, VIRTUAL_WIDTH,
    'center'
  )
end

function LevelCompleteState:update(dt)
  if Keys.wasPressed('escape') then
    love.event.quit()
  end

  if Keys.wasPressed('return') then
    gStateMachine:change('play', {
      width = self.level.tileMap.width + 20
    })
  end
end

-- [[ helpers ]]

function LevelCompleteState:renderBg()
  local posX = 0.3 * self.camX % self.backgroundLoopingPoint
  local scale = self.backgroundScale

  -- render background
  love.graphics.draw(
    gTextures['main'], gFrames['bg'][1],
    -posX, 0, 0, scale, scale
  )
  love.graphics.draw(
    gTextures['main'], gFrames['bg'][1],
    -posX + self.backgroundLoopingPoint - 1, 0, 0, scale, scale
  )
end