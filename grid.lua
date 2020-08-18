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
    --print("nope not a root")
    return false
  else
    root = self:getRoot(x, y)
    if root.h == true then
      if self:rootsAreEqual(x, y, x+root.l-1, y) then
        --print(inspect(x+root.l-1, y))
        return {x+root.l-1, y}
      end
      --print("god help you horizontal")
    else
      --printCoords(x+root.l-1, y)
      if self:rootsAreEqual(x, y, x, y+root.l-1) then
        --print(inspect({x, y+root.l-1}))
        return {x, y+root.l-1}
      end
      --print("god help you vertical")
    end
  end
  return false
end
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
    --[[print("findRoot()")
    print("x: " .. x)
    print("y: " .. y)
    print("self.grid:hasObstacle(x, y): " .. inspect(self.grid:hasObstacle(x, y)) .. " (SHOULD BE TRUE)")

    print("how df did i end up here")]]
    return false
  end
    --go left until you find a root
    --find out if the root could be possible (root.x + l < x < root.x)
    --do the same thing but going up
    --return false if neither
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
function Grid:moveObstacle(x, y, x0, y0)
    --[[print("-----------------------------------------")
    print("x: " .. x)
    print("y: " .. y)
    print("x0: " .. x0)
    print("y0: " .. y0)
    print("-----------------------------------------")]]
    root = self:findRoot(x, y) --where the root of the obstacle is located
    rootOb = nil
    if root == false then
      rootOb = false
    else
      rootOb = self:getRoot(root[1], root[2])
    end
    --print(inspect(root))
    --mouse = self:findRoot(self.grid:getMouseID()[1], self.grid:getMouseID()[2]) --where the mouse is located on the screen
    --print("moving: " .. inspect(self.grid:getMouseID()))
    --print("x: " .. x)
    --print("y: " .. y)
    --[[
      CONDITIONS TO MOVE:
      - The obstacle will not collide with the ball or another obstacle
      - The obstacle will not fall off the grid
      -
    ]]
    --if not pcall(function()
      if x ~= x0 or y ~= y0 then
        if not rootOb then
          --print("we're no strangers to love")
          return nil
        end
        if rootOb.h == true then
          --printGrid(self.grid)
          A = self:hasObstacle(self:getMouseID()[1], self:getMouseID()[2])
          --if not A then
            --print("d: " .. d)
            self:getRoot(root[1], root[2]).x = self:getMouseID()[1]
          --end
        else
          --printGrid(self.grid)
          --if not A then
            --print("d: " .. d)
            self:getRoot(root[1], root[2]).y = self:getMouseID()[2]
          --end
        end
      end
    --end) then
      --print("failed")
    --end
    --find the root
    --if h == true, then move the obstacle to the row of the cursor
    --else move the obstacle to the column of the cursor
end