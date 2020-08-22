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
  scaleX = nil,
  scaleY = nil,
  xD = nil,
  yD = nil,
  topLeft = nil,
  topRight = nil,
  bottomLeft = nil,
  bottomRight = nil,
  xCount = nil,
  yCount = nil,
  m = {} --midpoints
}

function Grid.new(x, y, d, r, c)
  local grid = setmetatable({}, {__index = Grid})
    grid.x = x
    grid.y = y
    grid.d = d
    grid.r = r
    grid.c = c
    grid.scaleX = getWidthFromDecimal(x)
    grid.scaleY = getHeightFromDecimal(y)
    grid.xD = getWidthFromDecimal(d)
    grid.yD = getHeightFromDecimal(d)
    grid.topLeft = {grid.scaleX, grid.scaleY}
    grid.topRight = {grid.scaleX + grid.xD, grid.scaleY}
    grid.bottomLeft = {grid.scaleX, grid.scaleY + grid.yD}
    grid.bottomRight = {grid.scaleX + grid.xD, grid.scaleY + grid.yD}
    grid.xCount = (grid.topRight[1]-grid.topLeft[1])/c
    grid.yCount = (grid.bottomLeft[2]-grid.topLeft[2])/r
    --midpoints
    i = 1
    for x = grid.topLeft[1] + grid.xCount/2, grid.topRight[1] - grid.xCount/2, grid.xCount do
      grid.m[i] = {}
      j = 1
      for y = grid.topLeft[2] + grid.yCount/2, grid.bottomLeft[2] - grid.yCount/2, grid.yCount do
        grid.m[i][j] = {x, y, false}
        j = j + 1
      end
      i = i + 1
    end
    return grid
end

function Grid:draw() --creates the grid
  love.graphics.setColor(255, 255, 255)
  love.graphics.rectangle("line", self.scaleX, self.scaleY, self.xD, self.yD)
  for x = self.topLeft[1] + self.xCount, self.topRight[1] - self.xCount, self.xCount do
    love.graphics.line(x, self.topLeft[2], x, self.bottomLeft[2])
  end
  for y = self.topLeft[2] + self.yCount, self.bottomLeft[2] - self.yCount, self.yCount do
    love.graphics.line(self.topLeft[1], y, self.topRight[1], y)
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

function Grid:getWidth()
  return self.m[2][1][1] - self.m[1][1][1]
end

function Grid:getHeight()
  return self.m[1][2][2] - self.m[1][1][2]
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

function Grid:isRoot(x, y)
  for i,v in pairs(lvl.obstacles) do
    if v.x == x and v.y == y then
      return true
    end
  end
  return false
end
function Grid:findTail(x, y)
  if not self:isRoot(x, y) then
    return false
  else
    root = self:getRoot(x, y)
    if root.h == true then
      if self:rootsAreEqual(x, y, x+root.l-1, y) then
        return {x+root.l-1, y}
      end
    else
      if self:rootsAreEqual(x, y, x, y+root.l-1) then
        return {x, y+root.l-1}
      end
    end
  end
  return false
end
--go left until you find a root
--find out if the root could be possible (root.x + l < x < root.x)
--do the same thing but going up
--return false if neither
function Grid:findRoot(x, y) --find the root of 2 points
  selectedObstacle = {}
  if not self:hasObstacle(x, y) then
    return false
  end
  if self:isRoot(x, y) then --if (x, y) is a root then return (x, y)
    return {x, y}
  else
    h2 = x
    v2 = y
    while h2 > 0 do --start at x, then move left until you can't move any further left
      if self:isRoot(h2, y) and self:rootsAreEqual(h2, y, x, y) then --if a root is found on the h2 axis and (x, y) and (h2, y) are on the same object
        return {h2, y}
      end
      h2 = h2 - 1
    end
    while v2 > 0 do --start at y, then move up until you can't move any further up
      if self:isRoot(x, v2) and self:rootsAreEqual(x, v2, x, y) then
        return {x, v2}
      end
      v2 = v2 - 1
    end
    return false
  end
  return false
end
function Grid:rootsAreEqual(x, y, x0, y0)
  root = self:getRoot(x, y)
  if not root then
    return nil
  else
    if root.h == true then
      if root.x+root.l > x0 and root.x < x0 and root.y == y0 then
        return true
      else
        return false
      end
    else
      if root.y+root.l > y0 and root.y < y0 and root.x == x0 then
        return true
      else
        return false
      end
    end
  end
end
--returns an obstacle given a root
function Grid:getRoot(x, y)
  if self:isRoot(x, y) then
    for i,v in pairs(lvl.obstacles) do
      if v.x == x and v.y == y then
        return v
      end
    end
  end
  return false
end
    --[[
      CONDITIONS TO MOVE:
      - The obstacle will not collide with the ball or another obstacle
      - The obstacle will not fall off the grid
    ]]
--find the root
--if h == true, then move the obstacle to the row of the cursor
--else move the obstacle to the column of the cursor
function Grid:moveObstacle(x, y, x0, y0)
    root = self:findRoot(x, y) --where the root of the obstacle is located
    rootOb = nil
    if root == false then
      rootOb = false
    else
      rootOb = self:getRoot(root[1], root[2])
    end
      if x ~= x0 or y ~= y0 and root ~= false then
        if not rootOb then
          return 0
        end
        if rootOb.h == true then
          --supposing a new obstacle was created with the root being at (getMouseID()[1], y), if the tail of this obstacle was off the grid
          --then don't move the obstacle
          --(l, c, iX, iY, h, g)
          tmp = Obstacle.new(rootOb.l, rootOb.c, self:getMouseID()[1], rootOb.y, rootOb.h, rootOb.g)
          if (self:getMouseID()[1] > 0) and (tmp:findTail()[1] <= lvl.grid.c) and not (self:hasObstacle(tmp:findTail()[1], tmp:findTail()[2]) and drag[2][1] > drag[1][1]) then
            self:getRoot(root[1], root[2]).x = self:getMouseID()[1]
          end
        else
          tmp = Obstacle.new(rootOb.l, rootOb.c, rootOb.x, self:getMouseID()[2], rootOb.h, rootOb.g)
          if (self:getMouseID()[2] > 0) and (tmp:findTail()[2] <= lvl.grid.r) and not (self:hasObstacle(tmp:findTail()[1], tmp:findTail()[2]) and drag[2][2] > drag[1][2]) then
            self:getRoot(root[1], root[2]).y = self:getMouseID()[2]
          end
        end
      end
end