Goal = {
    c = nil, --color
    iX = nil, --initial X grid value
    iY = nil, --initial Y grid value
    g = nil --grid
}

function Goal.new(c, iX, iY, g)
    local goal = setmetatable({}, {__index = Goal})
    goal.c = c
    goal.iX = iX
    goal.iY = iY
    goal.g = g
    return goal
end

function Goal:draw()
    --print("width: " .. self.g:getWidth())
    --print("Height: " .. self.g:getHeight())
    love.graphics.setColor(self.c)
    love.graphics.rectangle("fill", self.g.m[self.iX][self.iY][1] - self.g:getWidth()/2, self.g.m[self.iX][self.iY][2] - self.g:getHeight()/2, self.g:getWidth(), self.g:getHeight())
end