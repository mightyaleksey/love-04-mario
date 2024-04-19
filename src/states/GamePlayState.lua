GamePlayState = Class{__includes = BaseState}

function GamePlayState:enter()
  self.tileMap = LevelMaker.generate()

  self.player = Player {
    x = 50,
    y = 100,

    tileMap = self.tileMap
  }
end

function GamePlayState:render()
  -- render background
  love.graphics.draw(gTextures['main'], gFrames['bg'][1], 0, 0, 0, 2.25, 2.25)

  self.player:render()
end

function GamePlayState:update(dt)
  self.player:update(dt)
end