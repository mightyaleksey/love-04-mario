GamePlayState = Class{__includes = BaseState}

function GamePlayState:enter()
  local x, y, backgroundWidth, backgroundHeight = gFrames['bg'][1]:getViewport()

  -- background
  self.backgroundScale = VIRTUAL_HEIGHT / backgroundHeight
  self.backgroundLoopingPoint = backgroundWidth * self.backgroundScale
  -- camera position
  self.camX = 0
  self.camY = 0
  -- level specific
  self.level = LevelMaker.generate(28, 18)
  -- self.level = LevelMaker.generate(64, 18)
  self.tileMap = self.level.tileMap

  local startX = findIndex(self.tileMap.tiles, function (column)
    return not column[1]:isWater()
  end)

  self.player = Player {
    mapX = startX,
    mapY = 7,

    -- environment
    level = self.level,
    tileMap = self.tileMap
  }
end

function GamePlayState:render()
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
end

function GamePlayState:update(dt)
  if Keys.wasPressed('escape') then
    love.event.quit()
  end

  if Keys.wasPressed('t') then
    gStateMachine:change('test')
  end

  if Keys.wasPressed('y') then
    DEBUG = DEBUG == 0 and 1 or 0
  end

  self.level:update(dt)
  self.player:update(dt)

  -- game over
  if self.player.y > VIRTUAL_HEIGHT then
    gStateMachine:change('play')
  end

  -- move camera left
  if self.player.x < self.camX + LEFT_CAMERA_EDGE then
    self.camX = math.max(self.player.x - LEFT_CAMERA_EDGE, 0)
  end

  -- move camera right
  if self.player.x > self.camX + RIGHT_CAMERA_EDGE then
    local worldWidth = TILE_SIZE * self.tileMap.width
    self.camX = math.min(self.player.x - RIGHT_CAMERA_EDGE, worldWidth - VIRTUAL_WIDTH)
  end
end

--[[ helpers ]]

function GamePlayState:renderBg()
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