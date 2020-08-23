require "obstacle"
require "goal"
require "scales"
suit = require('suit-master')
local inspect = require("inspect")

--the Level object
Level = {
  grid = nil,
  ball = nil,
  obstacles = {},
  goal = nil
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
  if state == 'grabbed' then
    pcall(function()
      drag[2] = rec:getID(x, y)
      if not pcall(function()
        tail = lvl.grid:findTail(drag[2][1], drag[2][2])
      end) then
        return 0
      end
      --you are not intersecting another obstacle but if you are, it's your own
      --checks if you're backing into an object
      if drag[2] ~= drag[1] and rec:hasObstacle(drag[1][1], drag[1][2]) and ((not rec:hasObstacle(drag[2][1], drag[2][2])) or inspect(lvl.grid:findRoot(drag[2][1], drag[2][2])) == inspect(lvl.grid:findRoot(drag[1][1], drag[1][2]))) then
        lvl.grid:moveObstacle(drag[1][1], drag[1][2], drag[2][1], drag[2][2])
        drag[1] = drag[2]
      else
        --find a better way to do this
        state = 'none'
      end
    end)
  end
end
---------------------
--level constructor--
---------------------
local mt = {__index = Level}
function Level.new(grid, ball, obstacles, goal)
  local level = setmetatable({}, mt)
  level.grid = grid
  level.ball = ball
  level.obstacles = obstacles
  level.goal = goal
  return level
end
--draws the entire level
function Level:draw()
  self.goal:draw()
  self.grid:draw()
  for i,v in pairs(self.obstacles) do
    v:draw()
  end
  self.ball:draw()
  if suit.Button("Reset", getWidthFromDecimal(0.1), getWidthFromDecimal(0.025), 300,30).hit then
    resetLevel()
  end
end
--updates the entire level
function Level:update()
  self.ball:update()
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