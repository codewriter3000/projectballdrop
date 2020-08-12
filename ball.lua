require "obstacle"
require "leveldata"
local inspect = require("inspect")

Ball = {
  iX = nil, --initial X grid value
  iY = nil, --initial Y grid value
  g = nil, --grid
  x = nil, --x-value
  y = nil --y-value
}

function Ball.new(iX, iY, g)
  local ball = setmetatable({}, {__index = Ball})
  --if type(iX) == "number" and type(iY) == "number" then
    ball.iX = iX
    ball.iY = iY
    ball.g = g
    ball.x = iX
    ball.y = iY
    return ball
  --end
end

function Ball:draw()
  love.graphics.setColor(255, 0, 0)
  love.graphics.circle("fill", self.g.m[self.x][self.y][1], self.g.m[self.x][self.y][2], 30)
  self.g.m[self.x][self.y][3] = true;
  self:update()
end

function Ball:update()
  for i = 0, self.g.c - self.y do
    --print("y1" .. inspect(self.g.m[self.x][self.g.c][2]))
    --print("y2" .. inspect(self.g.c))
    if self.g.m[self.x][self.g.c][2] == self.g.c then
      return nil
    end
    if not pcall(function()
      if self.g.m[self.x][self.y+1][3] == false then
        self.y = self.y + 1
      else
        return nil
      end
    end) then
      if getLevel() == 1 then
        print("Level 1 Complete")
        lvl2()
      elseif getLevel() == 2 then
        print("Level 2 Complete")
        lvl3()
      elseif getLevel() == 3 then
        print("Level 3 Complete")
        lvl4()
      elseif getLevel() == 4 then
        print("Level 4 Complete")
        gameComplete()
      end
    end
  end
end
