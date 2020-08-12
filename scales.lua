

function getHeightFromDecimal(h)
  if h ~= nil then
    if h > 1 then
      return "Height cannot be above 1"
    else
      return h * love.graphics.getHeight()
    end
  end
end

function getWidthFromDecimal(w)
  if w ~= nil then
    if w > 1 then
      return "Width cannot be above 1"
    else
      return w * love.graphics.getWidth()
    end
  end
end

function getDecimalFromHeight(d)
  return d / love.graphics.getHeight()
end

function getDecimalFromWidth(d)
  return d / love.graphics.getWidth()
end
