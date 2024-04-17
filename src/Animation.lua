Animation = Class{}

function Animation:init(opt)
  self.frames = opt.frames
  self.currentFrame = 1
  self.interval = opt.interval
  self.timer = 0
end

function Animation:update(dt)
  self.timer = self.timer + dt

  if self.timer >= self.interval then
    self.timer = self.timer - self.interval
    self.currentFrame = self.currentFrame % #self.frames + 1
  end
end

--[[ helpers ]]

function Animation:getCurrentFrame()
  return self.frames[self.currentFrame]
end