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

function love.mousemoved(x, y, dx, dy)
  if not pcall(function()
    root = lvl.grid:getRoot(drag[2][1], drag[2][2])
  end) then
    root = false
  end
  if state == 'grabbed' then
    if not pcall(function()
      drag[2] = rec:getID(x, y)
      --you are not intersecting another obstacle but if you are, it's your own
      if drag[2][1] == 0 or drag[2][2] == 0 then
        state = 'none'
        return 0
      end
      if lvl.grid:findTail(drag[2][1], drag[2][2]) ~= false then
        if root.h then
          --[[if (rec:hasObstacle(drag[2][1], drag[2][2]) or rec:hasObstacle(lvl.grid:findTail(drag[2][1], drag[2][2])[1], lvl.grid:findTail(drag[2][1], drag[2][2])[2])) and dx < 0 then
            print("there is already an obstacle here")
            return 0
          end]]
          if lvl.grid:findTail(drag[2][1], drag[2][2])[1] > lvl.grid.c and dx >= 0 then
            print("owwww")
            --state = 'none'
            return 0
          end
        else
          --[[if (rec:hasObstacle(drag[2][1], drag[2][2]) or rec:hasObstacle(lvl.grid:findTail(drag[2][1], drag[2][2])[1], lvl.grid:findTail(drag[2][1], drag[2][2])[2])) and dy < 0 then
            print("there is already an obstacle here")
            return 0
          end]]
          if lvl.grid:findTail(drag[2][1], drag[2][2])[2] > lvl.grid.r and dy >= 0 then
            print("owwww")
            lvl.grid:moveObstacle(drag[2][1], drag[2][2], drag[1][1], drag[1][2])
            --state = 'none'
            return 0
          end
        end
      end
      --print("lvl.grid:findTail(drag[2][1], drag[2][2])[1]: " .. inspect(lvl.grid:findTail(drag[2][1], drag[2][2])[1]))
      --print("lvl.grid:findTail(drag[2][1], drag[2][2])[2]: " .. inspect(lvl.grid:findTail(drag[2][1], drag[2][2])[2]))
      -- and ((not rec:hasObstacle(drag[2][1], drag[2][2])) or inspect(lvl.grid:findRoot(drag[2][1], drag[2][2])) == inspect(lvl.grid:findRoot(drag[1][1], drag[1][2])))
      if drag[2] ~= drag[1] and rec:hasObstacle(drag[1][1], drag[1][2]) and ((not rec:hasObstacle(drag[2][1], drag[2][2])) or inspect(lvl.grid:findRoot(drag[2][1], drag[2][2])) == inspect(lvl.grid:findRoot(drag[1][1], drag[1][2]))) then-- and lvl.grid:findTail(drag[2][1], drag[2][2])[1] <= lvl.grid.c and lvl.grid:findTail(drag[2][1], drag[2][2])[2] <= lvl.grid.r then
        print("wtf")
        lvl.grid:moveObstacle(drag[1][1], drag[1][2], drag[2][1], drag[2][2])
        drag[1] = drag[2]
        bob = lvl.grid:getRoot(drag[2][1], drag[2][2])
        if lvl.grid:findTail(drag[2][1], drag[2][2])[1] > lvl.grid.c and lvl.grid:findTail(drag[2][1], drag[2][2])[2] > lvl.grid.r then
          print("UwU")
          lvl.grid:moveObstacle(drag[2][1], drag[2][2], drag[2][1]-1, drag[1][2])
          bob = lvl.grid:getRoot(drag[1][1], drag[1][2])
        end
      else
        --assert(false)
        print("other oof")
        print("drag[2]: " .. inspect(drag[2]))
        print("drag[1]: " .. inspect(drag[1]))
        nX = drag[2][1]-2
        nY = drag[2][2]-2
        lvl.grid:moveObstacle(drag[2][1], drag[2][2], nX, drag[2][2])
        state = 'none'
      end
    end) then 
      lvl.grid:moveObstacle(drag[2][1], drag[2][2], drag[1][1], drag[1][2])
      print("oof")
      state = 'none'
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
