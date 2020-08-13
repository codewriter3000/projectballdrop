require "obstacle"
local inspect = require("inspect")

Level = {
  grid = nil,
  ball = nil,
  obstacles = {},
}

local state = 'none'
function love.mousereleased(x, y, button)
  if button == 1 then
    state = 'none'
  end
end

function love.mousepressed(x, y, button)
  if button == 1 then
    if state == 'none' then
      pcall(function()
        drag[1] = rec:getID(x, y)
        drag[2] = rec:getID(x, y)
      end)
      state = 'grabbed'
    end
  end
end

function love.mousemoved(x, y)
  if state == 'grabbed' then
    if not pcall(function()
      drag[2] = rec:getID(x, y)
      --print(" ")
      --print("drag[2]: " .. inspect(drag[2]))
      --print("drag[1]: " .. inspect(drag[1]))
      --print("rec:hasObstacle(drag[1][1], drag[1][2]): " .. inspect(rec:hasObstacle(drag[1][1], drag[1][2])))
      --you are not intersecting another obstacle but if you are, it's your own
      if drag[2] ~= drag[1] and rec:hasObstacle(drag[1][1], drag[1][2]) and ((not rec:hasObstacle(drag[2][1], drag[2][2]) or  then
        lvl:moveObstacle(drag[1][1], drag[1][2], drag[2][1], drag[2][2])
        drag[1] = drag[2]
      end
    end) then 
      print("oof")
    end
  end
end

local mt = {__index = Level}
function Level.new(grid, ball, obstacles)
  local level = setmetatable({}, mt)
  level.grid = grid
  level.ball = ball
  level.obstacles = obstacles
  return level
end

local backup = nil
function Level:draw()
  if not pcall(function()
    self.grid:draw()
    for i,v in pairs(self.obstacles) do
      v:draw()
    end
    self.ball:draw()
  end) then
    backup:draw()
  end
  backup = self
end

function Level:update()
  self.ball:update()
  for i,v in pairs(self.obstacles) do
    v:update()
  end
end

function Level:isRoot(x, y)
  for i,v in pairs(self.obstacles) do
    if x == 3 and y == 4 then
      print("v.x: " .. v.x)
      print("v.y: " .. v.y)
    end
    if v.x == x and v.y == y then
      return true
    end
  end
  return false
end

function Level:findRoot(x, y) --find the root of 2 points
  selectedObstacle = {}
  print("test")
  if not self.grid:hasObstacle(x, y) then
    --print("(" .. x .. ", " .. y .. ") is not an obstacle")
    return false
  end
  if self:isRoot(x, y) then --if (x, y) is a root then return (x, y)
    return {x, y}
  else
    h2 = x
    v2 = y
    while h2 > 0 do --start at x, then move left until you can't move any further left
      if self:isRoot(h2, y) and self:rootsAreEqual(h2, y, x, y) then --if a root is found on the h2 axis and (x, y) and (h2, y) are on the same object
        print("yay this works now fix the vertical one")
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
function Level:rootsAreEqual(x, y, x0, y0)
  root = self:getRoot(x, y)
  if not root then
    return false
  else
    print("root.h: " .. root.h)
    if root.h == true then
      for l = 0, root.l do
        if self.grid:hasObstacle(x0+l-1, y0) then
          return true
        end
      end
    else
      for l = 0, root.l do
        if self.grid:hasObstacle(x0, y0+l-1) then
          return true
        end
      end
    end
  end
end
function Level:getRoot(x, y)
  if self:isRoot(x, y) then
    for i,v in pairs(self.obstacles) do
      if x == 3 and y == 4 then
        print("v.x: " .. v.x)
        print("v.y: " .. v.y)
      end
      if v.x == x and v.y == y then
        return v
      end
    end
  end
  return false
end
function Level:moveObstacle(x, y, x0, y0)
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
          A = self.grid:hasObstacle(self.grid:getMouseID()[1], self.grid:getMouseID()[2])
          --if not A then
            --print("d: " .. d)
            self:getRoot(root[1], root[2]).x = self.grid:getMouseID()[1]
          --end
        else
          --printGrid(self.grid)
          --if not A then
            --print("d: " .. d)
            self:getRoot(root[1], root[2]).y = self.grid:getMouseID()[2]
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

function getGnomed()
  print("⣿⣿⣿⣿⣿⠟⠉⠁⠄⠄⠄⠈⠙⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿")
  print("⣿⣿⣿⣿⠏⠄⠄⠄⠄⠄⠄⠄⠄⠄⠸⢿⣿⣿⣿⣿⣿⣿⣿⣿")
  print("⣿⣿⣿⣏⠄⡠⡤⡤⡤⡤⡤⡤⡠⡤⡤⣸⣿⣿⣿⣿⣿⣿⣿⣿")
  print("⣿⣿⣿⣗⢝⢮⢯⡺⣕⢡⡑⡕⡍⣘⢮⢿⣿⣿⣿⣿⣿⣿⣿⣿")
  print("⣿⣿⣿⣿⡧⣝⢮⡪⡪⡪⡎⡎⡮⡲⣱⣻⣿⣿⣿⣿⣿⣿⣿⣿")
  print("⣿⣿⣿⠟⠁⢸⡳⡽⣝⢝⢌⢣⢃⡯⣗⢿⣿⣿⣿⣿⣿⣿⣿⣿")
  print("⣿⠟⠁⠄⠄⠄⠹⡽⣺⢽⢽⢵⣻⢮⢯⠟⠿⠿⢿⣿⣿⣿⣿⣿")
  print("⡟⢀⠄⠄⠄⠄⠄⠙⠽⠽⡽⣽⣺⢽⠝⠄⠄⢰⢸⢝⠽⣙⢝⢿")
  print("⡄⢸⢹⢸⢱⢘⠄⠄⠄⠄⠄⠈⠄⠄⠄⣀⠄⠄⣵⣧⣫⣶⣜⣾")
  print("⣧⣬⣺⠸⡒⠬⡨⠄⠄⠄⠄⠄⠄⠄⣰⣿⣿⣿⣿⣿⣷⣽⣿⣿")
  print("⣿⣿⣿⣷⠡⠑⠂⠄⠄⠄⠄⠄⠄⠄⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿")
  print("⣿⣿⣿⣿⣄⠠⢀⢀⢀⡀⡀⠠⢀⢲⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿")
  print("⣿⣿⣿⣿⣿⢐⢀⠂⢄⠇⠠⠈⠄⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿")
  print("⣿⣿⣿⣿⣧⠄⠠⠈⢈⡄⠄⢁⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿")
  print("⣿⣿⣿⣿⣿⡀⠠⠐⣼⠇⠄⡀⠸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿")
  print("⣿⣿⣿⣿⣯⠄⠄⡀⠈⠂⣀⠄⢀⠄⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿")
  print("⣿⣿⣿⣿⣿⣶⣄⣀⠐⢀⣸⣷⣶⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿")
end

function printGrid(g)
  for i = 0, #g.m do
    print(inspect(g.m[i]))
  end
end
