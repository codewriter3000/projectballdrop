require "obstacle"
local inspect = require("inspect")

--the Level object
Level = {
  grid = nil,
  ball = nil,
  obstacles = {},
}
----------------
--mouse events--
----------------
local state = 'none' --can be 'none' or 'grabbed' (enum?)
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
local bdrag = nil
function love.mousemoved(x, y, dx, dy)
  if not pcall(function()
    root = lvl.grid:getRoot(drag[2][1], drag[2][2])
  end) then
    root = false
  end
  -- a giant mess that needs to be fixed
  if state == 'grabbed' then
    --if not pcall(function()
      drag[2] = rec:getID(x, y)
      tail = lvl.grid:findTail(drag[2][1], drag[2][2])
      --you are not intersecting another obstacle but if you are, it's your own
      --???if root or tail are false then give them a previous working root and tail
      --[[if root ~= false and tail ~= false then
        if (drag[2][1] == 0 or drag[2][2] == 0) or (root.h and tail[1] > lvl.grid.c) or (not root.h and tail[2] > lvl.grid.r) then
          --you are colliding with the grid border
          drag[2] = bdrag
          return 0
        end
      else
        --move complete
        bdrag = drag[1]
      end]]
      --checks if you're backing into an object
      if drag[2] ~= drag[1] and rec:hasObstacle(drag[1][1], drag[1][2]) and ((not rec:hasObstacle(drag[2][1], drag[2][2])) or inspect(lvl.grid:findRoot(drag[2][1], drag[2][2])) == inspect(lvl.grid:findRoot(drag[1][1], drag[1][2]))) then
        lvl.grid:moveObstacle(drag[1][1], drag[1][2], drag[2][1], drag[2][2])
        drag[1] = drag[2]
      else
        state = 'none'
      end
    --[[end) then 
      print("djf")
      state = 'none'
    end]]
  end
end
--level constructor
local mt = {__index = Level}
function Level.new(grid, ball, obstacles)
  local level = setmetatable({}, mt)
  level.grid = grid
  level.ball = ball
  level.obstacles = obstacles
  return level
end
--draws the entire level
function Level:draw()
  if not pcall(function()
    self.grid:draw()
    for i,v in pairs(self.obstacles) do
      v:draw()
    end
    self.ball:draw()
  end) then
  end
end
--updates the entire level
function Level:update()
  self.ball:update()
  for i,v in pairs(self.obstacles) do
    v:update()
  end
end
--a meme used for debugging purposes
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
--prints true or false based on if there is an object in each grid cell
function printGrid(g)
  for i = 0, #g.m do
    print(inspect(g.m[i]))
  end
end
