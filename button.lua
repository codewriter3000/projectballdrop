local class = require("middleclass")
button = class("button")
local buttons = {}
local originalFont = love.graphics.getFont()

function button:initialize(code, text, x, y, rx, ry, textColor, font, color)

	self.code = code
	self.text = text
	self.x = x
	self.y = y
	self.rx = rx or 0
	self.ry = ry or 0
	self.textColor = textColor or {200,200,200}
	self.font = font or love.graphics.getFont()
	self.color = color or {150,150,150}
	self.originalColor = self.color 

	self.id = #buttons + 1
	table.insert(buttons, self)
	return self
end

function button:update()
	local x, y = love.mouse.getX(), love.mouse.getY()
	if x < self.x + self.font:getWidth(self.text) + 20 and x > self.x and y < self.y + self.font:getHeight(self.text) + 20 and y > self.y then 
		if love.mouse.isDown(1) then 
			self.code()
		end
		self.color = {self.color[1] + 20, self.color[2] + 20, self.color[3] + 20}
	else
		self.color = self.originalColor
	end 
end

function button:draw()
	love.graphics.setFont(self.font)

	love.graphics.setColor(self.color)
	love.graphics.rectangle("fill", self.x, self.y, self.font:getWidth(self.text) + 20, self.font:getHeight(self.text) + 20, self.rx, self.ry)

	love.graphics.setColor(self.textColor)
	love.graphics.print(self.text, self.x + 10, self.y + 10)
	
	love.graphics.setColor(255,255,255)
	love.graphics.setFont(originalFont)
end 

function updateButtons()
	for i, v in pairs(buttons) do
		v:update()
	end
end

function drawButtons()
	for i, v in pairs(buttons) do
		v:draw()
	end 
end