require "obstacle"
require "leveldata"
require "goal"
local inspect = require("inspect")
local Timer = require("hump-master.timer")

Ball = {
  iX = nil, --initial X grid value
  iY = nil, --initial Y grid value
  g = nil, --grid
  x = nil, --x-value
  y = nil, --y-value
  d = nil --cardinal direction
}

function Ball.new(iX, iY, g)
  local ball = setmetatable({}, {__index = Ball})
  --if type(iX) == "number" and type(iY) == "number" then
    ball.iX = iX
    ball.iY = iY
    ball.g = g
    ball.x = iX
    ball.y = iY
    ball.d = "south" --can be "south", "west", "north", or "east"
    return ball
  --end
end

function Ball:draw()
  --print("self.g.m[self.x][self.y]: " .. inspect(self.g.m[self.x][self.y]))
  love.graphics.setColor(1, 0, 0)
  love.graphics.circle("fill", self.g.m[self.x][self.y][1], self.g.m[self.x][self.y][2], 30)
  
  if self.d == "south" then
    love.graphics.setColor(1, 1, 1)
    love.graphics.line(self.g.m[self.x][self.y][1], self.g.m[self.x][self.y][2] + 15, self.g.m[self.x][self.y][1], self.g.m[self.x][self.y][2] - 15)
    love.graphics.line(self.g.m[self.x][self.y][1] - 7, self.g.m[self.x][self.y][2], self.g.m[self.x][self.y][1], self.g.m[self.x][self.y][2] + 15)
    love.graphics.line(self.g.m[self.x][self.y][1] + 7, self.g.m[self.x][self.y][2], self.g.m[self.x][self.y][1], self.g.m[self.x][self.y][2] + 15)
  elseif self.d == "east" then
    love.graphics.setColor(1, 1, 1)
    love.graphics.line(self.g.m[self.x][self.y][1] + 15, self.g.m[self.x][self.y][2], self.g.m[self.x][self.y][1] - 15, self.g.m[self.x][self.y][2])
    love.graphics.line(self.g.m[self.x][self.y][1], self.g.m[self.x][self.y][2] - 7, self.g.m[self.x][self.y][1] + 15, self.g.m[self.x][self.y][2])
    love.graphics.line(self.g.m[self.x][self.y][1], self.g.m[self.x][self.y][2] + 7, self.g.m[self.x][self.y][1] + 15, self.g.m[self.x][self.y][2])
  elseif self.d == "north" then
    love.graphics.setColor(1, 1, 1)
    love.graphics.line(self.g.m[self.x][self.y][1], self.g.m[self.x][self.y][2] + 15, self.g.m[self.x][self.y][1], self.g.m[self.x][self.y][2] - 15)
    love.graphics.line(self.g.m[self.x][self.y][1] - 7, self.g.m[self.x][self.y][2], self.g.m[self.x][self.y][1], self.g.m[self.x][self.y][2] - 15)
    love.graphics.line(self.g.m[self.x][self.y][1] + 7, self.g.m[self.x][self.y][2], self.g.m[self.x][self.y][1], self.g.m[self.x][self.y][2] - 15)
  elseif self.d == "west" then
    love.graphics.setColor(1, 1, 1)
    love.graphics.line(self.g.m[self.x][self.y][1] + 15, self.g.m[self.x][self.y][2], self.g.m[self.x][self.y][1] - 15, self.g.m[self.x][self.y][2])
    love.graphics.line(self.g.m[self.x][self.y][1], self.g.m[self.x][self.y][2] - 7, self.g.m[self.x][self.y][1] - 15, self.g.m[self.x][self.y][2])
    love.graphics.line(self.g.m[self.x][self.y][1], self.g.m[self.x][self.y][2] + 7, self.g.m[self.x][self.y][1] - 15, self.g.m[self.x][self.y][2])
  else
    assert(false, "Ball direction should be a cardinal direction")
  end
  --self.g.m[self.x][self.y][3] = true;
end
--once goals start moving, this function will not work
function Ball:isInGoal()
  if lvl.goal.iX == self.x and lvl.goal.iY == self.y then
    return true
  else
    return false
  end
end

function Ball:update()
  if not pcall(function()
    if self.d == "north" then
      if self.g.m[self.x][self.y-1][3] == false then
        Timer.script(function(wait)
          --wait(0.1)
          self.y = self.y - 1
        end)
      end
    elseif self.d == "south" then
      if self.g.m[self.x][self.y+1][3] == false then
        Timer.script(function(wait)
          --wait(0.1)
          self.y = self.y + 1
        end)
        --print("hi")
      end
    elseif self.d == "east" then
      if self.g.m[self.x+1][self.y][3] == false then
        Timer.script(function(wait)
          --wait(0.1)
          self.x = self.x + 1
        end)
      end
    elseif self.d == "west" then
      if self.g.m[self.x-1][self.y][3] == false then
        Timer.script(function(wait)
          --wait(0.1)
          self.x = self.x - 1
        end)
      end
    end
  end) then
    if self:isInGoal() then
      if getLevel() == 1 then
        print("Level 1 Complete")
        setLevel(2)
      elseif getLevel() == 2 then
        print("Level 2 Complete")
        setLevel(3)
      elseif getLevel() == 3 then
        print("Level 3 Complete")
        setLevel(4)
      elseif getLevel() == 4 then
        print("Level 4 Complete")
        setLevel(5)
      elseif getLevel() == 5 then
        print("Level 5 Complete")
        gameComplete()
      end
    end
  end
end
