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

function love.load()
  love.window.setMode(600, 600)
  lvl3()
end

function love.update(dt)
  --print("ID: " .. inspect(rec:getID2(love.mouse.getX(), love.mouse.getY())))
end

function love.draw()
  lvl:draw()
  
end

function bootlegUnitTest()
  print("(2, 1):")
  printCoords(lvl.grid:findTail(2, 1)[1], lvl.grid:findTail(2, 1)[2])
  print("(4, 1):")
  printCoords(lvl.grid:findTail(4, 1)[1], lvl.grid:findTail(4, 1)[2])
  print("(2, 2):")
  printCoords(lvl.grid:findTail(2, 2)[1], lvl.grid:findTail(2, 2)[2])
  print("(1, 3):")
  printCoords(lvl.grid:findTail(1, 3)[1], lvl.grid:findTail(1, 3)[2])
  print("(6, 2):")
  printCoords(lvl.grid:findTail(6, 2)[1], lvl.grid:findTail(6, 2)[2])
  print("(3, 4):")
  printCoords(lvl.grid:findTail(3, 4)[1], lvl.grid:findTail(3, 4)[2])
  print("(1, 6):")
  printCoords(lvl.grid:findTail(1, 6)[1], lvl.grid:findTail(1, 6)[2])
  print(" ")
end