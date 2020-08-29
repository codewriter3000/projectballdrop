--[[
  0019:
  - Fix raw view bug (COMPLETE)
  - Add goals (COMPLETE)

  0020: (ABORTED)
  - Add reset button

  0025:
  - Add reset button (COMPLETE)
  - Add main menu with the following: (COMPLETE)
    - Level Selection
    - Credits
    - Contribute

  0030:
  - Add directional pieces
  - Fix bugs where obstacles can go across balls and the tails can go across each other (optional)
  - Add main menu with the following: (COMPLETE)
    - Level Selection
    - Credits
    - Contribute

  0040:
  - 50 total levels
    - Starter Pack

  0050:
  - 200 total levels
    - Bronze Pack
    - Silver Pack
    - Gold Pack
  - Game enhancements

  0500D:
  - The first demo release
  - More to come
]]
local Timer = require("hump-master.timer")
local suit = require("suit-master")
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
require "hump-master.timer"
local inspect = require("inspect")

--sets the window screen and calls lvl1() to set up level 1
function love.load()
  love.window.setMode(600, 600)
  getGnomed()
end

--continuously draws lvl, which is a singleton object which equals the current level that is being played
menuID = 0
function love.draw()
  if getLevel() ~= 0 then
    lvl:draw()    
  else
    if menuID == 0 then
      mainMenu()
    elseif menuID == 1 then
      credits()
    elseif menuID == 2 then
      contribute()
    end
  end
  suit.draw()
end

function love.update(dt)
  Timer.update(dt)
  pcall(function()
    lvl:update()
  end)
end

function mainMenu()
  suit.Label("WARNING: THIS GAME IS IN ALPHA", {align="center"}, getWidthFromDecimal(0.3), getHeightFromDecimal(0.1))
  suit.Label("THIS GAME MAY NOT WORK RIGHT", {algin="center"}, getWidthFromDecimal(0.3), getHeightFromDecimal(0.15))
  suit.Label("D-Ball Alpha", {align="center"}, getWidthFromDecimal(0.4), getHeightFromDecimal(0.2))
  if suit.Button("Play", getWidthFromDecimal(0.4), getWidthFromDecimal(0.25), 300,30).hit then
    setLevel(1)
  end
  if suit.Button("Credits", getWidthFromDecimal(0.4), getWidthFromDecimal(0.3), 300,30).hit then
    menuID = 1
    credits()
  end
  if suit.Button("Contribute", getWidthFromDecimal(0.4), getWidthFromDecimal(0.35), 300,30).hit then
    menuID = 2
    credits()
  end
  suit.Label("Discord: 3XuPBVt", {align="center"}, getWidthFromDecimal(0.4), getHeightFromDecimal(0.4))
  if suit.Button("A Secret Surprise", getWidthFromDecimal(0.4), getWidthFromDecimal(0.9), 300,30).hit then
    Timer.script(function(wait)
      gnome = love.graphics.newImage("gnomed.png")
      love.graphics.draw(gnome, 0, 0, 0)
      wait(1)
    end)
  end
end

function credits()
  suit.Label("Creator: Alex Micharski (Snapchat: firplius, Discord: maddog#0001)", {align="center"}, getWidthFromDecimal(0.3), getHeightFromDecimal(0.2))
  suit.Label("Made with Love2D Engine", {align="center"}, getWidthFromDecimal(0.4), getHeightFromDecimal(0.25))
  if suit.Button("Back", getWidthFromDecimal(0.4), getWidthFromDecimal(0.3), 300,30).hit then
    menuID = 0
    mainMenu()
  end
end

function contribute()
  suit.Label("PayPal Address: amicharski@outlook.com", {align="center"}, getWidthFromDecimal(0.4), getHeightFromDecimal(0.2))
  suit.Label("Help Wanted: amicharski@outlook.com", {align="center"}, getWidthFromDecimal(0.4), getHeightFromDecimal(0.25))
  if suit.Button("Back", getWidthFromDecimal(0.4), getWidthFromDecimal(0.3), 300,30).hit then
    menuID = 0
    mainMenu()
  end
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

--[[function wait(t)
  Timer.after(t, function()
    print("timer done")
  end)
end]]