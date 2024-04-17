GamePlayState = Class{__includes = BaseState}

function GamePlayState:enter()
  self.player = Player {
    x = 50,
    y = 100
  }
end

function GamePlayState:render()
  self.player:render()
end

function GamePlayState:update(dt)
  self.player:update(dt)
end