local ui = {}
local data = {
  people = 100,
  money = 100,
  material = 100
}

function ui.draw()
  love.graphics.setColor(1,1,1)
  love.graphics.print(tostring(data.people), 16, 16, 0, 2, 2)
end

return ui