require "scales"
local inspect = require("inspect")

obstacleRadius = 30

Obstacle = {
  l = nil, --length
  c = nil, --color
  iX = nil, --initial X grid value
  iY = nil, --initial Y grid value
  h = nil, --true = horizontal (init on left), false = vertical (init on top)
  g = nil, --grid
  tX = nil, --temporary X grid value (for moving)
  tY = nil, --temporary Y grid value (for moving)
  x = nil, --current X grid value
  y = nil, --current Y grid value
  old = nil --obstacle backup
}

function Obstacle.new(l, c, iX, iY, h, g)
  local obstacle = setmetatable({}, {__index = Obstacle})
  if type(l) == "number" and type(c) == "table" and type(iX) == "number" and type(iY) == "number" and type(h) == "boolean" then
    obstacle.l = l
    obstacle.c = c
    obstacle.iX = iX
    obstacle.iY = iY
    obstacle.h = h
    obstacle.g = g
    obstacle.x = iX
    obstacle.y = iY
    return obstacle
  end
end

function Obstacle:draw()
  --self.g:updateRawValues()
    local l = self.l-1
    love.graphics.setColor(self.c)
    love.graphics.circle("fill", self.g.m[self.x][self.y][1], self.g.m[self.x][self.y][2], obstacleRadius)
    --enable every consumed tile
    if self.h == true then
      if not pcall(function()
        if self.g:getColumn(self.g.m[self.x+l][self.y][1])[2] == nil then
          return nil
        end
      end) then
        return false
      end
      for i = 0, l do
        self.g.m[self.x+i][self.y][3] = true
      end
      dX = self.g.m[self.x+l][self.y][1] - self.g.m[self.x][self.y][1]
      dY = self.g.m[self.x+l][self.y][2] - self.g.m[self.x][self.y][2]
      love.graphics.circle("fill", self.g.m[self.x+l][self.y][1], self.g.m[self.x+l][self.y][2], obstacleRadius)
      love.graphics.rectangle("fill", self.g.m[self.x][self.y][1], self.g.m[self.x][self.y][2]-obstacleRadius, dX, dY+(obstacleRadius*2))
    else
      if not pcall(function()
        if self.g:getRow(self.g.m[self.x][self.y+l][2])[2] == nil then
          return nil
        end
      end) then
        return false
      end
      for i = 0, l do
        self.g.m[self.x][self.y+i][3] = true
      end
      dX = self.g.m[self.x][self.y+l][1] - self.g.m[self.x][self.y][1]
      dY = self.g.m[self.x][self.y+l][2] - self.g.m[self.x][self.y][2]
      love.graphics.circle("fill", self.g.m[self.x][self.y+l][1], self.g.m[self.x][self.y+l][2], obstacleRadius)
      love.graphics.rectangle("fill", self.g.m[self.x][self.y][1]-obstacleRadius, self.g.m[self.x][self.y][2], dX+(obstacleRadius*2), dY)
    end
    self:drawRoot()
    old = self
end

function Obstacle:drawRoot()
  love.graphics.setColor(1, 1, 1)
  love.graphics.circle("fill", self.g.m[self.x][self.y][1], self.g.m[self.x][self.y][2], obstacleRadius)
end

function Obstacle:findTail(debug)
  if self.h == true then
    return {self.x+self.l-1, self.y}
  else
    return {self.x, self.y+self.l-1}
  end
end