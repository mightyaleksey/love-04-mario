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
  self.tileMap = LevelMaker.generate(64, 18)

  self.player = Player {
    x = TILE_SIZE,
    y = TILE_SIZE * 10,

    tileMap = self.tileMap
  }
end

function GamePlayState:render()
  -- reset color
  love.graphics.setColor(1, 1, 1, 1)

  self:renderBg()

  -- debug
  love.graphics.setColor(0.2, 0.8, 0.2, 1)
  love.graphics.setFont(gFonts['small'])
  love.graphics.print('x: '..tostring(self.player.x), 10, 10)
  love.graphics.print('y: '..tostring(self.player.y), 10, 22)
  love.graphics.setColor(1, 1, 1, 1)

  -- emulate camera effect
  love.graphics.translate(-round(self.camX), -round(self.camY))

  self.tileMap:render(self.camX)
  self.player:render()
end

function GamePlayState:update(dt)
  if Keys.wasPressed('escape') then
    love.event.quit()
  end

  if Keys.wasPressed('t') then
    gStateMachine:change('test')
  end

  self.player:update(dt)

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