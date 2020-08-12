require "scales"
require "obstacle"
require "levels"
require "grid"
require "ball"
require "leveldata"
local inspect = require("inspect")

function love.load()
  love.window.setMode(600, 600)
  lvl1()
  lvl:getRoot(4, 4)
end

function love.update(dt)
  --print("ID: " .. inspect(rec:getID2(love.mouse.getX(), love.mouse.getY())))
end

function love.draw()
  lvl:draw()
end
