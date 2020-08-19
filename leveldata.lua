require "levels"

local level = 1
function getLevel()
  return level
end
function setLevel(l)
  level = l
end

function lvl1()
  rec = Grid.new(0.1, 0.1, 0.8, 6, 6)
  drag = {}
  drag[1] = {}
  drag[2] = {}
  b = Ball.new(4, 3, rec)
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
  o7 = Obstacle.new(3, {0.5, 0, 0.5}, 4, 6, true, rec) --(1, 6)
  table.insert(os, o7)
  lvl = Level.new(rec, b, os)
end

function lvl2()
  rec = Grid.new(0.1, 0.1, 0.8, 6, 6)
  drag = {}
  drag[1] = {}
  drag[2] = {}
  b = Ball.new(4, 3, rec)
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
  lvl = Level.new(rec, b, os)
  setLevel(2)
end

function lvl3()
  rec = Grid.new(0.1, 0.1, 0.8, 6, 6)
  drag = {}
  drag[1] = {}
  drag[2] = {}
  b = Ball.new(4, 3, rec)
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
  lvl = Level.new(rec, b, os)
  setLevel(3)
end

function lvl4()
  rec = Grid.new(0.1, 0.1, 0.8, 6, 6)
  drag = {}
  drag[1] = {}
  drag[2] = {}
  b = Ball.new(4, 3, rec)
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
  lvl = Level.new(rec, b, os)
  setLevel(4)
end

function lvl5()
  rec = Grid.new(0.1, 0.1, 0.8, 6, 6)
  drag = {}
  drag[1] = {}
  drag[2] = {}
  b = Ball.new(4, 3, rec)
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
  lvl = Level.new(rec, b, os)
  setLevel(5)
end

function gameComplete()
  love.graphics.print("CONGRATULATIONS")
end
