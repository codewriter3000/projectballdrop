require "levels"
local inspect = require("inspect")

local level = 0
function getLevel()
  return level
end

function setLevel(l)
  level = l
  if l == 1 then
    lvl1()
  elseif l == 2 then
    lvl2()
  elseif l == 3 then
    lvl3()
  elseif l == 4 then
    lvl4()
  elseif l == 5 then
    lvl5()
  elseif l == 6 then
    lvl6()
  elseif l == 7 then
    lvl7()
  elseif l == 8 then
    lvl8()
  elseif l == 9 then
    lvl9()
  elseif l == 10 then
    lvl10()
  end
end

function resetLevel()
  l = getLevel()
  rec = Grid.new(0.1, 0.1, 0.8, 6, 6)
  drag = {}
  drag[1] = {}
  drag[2] = {}
  b = Ball.new(4, 2, rec, "south")
  os = {}
  o1 = Obstacle.new(2, {1, 0.5, 0}, 2, 2, false, rec)
  table.insert(os, o1)
  gl = Goal.new({1, 0, 0}, 4, 6, rec)
  lvl = Level.new(rec, b, os, gl)
  setLevel(l)
end

function lvl1()
  rec = Grid.new(0.1, 0.1, 0.8, 6, 6)
  drag = {}
  drag[1] = {}
  drag[2] = {}
  b = Ball.new(4, 2, rec, "south")
  os = {}

  o1 = Obstacle.new(2, {1, 0.5, 0}, 2, 2, false, rec)
  table.insert(os, o1)
  o2 = Obstacle.new(2, {1, 1, 0}, 6, 2, false, rec)
  table.insert(os, o2)
  o3 = Obstacle.new(2, {0.5, 0.5, 0}, 2, 1, true, rec)
  table.insert(os, o3)
  o4 = Obstacle.new(3, {0, 1, 1}, 4, 1, true, rec)
  table.insert(os, o4)
  o5 = Obstacle.new(3, {0, 0.5, 1}, 3, 4, true, rec)
  table.insert(os, o5)
  o6 = Obstacle.new(3, {0, 0.75, 0}, 1, 3, false, rec)
  table.insert(os, o6)
  o7 = Obstacle.new(3, {0.5, 0, 0.5}, 1, 6, true, rec) --(1, 6)
  table.insert(os, o7)
  gl = Goal.new({1, 0, 0}, 4, 6, rec)
  lvl = Level.new(rec, b, os, gl)
end

function lvl2()
  rec = Grid.new(0.1, 0.1, 0.8, 6, 6)
  drag = {}
  drag[1] = {}
  drag[2] = {}
  b = Ball.new(4, 2, rec, "south")
  os = {}

  o1 = Obstacle.new(3, {1, 0.5, 0}, 3, 4, false, rec)
  table.insert(os, o1)
  o2 = Obstacle.new(2, {1, 1, 0}, 4, 4, true, rec)
  table.insert(os, o2)
  o3 = Obstacle.new(2, {0.5, 0.5, 0}, 4, 5, true, rec)
  table.insert(os, o3)
  o4 = Obstacle.new(2, {0, 1, 1}, 4, 6, true, rec)
  table.insert(os, o4)
  o5 = Obstacle.new(3, {0, 0.5, 1}, 6, 4, false, rec)
  table.insert(os, o5)
  gl = Goal.new({1, 0, 0}, 4, 6, rec)
  lvl = Level.new(rec, b, os, gl)
end

function lvl3()
  rec = Grid.new(0.1, 0.1, 0.8, 6, 6)
  drag = {}
  drag[1] = {}
  drag[2] = {}
  b = Ball.new(4, 2, rec, "south")
  os = {}
  o1 = Obstacle.new(2, {1, 0.5, 0}, 1, 1, true, rec)
  table.insert(os, o1)
  o2 = Obstacle.new(3, {1, 1, 0}, 3, 1, true, rec)
  table.insert(os, o2)
  o3 = Obstacle.new(2, {0.5, 0.5, 0}, 6, 1, false, rec)
  table.insert(os, o3)
  o4 = Obstacle.new(3, {0, 1, 1}, 1, 3, false, rec)
  table.insert(os, o4)
  o5 = Obstacle.new(3, {0, 0.5, 1}, 3, 4, true, rec)
  table.insert(os, o5)
  o6 = Obstacle.new(2, {0, 0.75, 0}, 2, 5, false, rec)
  table.insert(os, o6)
  o7 = Obstacle.new(3, {0.5, 0, 0.5}, 4, 6, true, rec)
  table.insert(os, o7)
  gl = Goal.new({1, 0, 0}, 4, 6, rec)
  lvl = Level.new(rec, b, os, gl)
end

function lvl4()
  rec = Grid.new(0.1, 0.1, 0.8, 6, 6)
  drag = {}
  drag[1] = {}
  drag[2] = {}
  b = Ball.new(4, 2, rec, "south")
  os = {}
  o1 = Obstacle.new(3, {1, 0.5, 0}, 1, 1, true, rec)
  table.insert(os, o1)
  o2 = Obstacle.new(3, {1, 1, 0}, 6, 1, false, rec)
  table.insert(os, o2)
  o3 = Obstacle.new(3, {0.5, 0.5, 0}, 3, 4, true, rec)
  table.insert(os, o3)
  o4 = Obstacle.new(3, {0, 1, 1}, 1, 4, false, rec)
  table.insert(os, o4)
  o5 = Obstacle.new(2, {0, 0.5, 1}, 6, 4, false, rec)
  table.insert(os, o5)
  gl = Goal.new({1, 0, 0}, 4, 6, rec)
  lvl = Level.new(rec, b, os, gl)
end

function lvl5()
  rec = Grid.new(0.1, 0.1, 0.8, 6, 6)
  drag = {}
  drag[1] = {}
  drag[2] = {}
  b = Ball.new(4, 2, rec, "south")
  os = {}
  o1 = Obstacle.new(3, {1, 0.5, 0}, 1, 1, true, rec)
  table.insert(os, o1)
  o2 = Obstacle.new(3, {1, 1, 0}, 3, 2, false, rec)
  table.insert(os, o2)
  o3 = Obstacle.new(3, {0.5, 0.5, 0}, 6, 2, false, rec)
  table.insert(os, o3)
  o4 = Obstacle.new(2, {0, 1, 1}, 1, 4, true, rec)
  table.insert(os, o4)
  o5 = Obstacle.new(2, {0, 0.5, 1}, 4, 4, true, rec)
  table.insert(os, o5)
  o6 = Obstacle.new(2, {0, 0.75, 0}, 1, 5, false, rec)
  table.insert(os, o6)
  o7 = Obstacle.new(3, {0.5, 0, 0.5}, 2, 5, true, rec)
  table.insert(os, o7)
  o8 = Obstacle.new(2, {1, 0, 0.5}, 5, 5, true, rec)
  table.insert(os, o8)
  o9 = Obstacle.new(3, {0.5, 0, 1}, 4, 6, true, rec)
  table.insert(os, o9)
  gl = Goal.new({1, 0, 0}, 4, 6, rec)
  lvl = Level.new(rec, b, os, gl)
end

function lvl6()
  rec = Grid.new(0.1, 0.1, 0.8, 6, 6)
  drag = {}
  drag[1] = {}
  drag[2] = {}
  b = Ball.new(1, 3, rec, "east")
  os = {}
  o1 = Obstacle.new(3, {1, 0.5, 0}, 3, 2, false, rec)
  table.insert(os, o1)
  o2 = Obstacle.new(3, {1, 1, 0}, 4, 2, false, rec)
  table.insert(os, o2)
  o3 = Obstacle.new(2, {0.5, 0.5, 0}, 6, 3, false, rec)
  table.insert(os, o3)
  o4 = Obstacle.new(2, {0, 1, 1}, 1, 4, true, rec)
  table.insert(os, o4)
  o5 = Obstacle.new(2, {0, 0.5, 1}, 3, 5, true, rec)
  table.insert(os, o5)
  o6 = Obstacle.new(2, {0, 0.75, 0}, 2, 5, false, rec)
  table.insert(os, o6)
  o7 = Obstacle.new(2, {0.5, 0, 0.5}, 3, 6, true, rec)
  table.insert(os, o7)
  gl = Goal.new({1, 0, 0}, 6, 3, rec)
  lvl = Level.new(rec, b, os, gl)
end

function lvl7()
  rec = Grid.new(0.1, 0.1, 0.8, 6, 6)
  drag = {}
  drag[1] = {}
  drag[2] = {}
  b = Ball.new(2, 6, rec, "east")
  os = {}
  o1 = Obstacle.new(4, {1, 0.5, 0}, 1, 3, false, rec)
  table.insert(os, o1)
  o2 = Obstacle.new(4, {1, 1, 0}, 3, 3, false, rec)
  table.insert(os, o2)
  o3 = Obstacle.new(4, {0.5, 0.5, 0}, 4, 3, false, rec)
  table.insert(os, o3)
  o4 = Obstacle.new(4, {0, 1, 1}, 5, 3, false, rec)
  table.insert(os, o4)
  o5 = Obstacle.new(3, {0, 0.5, 1}, 2, 1, false, rec)
  table.insert(os, o5)
  o6 = Obstacle.new(2, {0, 0.75, 0}, 3, 1, true, rec)
  table.insert(os, o6)
  o7 = Obstacle.new(2, {0.5, 0, 0.5}, 3, 2, true, rec)
  table.insert(os, o7)
  gl = Goal.new({1, 0, 0}, 6, 6, rec)
  lvl = Level.new(rec, b, os, gl)
end

function lvl8()
  rec = Grid.new(0.1, 0.1, 0.8, 6, 6)
  drag = {}
  drag[1] = {}
  drag[2] = {}
  b = Ball.new(4, 1, rec, "east")
  os = {}
  o1 = Obstacle.new(3, {1, 0.5, 0}, 1, 1, true, rec)
  table.insert(os, o1)
  o2 = Obstacle.new(3, {1, 1, 0}, 4, 1, false, rec)
  table.insert(os, o2)
  o3 = Obstacle.new(3, {0.5, 0.5, 0}, 6, 1, false, rec)
  table.insert(os, o3)
  o4 = Obstacle.new(2, {0, 1, 1}, 1, 2, false, rec)
  table.insert(os, o4)
  o5 = Obstacle.new(3, {0, 0.5, 1}, 1, 4, false, rec)
  table.insert(os, o5)
  o6 = Obstacle.new(2, {0, 0.75, 0}, 2, 4, false, rec)
  table.insert(os, o6)
  o7 = Obstacle.new(2, {0.5, 0, 0.5}, 3, 4, false, rec)
  table.insert(os, o7)
  o8 = Obstacle.new(2, {1, 0, 0.5}, 4, 4, true, rec)
  table.insert(os, o8)
  o9 = Obstacle.new(2, {0.5, 0, 1}, 4, 5, true, rec)
  table.insert(os, o9)
  o10 = Obstacle.new(2, {0.75, 0, 1}, 6, 4, false, rec)
  table.insert(os, o10)
  o11 = Obstacle.new(2, {1, 0, 0.75}, 2, 6, true, rec)
  table.insert(os, o11)
  o12 = Obstacle.new(3, {0.5, 0, 0.75}, 4, 6, true, rec)
  table.insert(os, o12)
  gl = Goal.new({1, 0, 0}, 6, 1, rec)
  lvl = Level.new(rec, b, os, gl)
end

function lvl9()
  obstacleRadius = 15
  ballRadius = 15
  rec = Grid.new(0.1, 0.1, 0.8, 10, 10)
  drag = {}
  drag[1] = {}
  drag[2] = {}
  b = Ball.new(1, 3, rec, "east")
  os = {}
  o1 = Obstacle.new(3, {1, 0.5, 0}, 2, 1, true, rec)
  table.insert(os, o1)
  o2 = Obstacle.new(3, {1, 1, 0}, 5, 1, false, rec)
  table.insert(os, o2)
  o3 = Obstacle.new(2, {0.5, 0.5, 0}, 6, 1, false, rec)
  table.insert(os, o3)
  o4 = Obstacle.new(2, {0, 1, 1}, 7, 1, false, rec)
  table.insert(os, o4)
  o5 = Obstacle.new(2, {0, 0.5, 1}, 8, 1, false, rec)
  table.insert(os, o5)
  o6 = Obstacle.new(2, {0, 0.75, 0}, 3, 2, false, rec)
  table.insert(os, o6)
  o7 = Obstacle.new(2, {0.5, 0, 0.5}, 4, 2, false, rec)
  table.insert(os, o7)
  o8 = Obstacle.new(3, {1, 0, 0.5}, 6, 3, false, rec)
  table.insert(os, o8)
  o9 = Obstacle.new(3, {0.5, 0, 1}, 7, 3, false, rec)
  table.insert(os, o9)
  o10 = Obstacle.new(4, {0.75, 0, 1}, 8, 3, false, rec)
  table.insert(os, o10)
  o11 = Obstacle.new(4, {1, 0, 0.75}, 9, 3, false, rec)
  table.insert(os, o11)
  o12 = Obstacle.new(3, {0.5, 0, 0.75}, 3, 4, false, rec)
  table.insert(os, o12)
  o13 = Obstacle.new(3, {0.75, 0, 0.5}, 4, 4, false, rec)
  table.insert(os, o13)
  o14 = Obstacle.new(3, {0, 1, 0.75}, 6, 6, false, rec)
  table.insert(os, o14)
  o15 = Obstacle.new(3, {0, 0.75, 1}, 7, 6, false, rec)
  table.insert(os, o15)
  o16 = Obstacle.new(3, {0.75, 1, 0}, 3, 7, true, rec)
  table.insert(os, o16)
  o17 = Obstacle.new(3, {1, 0.75, 0}, 3, 8, true, rec)
  table.insert(os, o17)
  o18 = Obstacle.new(2, {0.5, 1, 0.75}, 3, 9, false, rec)
  table.insert(os, o18)
  o19 = Obstacle.new(2, {0.75, 1, 0.5}, 4, 9, false, rec)
  table.insert(os, o19)
  o20 = Obstacle.new(3, {1, 1, 0.75}, 5, 9, true, rec)
  table.insert(os, o20)
  o21 = Obstacle.new(3, {1, 0.75, 1}, 5, 10, true, rec)
  table.insert(os, o21)
  --o22 = Obstacle.new(2, {0.75, 1, 1}, 8, 9, true, rec)
  --table.insert(os, o22)
  gl = Goal.new({1, 0, 0}, 10, 3, rec)
  lvl = Level.new(rec, b, os, gl)
end

function lvl10()
  obstacleRadius = 27
  ballRadius = 27
  rec = Grid.new(0.1, 0.1, 0.8, 7, 7)
  drag = {}
  drag[1] = {}
  drag[2] = {}
  b = Ball.new(1, 5, rec, "east")
  os = {}
  o1 = Obstacle.new(3, {1, 0.5, 0}, 1, 1, true, rec)
  table.insert(os, o1)
  o2 = Obstacle.new(3, {1, 1, 0}, 6, 1, false, rec)
  table.insert(os, o2)
  o3 = Obstacle.new(3, {0.5, 0.5, 0}, 3, 4, true, rec)
  table.insert(os, o3)
  o4 = Obstacle.new(3, {0, 1, 1}, 1, 5, false, rec)
  table.insert(os, o4)
  o5 = Obstacle.new(2, {0, 0.5, 1}, 6, 4, false, rec)
  table.insert(os, o5)
  o6 = Obstacle.new(3, {0, 0.75, 0}, 5, 7, true, rec)
  table.insert(os, o6)
  o7 = Obstacle.new(2, {0.5, 0, 0.5}, 2, 7, true, rec)
  table.insert(os, o7)
  gl = Goal.new({1, 0, 0}, 7, 5, rec)
  lvl = Level.new(rec, b, os, gl)
end

function gameComplete()
  love.graphics.print("CONGRATULATIONS")
end
