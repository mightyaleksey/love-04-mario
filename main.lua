require 'dependencies'

--[[ load & rendering ]]

function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')

  -- load graphics
  gTextures = {
    main = love.graphics.newImage('graphics/full_sheet.png')
  }
  gFrames = {
    player = genQuads(gTextures['main'], 16, 20, nil, 348, 176, 368)
  }

  push:setupScreen(
    VIRTUAL_WIDTH, VIRTUAL_HEIGHT,
    WINDOW_WIDTH, WINDOW_HEIGHT,
    { vsync = true, fullscreen = false, resizable = true }
  )

  -- register key aliases
  Keys.setAlias('left', 'a')
  Keys.setAlias('right', 'd')

  -- define game states
  gStateMachine = StateMachine {
    play = function () return GamePlayState() end
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
end
