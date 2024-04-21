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
    player = genQuads(gTextures['main'], 16, 20, nil, 348, 176, 368),

    ladder = genQuads(gTextures['main'], 16, 16, nil, 256, 16, 288),
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
