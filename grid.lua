require "scales"
require "ball"
require "obstacle"
local inspect = require("inspect")

Grid = {
  x = nil,
  y = nil,
  d = nil,
  r = nil,
  c = nil,
  m = {} --midpoints
}

function Grid.new(x, y, d, r, c)
  local grid = setmetatable({}, {__index = Grid})
  --if type(x) == "number" and type(y) == "number" and type(d) == "number" and type(r) == "number" and type(c) == "number" then
    grid.x = x
    grid.y = y
    grid.d = d
    grid.r = r
    grid.c = c
    return grid
  --end
end

function Grid:draw() --creates the grid
  love.graphics.setColor(255, 255, 255)
  scaleX = getWidthFromDecimal(self.x)
  scaleY = getHeightFromDecimal(self.y)
  xD = getWidthFromDecimal(self.d)
  yD = getHeightFromDecimal(self.d)
  topLeft = {scaleX, scaleY}
  topRight = {scaleX + xD, scaleY}
  bottomLeft = {scaleX, scaleY + yD}
  bottomRight = {scaleX + xD, scaleY + yD}
  xCount = (topRight[1]-topLeft[1])/self.c
  yCount = (bottomLeft[2]-topLeft[2])/self.r
  love.graphics.rectangle("line", scaleX, scaleY, xD, yD)
  for x = topLeft[1] + xCount, topRight[1] - xCount, xCount do
    love.graphics.line(x, topLeft[2], x, bottomLeft[2])
  end
  for y = topLeft[2] + yCount, bottomLeft[2] - yCount, yCount do
    love.graphics.line(topLeft[1], y, topRight[1], y)
  end
  --midpoints
  i = 1
  for x = topLeft[1] + xCount/2, topRight[1] - xCount/2, xCount do
    self.m[i] = {}
    j = 1
    for y = topLeft[2] + yCount/2, bottomLeft[2] - yCount/2, yCount do
      self.m[i][j] = {x, y, false}
      j = j + 1
    end
    i = i + 1
  end
end

function Grid:getColumn(x)
  if x < 1 then
    x = getWidthFromDecimal(x)
  end
  local present = 0
  local previous = 0
  for i,v in ipairs(self.m) do
    previous = present
    present = self.m[i][1][1]
    if math.abs(previous - x) < math.abs(present - x) then
      return {self.m[i-1][1][1], getDecimalFromWidth(self.m[i-1][1][1])}
    elseif self.m[i+1] == nil or self.m[i+1][1] == nil then
      return {self.m[i][1][1], getDecimalFromWidth(self.m[i][1][1])}
    end
  end
end

function Grid:getRow(y)
  if y < 1 then
    y = getHeightFromDecimal(y)
  end
  local present = 0
  local previous = 0
  for i,v in ipairs(self.m[1]) do
    previous = present
    present = self.m[1][i][2]
    if math.abs(previous - y) < math.abs(present - y) then
      return {self.m[1][i-1][2], getDecimalFromHeight(self.m[1][i-1][2])}
    elseif self.m[1][i+1] == nil then
      return {self.m[1][i][2], getDecimalFromHeight(self.m[1][i][2])}
    end
  end
end

function Grid:getID(x, y)
  if (not (self.c > 1) or (self.r > 1)) then --this shorthand function physically will not work if there is either only 1 row or 1 column
    return self:getIDAlt(x, y)
  else
    local cell_width_px = self.m[2][1][1] - self.m[1][1][1]
    local cell_height_px = self.m[1][2][2] - self.m[1][1][2]
    return {x / cell_width_px, y / cell_height_px}
  end
end

function Grid:getIDAlt(x, y)
  if x == 0 or y == 0 then
    return nil
  end
  local present = 0
  local previous = 0
  for i,v in ipairs(self.m) do
    previous = present
    present = self.m[i][1][1]
    if math.abs(previous - x) < math.abs(present - x) then
      previous = 0
      present = 0
      for j,v2 in ipairs(self.m[i]) do
        previous = present
        present = self.m[i][j][2]
        if math.abs(previous - y) < math.abs(present - y) then
          return {i-1, j-1}
        elseif self.m[i][j+1] == nil then
          return {i-1, j}
        end
      end
    elseif self.m[i+1] == nil or self.m[i+1][1] == nil then
      previous = 0
      present = 0
      for j,v2 in ipairs(self.m[i]) do
        previous = present
        present = self.m[i][j][2]
        if math.abs(previous - y) < math.abs(present - y) then
          return {i, j-1}
        elseif self.m[i][j+1] == nil then
          return {i, j}
        end
      end
    end
  end
end

function Grid:getMouseID()
  return self:getID(love.mouse.getX(), love.mouse.getY())
end

function Grid:getDecimalFromGridWidth(p)
  return p / getWidthFromDecimal(self.d + self.x)
end
function Grid:getDecimalFromGridHeight(p)
  return p / getHeightFromDecimal(self.d + self.y)
end

function Grid:hasObstacle(x, y)
  r = nil
  if not pcall(function()
    if self.m[x][y][3] then
      r = true
    else
      r = false
    end
  end) then
    return false
  else
    return r
  end
end
