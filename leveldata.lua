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
  elseif l == 11 then
    lvl11()
  elseif l == 12 then
    lvl12()
  elseif l == 13 then
    lvl13()
  elseif l == 14 then
    lvl14()
  elseif l == 15 then
    lvl15()
  elseif l == 16 then
    lvl16()
  elseif l == 17 then
    lvl17()
  elseif l == 18 then
    lvl18()
  elseif l == 19 then
    lvl19()
  elseif l == 20 then
    lvl20()
  elseif l == 21 then
    lvl21()
  elseif l == 22 then
    lvl22()
  elseif l == 23 then
    lvl23()
  elseif l == 24 then
    lvl24()
  elseif l == 25 then
    lvl25()
  elseif l == 26 then
    lvl26()
  elseif l == 27 then
    lvl27()
  elseif l == 28 then
    lvl28()
  elseif l == 29 then
    lvl29()
  elseif l == 30 then
    lvl30()
  elseif l == 31 then
    lvl31()
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
  obstacleRadius = rec.xCount * 0.4
  ballRadius = rec.yCount * 0.4
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
  obstacleRadius = rec.xCount * 0.4
  ballRadius = rec.yCount * 0.4
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
  obstacleRadius = rec.xCount * 0.4
  ballRadius = rec.yCount * 0.4
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
  obstacleRadius = rec.xCount * 0.4
  ballRadius = rec.yCount * 0.4
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
  obstacleRadius = rec.xCount * 0.4
  ballRadius = rec.yCount * 0.4
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
  obstacleRadius = rec.xCount * 0.4
  ballRadius = rec.yCount * 0.4
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
  obstacleRadius = rec.xCount * 0.4
  ballRadius = rec.yCount * 0.4
  drag = {}
  drag[1] = {}
  drag[2] = {}
  b = Ball.new(1, 6, rec, "east")
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
  obstacleRadius = rec.xCount * 0.4
  ballRadius = rec.yCount * 0.4
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
  rec = Grid.new(0.1, 0.1, 0.8, 10, 10)
  obstacleRadius = rec.xCount * 0.4
  ballRadius = rec.yCount * 0.4
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
  rec = Grid.new(0.1, 0.1, 0.8, 7, 7)
  obstacleRadius = rec.xCount * 0.4
  ballRadius = rec.yCount * 0.4
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

function lvl11()
  rec = Grid.new(0.1, 0.1, 0.8, 5, 5)
  obstacleRadius = rec.xCount * 0.4
  ballRadius = rec.yCount * 0.4
  drag = {}
  drag[1] = {}
  drag[2] = {}
  b = Ball.new(3, 4, rec, "north")
  os = {}
  o1 = Obstacle.new(3, {1, 0.5, 0}, 1, 1, false, rec)
  table.insert(os, o1)
  o2 = Obstacle.new(2, {1, 1, 0}, 2, 1, true, rec)
  table.insert(os, o2)
  o3 = Obstacle.new(2, {0.5, 0.5, 0}, 2, 2, false, rec)
  table.insert(os, o3)
  o4 = Obstacle.new(2, {0, 1, 1}, 3, 2, true, rec)
  table.insert(os, o4)
  o5 = Obstacle.new(4, {0, 0.5, 1}, 5, 1, false, rec)
  table.insert(os, o5)
  o6 = Obstacle.new(2, {0, 0.75, 0}, 2, 4, true, rec)
  table.insert(os, o6)
  o7 = Obstacle.new(3, {0.5, 0, 0.5}, 1, 5, true, rec)
  table.insert(os, o7)
  gl = Goal.new({1, 0, 0}, 3, 1, rec)
  lvl = Level.new(rec, b, os, gl)
end

function lvl12()
  rec = Grid.new(0.1, 0.1, 0.8, 5, 5)
  obstacleRadius = rec.xCount * 0.4
  ballRadius = rec.yCount * 0.4
  drag = {}
  drag[1] = {}
  drag[2] = {}
  b = Ball.new(4, 5, rec, "north")
  os = {}
  o1 = Obstacle.new(2, {1, 0.5, 0}, 1, 2, false, rec)
  table.insert(os, o1)
  o2 = Obstacle.new(3, {1, 1, 0}, 1, 1, true, rec)
  table.insert(os, o2)
  o3 = Obstacle.new(2, {0.5, 0.5, 0}, 3, 2, true, rec)
  table.insert(os, o3)
  o4 = Obstacle.new(3, {0, 1, 1}, 3, 3, true, rec)
  table.insert(os, o4)
  o5 = Obstacle.new(3, {0, 0.5, 1}, 1, 4, true, rec)
  table.insert(os, o5)
  o6 = Obstacle.new(4, {0, 0.75, 0}, 1, 5, true, rec)
  table.insert(os, o6)
  gl = Goal.new({1, 0, 0}, 4, 1, rec)
  lvl = Level.new(rec, b, os, gl)
end

function lvl13()
  rec = Grid.new(0.1, 0.1, 0.8, 8, 8)
  obstacleRadius = rec.xCount * 0.4
  ballRadius = rec.yCount * 0.4
  drag = {}
  drag[1] = {}
  drag[2] = {}
  b = Ball.new(2, 7, rec, "north")
  os = {}
  o1 = Obstacle.new(4, {1, 0.5, 0}, 1, 1, true, rec)
  table.insert(os, o1)
  o2 = Obstacle.new(3, {1, 1, 0}, 6, 1, false, rec)
  table.insert(os, o2)
  o3 = Obstacle.new(2, {0.5, 0.5, 0}, 3, 2, false, rec)
  table.insert(os, o3)
  o4 = Obstacle.new(3, {0, 1, 1}, 8, 2, false, rec)
  table.insert(os, o4)
  o5 = Obstacle.new(2, {0, 0.5, 1}, 1, 3, true, rec)
  table.insert(os, o5)
  o6 = Obstacle.new(4, {0, 0.75, 0}, 1, 4, true, rec)
  table.insert(os, o6)
  o7 = Obstacle.new(3, {0.5, 0, 0.5}, 6, 5, false, rec)
  table.insert(os, o7)
  o8 = Obstacle.new(4, {1, 0, 0.5}, 7, 4, false, rec)
  table.insert(os, o8)
  o9 = Obstacle.new(3, {0.5, 0, 1}, 1, 5, true, rec)
  table.insert(os, o9)
  o10 = Obstacle.new(4, {0.75, 0, 1}, 8, 5, false, rec)
  table.insert(os, o10)
  o11 = Obstacle.new(2, {1, 0, 0.75}, 4, 7, true, rec)
  table.insert(os, o11)
  o12 = Obstacle.new(2, {0.5, 0, 0.75}, 6, 8, true, rec)
  table.insert(os, o12)
  gl = Goal.new({1, 0, 0}, 2, 1, rec)
  lvl = Level.new(rec, b, os, gl)
end

function lvl14()
  rec = Grid.new(0.1, 0.1, 0.8, 8, 8)
  obstacleRadius = rec.xCount * 0.4
  ballRadius = rec.yCount * 0.4
  drag = {}
  drag[1] = {}
  drag[2] = {}
  b = Ball.new(2, 7, rec, "north")
  os = {}
  o1 = Obstacle.new(4, {255/255, 160/255, 122/255}, 2, 1, true, rec)
  table.insert(os, o1)
  o2 = Obstacle.new(3, {250/255, 128/255, 114/255}, 6, 1, false, rec)
  table.insert(os, o2)
  o3 = Obstacle.new(2, {233/255, 150/255, 122/255}, 4, 2, false, rec)
  table.insert(os, o3)
  o4 = Obstacle.new(4, {240/255, 128/255, 128/255}, 1, 1, false, rec)
  table.insert(os, o4)
  o5 = Obstacle.new(2, {205/255, 92/255, 92/255}, 2, 3, true, rec)
  table.insert(os, o5)
  o6 = Obstacle.new(4, {220/255, 20/255, 60/255}, 2, 4, true, rec)
  table.insert(os, o6)
  o7 = Obstacle.new(3, {178/255, 34/255, 34/255}, 6, 5, false, rec)
  table.insert(os, o7)
  o8 = Obstacle.new(4, {1, 0, 0}, 7, 4, false, rec)
  table.insert(os, o8)
  o9 = Obstacle.new(3, {139/255, 0, 0}, 2, 5, true, rec)
  table.insert(os, o9)
  o10 = Obstacle.new(4, {128/255, 0, 0}, 8, 5, false, rec)
  table.insert(os, o10)
  o11 = Obstacle.new(2, {255/255, 99/255, 71/255}, 4, 7, true, rec)
  table.insert(os, o11)
  o12 = Obstacle.new(2, {255/255, 69/255, 0}, 6, 8, true, rec)
  table.insert(os, o12)
  gl = Goal.new({1, 0, 0}, 2, 1, rec)
  lvl = Level.new(rec, b, os, gl)
end

function lvl15()
  rec = Grid.new(0.1, 0.1, 0.8, 7, 7)
  obstacleRadius = rec.xCount * 0.4
  ballRadius = rec.yCount * 0.4
  drag = {}
  drag[1] = {}
  drag[2] = {}
  b = Ball.new(2, 5, rec, "east")
  os = {}
  o1 = Obstacle.new(3, {30/255, 144/255, 1}, 1, 1, true, rec)
  table.insert(os, o1)
  o2 = Obstacle.new(3, {230/255, 230/255, 250/255}, 6, 1, false, rec)
  table.insert(os, o2)
  o3 = Obstacle.new(3, {65/255, 105/255, 225/255}, 3, 4, true, rec)
  table.insert(os, o3)
  o4 = Obstacle.new(3, {70/255, 130/255, 180/255}, 1, 5, false, rec)
  table.insert(os, o4)
  o5 = Obstacle.new(2, {135/206, 206/255, 250/255}, 6, 4, false, rec)
  table.insert(os, o5)
  o6 = Obstacle.new(3, {135/255, 206/255, 235/255}, 5, 7, true, rec)
  table.insert(os, o6)
  o7 = Obstacle.new(2, {0, 191/255, 1}, 3, 7, true, rec)
  table.insert(os, o7)
  o8 = Obstacle.new(3, {123/155, 104/255, 238/255}, 1, 2, false, rec)
  table.insert(os, o8)
  o9 = Obstacle.new(6, {0, 0, 1}, 2, 2, false, rec)
  table.insert(os, o9)
  gl = Goal.new({1, 0, 0}, 7, 5, rec)
  lvl = Level.new(rec, b, os, gl)
end

function lvl16()
  rec = Grid.new(0.1, 0.1, 0.8, 4, 4)
  obstacleRadius = rec.xCount * 0.4
  ballRadius = rec.yCount * 0.4
  drag = {}
  drag[1] = {}
  drag[2] = {}
  b = Ball.new(5, 1, rec, "west")
  os = {}
  o1 = Obstacle.new(2, {1, 0.5, 0}, 3, 1, false, rec)
  table.insert(os, o1)
  o2 = Obstacle.new(2, {1, 1, 0}, 2, 1, false, rec)
  table.insert(os, o2)
  o3 = Obstacle.new(2, {0.5, 0.5, 0}, 1, 1, false, rec)
  table.insert(os, o3)
  o6 = Obstacle.new(2, {0, 0.75, 0}, 4, 3, false, rec)
  table.insert(os, o6)
  gl = Goal.new({1, 0, 0}, 1, 1, rec)
  lvl = Level.new(rec, b, os, gl)
end

function lvl17()
  rec = Grid.new(0.1, 0.1, 0.8, 6, 6)
  obstacleRadius = rec.xCount * 0.4
  ballRadius = rec.yCount * 0.4
  drag = {}
  drag[1] = {}
  drag[2] = {}
  b = Ball.new(6, 3, rec, "west")
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
  o6 = Obstacle.new(2, {0, 0.75, 0}, 1, 3, false, rec)
  table.insert(os, o6)
  o7 = Obstacle.new(3, {0.5, 0, 0.5}, 1, 6, true, rec) --(1, 6)
  table.insert(os, o7)
  o8 = Obstacle.new(2, {1, 0, 0.5}, 1, 1, false, rec) --(1, 6)
  table.insert(os, o8)
  o9 = Obstacle.new(2, {0.5, 0, 1}, 4, 2, false, rec)
  table.insert(os, o9)
  o10 = Obstacle.new(2, {0.75, 0, 1}, 3, 2, false, rec)
  table.insert(os, o10)
  gl = Goal.new({1, 0, 0}, 1, 3, rec)
  lvl = Level.new(rec, b, os, gl)
end

function lvl18()
  rec = Grid.new(0.1, 0.1, 0.8, 6, 6)
  obstacleRadius = rec.xCount * 0.4
  ballRadius = rec.yCount * 0.4
  drag = {}
  drag[1] = {}
  drag[2] = {}
  b = Ball.new(6, 3, rec, "west")
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
  o8 = Obstacle.new(3, {1, 0, 0.5}, 1, 1, false, rec) --(1, 6)
  table.insert(os, o8)
  gl = Goal.new({1, 0, 0}, 1, 3, rec)
  lvl = Level.new(rec, b, os, gl)
end

function lvl19()
  obstacleRadius = rec.xCount * 0.4
  ballRadius = rec.yCount * 0.4
  rec = Grid.new(0.1, 0.1, 0.8, 6, 6)
  drag = {}
  drag[1] = {}
  drag[2] = {}
  b = Ball.new(6, 3, rec, "west")
  os = {}
  o1 = Obstacle.new(2, {1, 0.5, 0}, 1, 1, true, rec)
  table.insert(os, o1)
  o2 = Obstacle.new(3, {1, 1, 0}, 3, 1, true, rec)
  table.insert(os, o2)
  o3 = Obstacle.new(2, {0.5, 0.5, 0}, 6, 1, false, rec)
  table.insert(os, o3)
  o4 = Obstacle.new(3, {0, 1, 1}, 1, 2, false, rec)
  table.insert(os, o4)
  o5 = Obstacle.new(3, {0, 0.5, 1}, 2, 4, true, rec)
  table.insert(os, o5)
  o6 = Obstacle.new(2, {0, 0.75, 0}, 2, 2, false, rec)
  table.insert(os, o6)
  o7 = Obstacle.new(3, {0.5, 0, 0.5}, 1, 6, true, rec)
  table.insert(os, o7)
  o8 = Obstacle.new(2, {1, 0, 0.5}, 3, 2, false, rec)
  table.insert(os, o8)
  gl = Goal.new({1, 0, 0}, 1, 3, rec)
  lvl = Level.new(rec, b, os, gl)
end

function lvl20()
  obstacleRadius = rec.xCount * 0.4
  ballRadius = rec.yCount * 0.4
  rec = Grid.new(0.1, 0.1, 0.8, 10, 10)
  drag = {}
  drag[1] = {}
  drag[2] = {}
  b = Ball.new(3, 2, rec, "west")
  os = {}
  o1 = Obstacle.new(4, {1, 0.5, 0}, 1, 1, false, rec)
  table.insert(os, o1)
  o2 = Obstacle.new(3, {1, 1, 0}, 3, 1, false, rec)
  table.insert(os, o2)
  o3 = Obstacle.new(3, {0.5, 0.5, 0}, 4, 1, false, rec)
  table.insert(os, o3)
  o4 = Obstacle.new(3, {0, 1, 1}, 5, 1, true, rec)
  table.insert(os, o4)
  o5 = Obstacle.new(3, {0, 0.5, 1}, 8, 1, true, rec)
  table.insert(os, o5)
  o6 = Obstacle.new(3, {0, 0.75, 0}, 5, 2, true, rec)
  table.insert(os, o6)
  o7 = Obstacle.new(3, {0.5, 0, 0.5}, 10, 2, false, rec)
  table.insert(os, o7)
  o8 = Obstacle.new(3, {1, 0, 0.5}, 2, 4, true, rec)
  table.insert(os, o8)
  o9 = Obstacle.new(2, {0.5, 0, 1}, 7, 4, false, rec)
  table.insert(os, o9)
  o10 = Obstacle.new(3, {0.75, 0, 1}, 10, 5, false, rec)
  table.insert(os, o10)
  o11 = Obstacle.new(4, {1, 0, 0.75}, 1, 6, false, rec)
  table.insert(os, o11)
  o12 = Obstacle.new(4, {0.5, 0, 0.75}, 4, 6, true, rec)
  table.insert(os, o12)
  o13 = Obstacle.new(3, {0.75, 0, 0.5}, 4, 7, true, rec)
  table.insert(os, o13)
  --o14 = Obstacle.new(3, {0, 1, 0.75}, 6, 6, false, rec)
  --table.insert(os, o14)
  --o15 = Obstacle.new(3, {0, 0.75, 1}, 7, 6, false, rec)
  --table.insert(os, o15)
  --o16 = Obstacle.new(3, {0.75, 1, 0}, 3, 7, true, rec)
  --table.insert(os, o16)
  o17 = Obstacle.new(3, {1, 0.75, 0}, 7, 7, false, rec)
  table.insert(os, o17)
  o18 = Obstacle.new(3, {0.5, 1, 0.75}, 4, 8, false, rec)
  table.insert(os, o18)
  o19 = Obstacle.new(3, {0.75, 1, 0.5}, 10, 8, false, rec)
  table.insert(os, o19)
  o20 = Obstacle.new(3, {1, 1, 0.75}, 1, 10, true, rec)
  table.insert(os, o20)
  o21 = Obstacle.new(3, {1, 0.75, 1}, 7, 10, true, rec)
  table.insert(os, o21)
  gl = Goal.new({1, 0, 0}, 1, 2, rec)
  lvl = Level.new(rec, b, os, gl)
end

function lvl21()
  obstacleRadius = 15
  ballRadius = 15
  rec = Grid.new(0.1, 0.1, 0.8, 10, 10)
  drag = {}
  drag[1] = {}
  drag[2] = {}
  b = Ball.new(2, 10, rec, "north")
  os = {}
  o1 = Obstacle.new(3, {1, 0.5, 0}, 6, 2, false, rec)
  table.insert(os, o1)
  o2 = Obstacle.new(3, {1, 1, 0}, 8, 2, false, rec)
  table.insert(os, o2)
  o3 = Obstacle.new(2, {0.5, 0.5, 0}, 1, 3, true, rec)
  table.insert(os, o3)
  o4 = Obstacle.new(2, {0, 1, 1}, 1, 4, true, rec)
  table.insert(os, o4)
  o5 = Obstacle.new(3, {0, 0.5, 1}, 1, 5, false, rec)
  table.insert(os, o5)
  o6 = Obstacle.new(3, {0, 0.75, 0}, 1, 8, true, rec)
  table.insert(os, o6)
  o7 = Obstacle.new(2, {0.5, 0, 0.5}, 4, 8, false, rec)
  table.insert(os, o7)
  o8 = Obstacle.new(3, {1, 0, 0.5}, 2, 6, true, rec)
  table.insert(os, o8)
  o9 = Obstacle.new(3, {0.5, 0, 1}, 3, 3, false, rec)
  table.insert(os, o9)
  o10 = Obstacle.new(4, {0.75, 0, 1}, 6, 5, true, rec)
  table.insert(os, o10)
  o11 = Obstacle.new(3, {1, 0, 0.75}, 7, 6, false, rec)
  table.insert(os, o11)
  --[[o12 = Obstacle.new(4, {0.5, 0, 0.75}, 4, 6, true, rec)
  table.insert(os, o12)
  o13 = Obstacle.new(3, {0.75, 0, 0.5}, 4, 7, true, rec)
  table.insert(os, o13)
  --o14 = Obstacle.new(3, {0, 1, 0.75}, 6, 6, false, rec)
  --table.insert(os, o14)
  --o15 = Obstacle.new(3, {0, 0.75, 1}, 7, 6, false, rec)
  --table.insert(os, o15)
  --o16 = Obstacle.new(3, {0.75, 1, 0}, 3, 7, true, rec)
  --table.insert(os, o16)
  o17 = Obstacle.new(3, {1, 0.75, 0}, 7, 7, false, rec)
  table.insert(os, o17)
  o18 = Obstacle.new(3, {0.5, 1, 0.75}, 4, 8, false, rec)
  table.insert(os, o18)
  o19 = Obstacle.new(3, {0.75, 1, 0.5}, 10, 8, false, rec)
  table.insert(os, o19)
  o20 = Obstacle.new(3, {1, 1, 0.75}, 1, 10, true, rec)
  table.insert(os, o20)
  o21 = Obstacle.new(3, {1, 0.75, 1}, 7, 10, true, rec)
  table.insert(os, o21)]]
  gl = Goal.new({1, 0, 0}, 2, 1, rec)
  lvl = Level.new(rec, b, os, gl)
end

function lvl22()
  obstacleRadius = 27
  ballRadius = 27
  rec = Grid.new(0.1, 0.1, 0.8, 7, 7)
  drag = {}
  drag[1] = {}
  drag[2] = {}
  b = Ball.new(3, 4, rec, "east")
  os = {}
  o1 = Obstacle.new(3, {1, 0.5, 0}, 2, 1, false, rec)
  table.insert(os, o1)
  o2 = Obstacle.new(5, {1, 1, 0}, 3, 1, true, rec)
  table.insert(os, o2)
  o3 = Obstacle.new(3, {0.5, 0.5, 0}, 4, 2, false, rec)
  table.insert(os, o3)
  o4 = Obstacle.new(2, {0, 1, 1}, 1, 4, true, rec)
  table.insert(os, o4)
  o5 = Obstacle.new(3, {0, 0.5, 1}, 1, 5, true, rec)
  table.insert(os, o5)
  o6 = Obstacle.new(2, {0, 0.75, 0}, 1, 6, false, rec)
  table.insert(os, o6)
  o7 = Obstacle.new(3, {0.5, 0, 0.5}, 4, 7, true, rec)
  table.insert(os, o7)
  o8 = Obstacle.new(3, {1, 0, 0.5}, 7, 5, false, rec)
  table.insert(os, o8)
  gl = Goal.new({1, 0, 0}, 7, 4, rec)
  lvl = Level.new(rec, b, os, gl)
end

function lvl23()
  obstacleRadius = 27
  ballRadius = 27
  rec = Grid.new(0.1, 0.1, 0.8, 7, 7)
  drag = {}
  drag[1] = {}
  drag[2] = {}
  b = Ball.new(3, 3, rec, "south")
  os = {}
  o1 = Obstacle.new(2, {1, 0.5, 0}, 2, 1, false, rec)
  table.insert(os, o1)
  --o2 = Obstacle.new(2, {1, 1, 0}, 3, 1, false, rec)
  --table.insert(os, o2)
  o3 = Obstacle.new(4, {0.5, 0.5, 0}, 4, 1, true, rec)
  table.insert(os, o3)
  o4 = Obstacle.new(3, {0, 1, 1}, 1, 3, true, rec)
  table.insert(os, o4)
  o5 = Obstacle.new(4, {0, 0.5, 1}, 6, 2, false, rec)
  table.insert(os, o5)
  o6 = Obstacle.new(4, {0, 0.75, 0}, 7, 4, false, rec)
  table.insert(os, o6)
  o7 = Obstacle.new(4, {0.5, 0, 0.5}, 1, 5, true, rec)
  table.insert(os, o7)
  o8 = Obstacle.new(4, {1, 0, 0.5}, 1, 6, true, rec)
  table.insert(os, o8)
  o9 = Obstacle.new(3, {0.5, 0, 1}, 3, 7, true, rec)
  table.insert(os, o9)
  gl = Goal.new({1, 0, 0}, 3, 7, rec)
  lvl = Level.new(rec, b, os, gl)
end

function lvl24()
  obstacleRadius = 27
  ballRadius = 27
  rec = Grid.new(0.1, 0.1, 0.8, 7, 7)
  drag = {}
  drag[1] = {}
  drag[2] = {}
  b = Ball.new(7, 6, rec, "west")
  os = {}
  o1 = Obstacle.new(2, {1, 0.5, 0}, 1, 1, false, rec)
  table.insert(os, o1)
  o2 = Obstacle.new(2, {1, 1, 0}, 3, 1, true, rec)
  table.insert(os, o2)
  --o3 = Obstacle.new(2, {0.5, 0.5, 0}, 5, 1, false, rec)
  --table.insert(os, o3)
  o4 = Obstacle.new(2, {0, 1, 1}, 6, 1, true, rec)
  table.insert(os, o4)
  o5 = Obstacle.new(2, {0, 0.5, 1}, 2, 2, true, rec)
  table.insert(os, o5)
  --o6 = Obstacle.new(2, {0, 0.75, 0}, 4, 2, false, rec)
  --table.insert(os, o6)
  o7 = Obstacle.new(2, {0.5, 0, 0.5}, 6, 2, true, rec)
  table.insert(os, o7)
  o8 = Obstacle.new(2, {1, 0, 0.5}, 1, 3, false, rec)
  table.insert(os, o8)
  o9 = Obstacle.new(2, {0.5, 0, 1}, 6, 3, false, rec)
  table.insert(os, o9)
  o10 = Obstacle.new(2, {0.75, 0, 1}, 2, 4, true, rec)
  table.insert(os, o10)
  o11 = Obstacle.new(2, {1, 0, 0.75}, 4, 4, true, rec)
  table.insert(os, o11)
  o12 = Obstacle.new(2, {0.5, 0, 0.75}, 1, 5, true, rec)
  table.insert(os, o12)
  o13 = Obstacle.new(2, {0.75, 0, 0.5}, 3, 5, false, rec)
  table.insert(os, o13)
  o14 = Obstacle.new(2, {0, 1, 0.75}, 5, 5, true, rec)
  table.insert(os, o14)
  o15 = Obstacle.new(2, {0, 0.75, 1}, 7, 5, false, rec)
  table.insert(os, o15)
  o16 = Obstacle.new(2, {0.75, 1, 0}, 2, 6, false, rec)
  table.insert(os, o16)
  o17 = Obstacle.new(2, {1, 0.75, 0}, 5, 6, false, rec)
  table.insert(os, o17)
  o18 = Obstacle.new(2, {0.5, 1, 0.75}, 3, 7, true, rec)
  table.insert(os, o18)
  o19 = Obstacle.new(2, {0.75, 1, 0.5}, 6, 7, true, rec)
  table.insert(os, o19)
  --[[o20 = Obstacle.new(3, {1, 1, 0.75}, 1, 10, true, rec)
  table.insert(os, o20)
  o21 = Obstacle.new(3, {1, 0.75, 1}, 7, 10, true, rec)
  table.insert(os, o21)]]
  gl = Goal.new({1, 0, 0}, 1, 6, rec)
  lvl = Level.new(rec, b, os, gl)
end

function lvl25()
  obstacleRadius = 38
  ballRadius = 38
  rec = Grid.new(0.1, 0.1, 0.8, 4, 4)
  drag = {}
  drag[1] = {}
  drag[2] = {}
  b = Ball.new(5, 1, rec, "west")
  os = {}
  o1 = Obstacle.new(2, {1, 0.5, 0}, 3, 1, false, rec)
  table.insert(os, o1)
  o2 = Obstacle.new(2, {1, 1, 0}, 2, 3, true, rec)
  table.insert(os, o2)
  o3 = Obstacle.new(2, {0.5, 0.5, 0}, 1, 1, false, rec)
  table.insert(os, o3)
  o6 = Obstacle.new(2, {0, 0.75, 0}, 4, 3, false, rec)
  table.insert(os, o6)
  gl = Goal.new({1, 0, 0}, 1, 1, rec)
  lvl = Level.new(rec, b, os, gl)
end

function lvl26()
  obstacleRadius = 30
  ballRadius = 30
  rec = Grid.new(0.1, 0.1, 0.8, 6, 6)
  drag = {}
  drag[1] = {}
  drag[2] = {}
  b = Ball.new(1, 6, rec, "north")
  os = {}
  o1 = Obstacle.new(3, {1, 0.5, 0}, 1, 2, true, rec)
  table.insert(os, o1)
  o2 = Obstacle.new(2, {1, 1, 0}, 1, 3, true, rec)
  table.insert(os, o2)
  o3 = Obstacle.new(3, {0.5, 0.5, 0}, 1, 4, true, rec)
  table.insert(os, o3)
  o4 = Obstacle.new(2, {0, 1, 1}, 4, 1, false, rec)
  table.insert(os, o4)
  o5 = Obstacle.new(2, {0, 0.5, 1}, 4, 3, false, rec)
  table.insert(os, o5)
  gl = Goal.new({1, 0, 0}, 1, 1, rec)
  lvl = Level.new(rec, b, os, gl)
end

function lvl27()
  obstacleRadius = 30
  ballRadius = 30
  rec = Grid.new(0.1, 0.1, 0.8, 6, 6)
  drag = {}
  drag[1] = {}
  drag[2] = {}
  b = Ball.new(1, 2, rec, "east")
  os = {}
  o1 = Obstacle.new(3, {1, 0.5, 0}, 2, 4, false, rec)
  table.insert(os, o1)
  o2 = Obstacle.new(2, {1, 1, 0}, 3, 2, false, rec)
  table.insert(os, o2)
  o3 = Obstacle.new(3, {0.5, 0.5, 0}, 4, 2, false, rec)
  table.insert(os, o3)
  o4 = Obstacle.new(3, {0, 1, 1}, 5, 2, false, rec)
  table.insert(os, o4)
  o5 = Obstacle.new(3, {0, 0.5, 1}, 3, 5, true, rec)
  table.insert(os, o5)
  gl = Goal.new({1, 0, 0}, 6, 2, rec)
  lvl = Level.new(rec, b, os, gl)
end

function lvl28()
  obstacleRadius = 30
  ballRadius = 30
  rec = Grid.new(0.1, 0.1, 0.8, 6, 6)
  drag = {}
  drag[1] = {}
  drag[2] = {}
  b = Ball.new(1, 6, rec, "east")
  os = {}
  o1 = Obstacle.new(3, {1, 0.5, 0}, 1, 1, false, rec)
  table.insert(os, o1)
  o2 = Obstacle.new(2, {1, 1, 0}, 3, 1, true, rec)
  table.insert(os, o2)
  o3 = Obstacle.new(5, {0.5, 0.5, 0}, 6, 1, false, rec)
  table.insert(os, o3)
  o4 = Obstacle.new(5, {0, 1, 1}, 3, 2, false, rec)
  table.insert(os, o4)
  o5 = Obstacle.new(5, {0, 0.5, 1}, 4, 2, false, rec)
  table.insert(os, o5)
  o6 = Obstacle.new(2, {0, 0.75, 0}, 1, 4, false, rec)
  table.insert(os, o6)
  gl = Goal.new({1, 0, 0}, 6, 6, rec)
  lvl = Level.new(rec, b, os, gl)
end

function lvl29()
  obstacleRadius = 27
  ballRadius = 27
  rec = Grid.new(0.1, 0.1, 0.8, 7, 7)
  drag = {}
  drag[1] = {}
  drag[2] = {}
  b = Ball.new(7, 6, rec, "west")
  os = {}
  o1 = Obstacle.new(2, {1, 0.5, 0}, 1, 1, false, rec)
  table.insert(os, o1)
  o2 = Obstacle.new(2, {1, 1, 0}, 3, 1, true, rec)
  table.insert(os, o2)
  --o3 = Obstacle.new(2, {0.5, 0.5, 0}, 5, 1, false, rec)
  --table.insert(os, o3)
  o4 = Obstacle.new(2, {0, 1, 1}, 6, 1, true, rec)
  table.insert(os, o4)
  o5 = Obstacle.new(2, {0, 0.5, 1}, 2, 2, true, rec)
  table.insert(os, o5)
  o6 = Obstacle.new(2, {0, 0.75, 0}, 4, 5, false, rec)
  table.insert(os, o6)
  o7 = Obstacle.new(2, {0.5, 0, 0.5}, 6, 2, true, rec)
  table.insert(os, o7)
  o8 = Obstacle.new(2, {1, 0, 0.5}, 1, 3, false, rec)
  table.insert(os, o8)
  --o9 = Obstacle.new(2, {0.5, 0, 1}, 6, 3, false, rec)
  --table.insert(os, o9)
  o10 = Obstacle.new(2, {0.75, 0, 1}, 2, 4, true, rec)
  table.insert(os, o10)
  o11 = Obstacle.new(2, {1, 0, 0.75}, 4, 4, true, rec)
  table.insert(os, o11)
  o12 = Obstacle.new(2, {0.5, 0, 0.75}, 1, 5, true, rec)
  table.insert(os, o12)
  o13 = Obstacle.new(2, {0.75, 0, 0.5}, 3, 5, false, rec)
  table.insert(os, o13)
  o14 = Obstacle.new(2, {0, 1, 0.75}, 5, 5, true, rec)
  table.insert(os, o14)
  o15 = Obstacle.new(2, {0, 0.75, 1}, 7, 5, false, rec)
  table.insert(os, o15)
  o16 = Obstacle.new(2, {0.75, 1, 0}, 2, 6, false, rec)
  table.insert(os, o16)
  o17 = Obstacle.new(2, {1, 0.75, 0}, 5, 6, false, rec)
  table.insert(os, o17)
  o18 = Obstacle.new(2, {0.5, 1, 0.75}, 3, 7, true, rec)
  table.insert(os, o18)
  o19 = Obstacle.new(2, {0.75, 1, 0.5}, 6, 7, true, rec)
  table.insert(os, o19)
  --[[o20 = Obstacle.new(3, {1, 1, 0.75}, 1, 10, true, rec)
  table.insert(os, o20)
  o21 = Obstacle.new(3, {1, 0.75, 1}, 7, 10, true, rec)
  table.insert(os, o21)]]
  gl = Goal.new({1, 0, 0}, 1, 6, rec)
  lvl = Level.new(rec, b, os, gl)
end

function lvl30()
  obstacleRadius = 30
  ballRadius = 30
  rec = Grid.new(0.1, 0.1, 0.8, 6, 6)
  drag = {}
  drag[1] = {}
  drag[2] = {}
  b = Ball.new(6, 3, rec, "west")
  os = {}
  o1 = Obstacle.new(2, {1, 0.5, 0}, 1, 1, true, rec)
  table.insert(os, o1)
  o2 = Obstacle.new(3, {1, 1, 0}, 3, 1, true, rec)
  table.insert(os, o2)
  o3 = Obstacle.new(2, {0.5, 0.5, 0}, 6, 1, false, rec)
  table.insert(os, o3)
  o4 = Obstacle.new(3, {0, 1, 1}, 1, 4, false, rec)
  table.insert(os, o4)
  o5 = Obstacle.new(3, {0, 0.5, 1}, 2, 4, true, rec)
  table.insert(os, o5)
  o6 = Obstacle.new(2, {0, 0.75, 0}, 1, 2, false, rec)
  table.insert(os, o6)
  o7 = Obstacle.new(3, {0.5, 0, 0.5}, 2, 6, true, rec)
  table.insert(os, o7)
  o8 = Obstacle.new(2, {1, 0, 0.5}, 3, 2, false, rec)
  table.insert(os, o8)
  o9 = Obstacle.new(2, {0.5, 0, 1}, 5, 4, true, rec)
  table.insert(os, o9)
  gl = Goal.new({1, 0, 0}, 1, 3, rec)
  lvl = Level.new(rec, b, os, gl)
end

function lvl31()
  obstacleRadius = 27
  ballRadius = 27
  rec = Grid.new(0.1, 0.1, 0.8, 7, 7)
  drag = {}
  drag[1] = {}
  drag[2] = {}
  b = Ball.new(7, 6, rec, "west")
  os = {}
  o1 = Obstacle.new(2, {237/255, 213/255, 28/255}, 1, 1, false, rec)
  table.insert(os, o1)
  o2 = Obstacle.new(2, {221/255, 196/255, 26/255}, 3, 1, true, rec)
  table.insert(os, o2)
  o3 = Obstacle.new(2, {205/255, 179/255, 25/255}, 5, 1, false, rec)
  table.insert(os, o3)
  o4 = Obstacle.new(2, {190/255, 162/255, 23/255}, 6, 1, true, rec)
  table.insert(os, o4)
  o5 = Obstacle.new(2, {174/255, 145/255, 21/255}, 2, 2, true, rec)
  table.insert(os, o5)
  o6 = Obstacle.new(2, {158/255, 128/255, 20/255}, 4, 5, false, rec)
  table.insert(os, o6)
  o7 = Obstacle.new(2, {142/255, 111/255, 18/255}, 6, 2, true, rec)
  table.insert(os, o7)
  o8 = Obstacle.new(2, {126/255, 94/255, 17/255}, 1, 3, false, rec)
  table.insert(os, o8)
  o9 = Obstacle.new(2, {110/255, 77/255, 15/255}, 6, 3, false, rec)
  table.insert(os, o9)
  o10 = Obstacle.new(2, {95/255, 60/255, 13/255}, 2, 4, true, rec)
  table.insert(os, o10)
  o11 = Obstacle.new(2, {79/255, 43/255, 12/255}, 4, 4, true, rec)
  table.insert(os, o11)
  o12 = Obstacle.new(2, {63/255, 26/255, 10/255}, 1, 5, true, rec)
  table.insert(os, o12)
  gl = Goal.new({1, 0, 0}, 1, 6, rec)
  lvl = Level.new(rec, b, os, gl)
end

function gameComplete()
  love.graphics.print("CONGRATULATIONS")
end
