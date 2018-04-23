local ui = {}
local data = {
  people = 100,
  money = 100,
  material = 100
}
function ui.load()
    buildings = require "buildings" 
end

function ui.draw()
  ------Resources------
  love.graphics.setColor(rgb(133, 142, 145))
  love.graphics.rectangle("fill", WIDTH/2 - (WIDTH/1920)*500/2, (HEIGHT/1080)*40, (WIDTH/1920)*500,  (HEIGHT/1080)*70)
  love.graphics.setColor(0.2,0.2,0.2)
  love.graphics.rectangle("line", WIDTH/2 - (WIDTH/1920)*500/2, (HEIGHT/1080)*40, (WIDTH/1920)*500,  (HEIGHT/1080)*70)
  love.graphics.line(WIDTH/2 - (WIDTH/1920)*80, (HEIGHT/1080)*40, WIDTH/2 - (WIDTH/1920)*80, (HEIGHT/1080)*110)
  love.graphics.line(WIDTH/2 + (WIDTH/1920)*80, (HEIGHT/1080)*40, WIDTH/2 + (WIDTH/1920)*80, (HEIGHT/1080)*110)
  
  love.graphics.setFont(font)
  love.graphics.setColor(0,1,0)
  love.graphics.printf("People:", -(WIDTH/1920)*170, (HEIGHT/1080)*46, WIDTH, "center")
  love.graphics.setColor(0,0,1)
  love.graphics.printf("Money:", 0, (HEIGHT/1080)*46, WIDTH, "center")
  love.graphics.setColor(1,1,0)
  love.graphics.printf("Material:", (WIDTH/1920)*170, (HEIGHT/1080)*46, WIDTH, "center")
  
  love.graphics.setColor(1,1,1)
  love.graphics.printf(tostring(data.people), -(WIDTH/1920)*170, (HEIGHT/1080)*80, WIDTH, "center")
  love.graphics.printf(tostring(data.money), 0, (HEIGHT/1080)*80, WIDTH, "center")
  love.graphics.printf(tostring(data.material), (WIDTH/1920)*170, (HEIGHT/1080)*80, WIDTH, "center")
  
  ------Selection------
  love.graphics.draw(buildings.getImage(1), 100 ,40, 0, 3.8, 3.8)
  
  
  ---------------------
end

return ui