--uses VSC debugger
if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
  require("lldebugger").start()
end

require "scales"
require "obstacle"
require "levels"
require "grid"
require "ball"
require "leveldata"
local inspect = require("inspect")

--sets the window screen and calls lvl1() to set up level 1
function love.load()
  love.window.setMode(600, 600)
  lvl1()
  getGnomed()
end

function love.update(dt)
  
end

--continuously draws lvl, which is a singleton object which equals the current level that is being played
function love.draw()
  lvl:draw()
end

--a bootleg unit test
function bootlegUnitTest()
  print("(2, 2):")
  printCoords(o1:findTail()[1], o1:findTail()[2])
  print("(6, 2):")
  printCoords(o2:findTail()[1], o2:findTail()[2])
  print("(2, 1):")
  printCoords(o3:findTail()[1], o3:findTail()[2])
  print("(4, 1):")
  printCoords(o4:findTail()[1], o4:findTail()[2])
  print("(3, 4):")
  printCoords(o5:findTail()[1], o5:findTail()[2])
  print("(1, 3):")
  printCoords(o6:findTail()[1], o6:findTail()[2])
  print("(4, 6):")
  printCoords(o7:findTail()[1], o7:findTail()[2])
  print(" ")
  --[[
    (2, 2):
    (2, 3)
    (6, 2):
    (6, 3)
    (2, 1):
    (3, 1)
    (4, 1):
    (6, 1)
    (3, 4):
    (5, 4)
    (1, 3):
    (1, 5)
    (4, 6):
    (6, 6)
  ]]
end