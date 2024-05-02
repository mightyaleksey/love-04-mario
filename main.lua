require 'dependencies'

--[[ load & rendering ]]

function love.load()
  love.window.setTitle('Mario')
  love.graphics.setDefaultFilter('nearest', 'nearest')

  -- fonts
  gFonts = {
    small = love.graphics.newFont('fonts/font.ttf', 8),
    medium = love.graphics.newFont('fonts/font.ttf', 16),
    large = love.graphics.newFont('fonts/font.ttf', 32)
  }

  -- load graphics
  gTextures = {
    main = love.graphics.newImage('graphics/full_sheet.png')
  }
  gFrames = {
    bg = genQuads(gTextures['main'], 256, 128, 464, 16, 720, 400),
    coins = genQuads(gTextures['main'], 16, 16, 64, 160, 112, 176),
    flags = genQuads(gTextures['main'], 16, 16, 96, 192, 144, 256),
    keys = genQuads(gTextures['main'], 16, 16, 0, 64, 64, 80),
    ladder = genQuads(gTextures['main'], 16, 16, nil, 256, 16, 288),
    locks = genQuads(gTextures['main'], 16, 16, 0, 80, 64, 96),
    player = genQuads(gTextures['main'], 16, 20, nil, 348, 176, 368),
    poles = genPoles(gTextures['main']),
    snail = genQuads(gTextures['main'], 16, 12, 0, 532, 126, 544),

    bushes = genQuads(gTextures['main'], 16, 16, 208, 112, 352, 160),
    plants = genQuads(gTextures['main'], 16, 16, 320, 160, 432, 240),
    tiles = genTiles(gTextures['main']),
    tileTops = genTileTops(gTextures['main']),
    water = genWater(gTextures['main'])
  }

  push:setupScreen(
    VIRTUAL_WIDTH, VIRTUAL_HEIGHT,
    WINDOW_WIDTH, WINDOW_HEIGHT,
    { vsync = true, fullscreen = false, resizable = true }
  )

  -- register key aliases
  Keys.setAlias('down', 's')
  Keys.setAlias('left', 'a')
  Keys.setAlias('right', 'd')
  Keys.setAlias('up', 'w')

  -- define game states
  gStateMachine = StateMachine {
    play = function () return GamePlayState() end,
    test = function () return GameTestState() end
  }
  gStateMachine:change('play')
end

function love.draw()
  push:start()
  gStateMachine:render()
  push:finish()
end

--[[ data updates ]]

function love.keypressed(key)
  Keys.keypressed(key)
end

function love.keyreleased(key)
  Keys.keyreleased(key)
end

function love.update(dt)
  gStateMachine:update(dt)
  Keys.update(dt)
end

-- helpers

function displayFPS()
  -- renders frames per second
  love.graphics.setColor(0.6, 0.6, 1, 1)
  love.graphics.setFont(gFonts.small)
  love.graphics.print('FPS: '..tostring(love.timer.getFPS()), 5, 5)
end