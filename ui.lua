local ui = {}
local data = {
  images = {},
  people = 100,
  money = 100,
  material = 100
}
function ui.load()
    buildings = require "buildings"
    player = require "player"
    
    data.images[1] = love.graphics.newImage("res/ui/meteor.png")
    data.images[2] = love.graphics.newImage("res/ui/life.png")
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
  if player.getBuildType() == 1 then
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(buildings.getImage(1), (WIDTH/1920)*150 ,(HEIGHT/1080)*40, 0, (WIDTH/1920)*3, (WIDTH/1920)*3)
    love.graphics.setColor(1,1,1, 0.3)
    love.graphics.draw(buildings.getImage(2), (WIDTH/1920)*300 ,(HEIGHT/1080)*40, 0, (WIDTH/1920)*3, (WIDTH/1920)*3)
    love.graphics.draw(buildings.getImage(3), (WIDTH/1920)*450 ,(HEIGHT/1080)*40, 0, (WIDTH/1920)*3, (WIDTH/1920)*3)
  elseif player.getBuildType() == 2 then
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(buildings.getImage(2), (WIDTH/1920)*300 ,(HEIGHT/1080)*40, 0, (WIDTH/1920)*3, (WIDTH/1920)*3)
    love.graphics.setColor(1,1,1, 0.3)
    love.graphics.draw(buildings.getImage(1), (WIDTH/1920)*150 ,(HEIGHT/1080)*40, 0, (WIDTH/1920)*3, (WIDTH/1920)*3)
    love.graphics.draw(buildings.getImage(3), (WIDTH/1920)*450 ,(HEIGHT/1080)*40, 0, (WIDTH/1920)*3, (WIDTH/1920)*3)
  elseif player.getBuildType() == 3 then
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(buildings.getImage(3), (WIDTH/1920)*450 ,(HEIGHT/1080)*40, 0, (WIDTH/1920)*3, (WIDTH/1920)*3)
    love.graphics.setColor(1,1,1, 0.3)
    love.graphics.draw(buildings.getImage(1), (WIDTH/1920)*150 ,(HEIGHT/1080)*40, 0, (WIDTH/1920)*3, (WIDTH/1920)*3)
    love.graphics.draw(buildings.getImage(2), (WIDTH/1920)*300 ,(HEIGHT/1080)*40, 0, (WIDTH/1920)*3, (WIDTH/1920)*3)
  end
  love.graphics.setColor(1,1,1,1)
  
  -----HP/Meteormeter---------
  love.graphics.draw(data.images[1] , (WIDTH/1920)*1350, (HEIGHT/1080)*110, 5.8, (WIDTH/1920)*0.8, (WIDTH/1920)*0.8, data.images[1]:getWidth()/2, data.images[1]:getHeight()/2)
  love.graphics.draw(data.images[2] , (WIDTH/1920)*1335, (HEIGHT/1080)*30, 0, (WIDTH/1920)*4, (WIDTH/1920)*4)
  
  -----Debug-----
  love.graphics.setColor(1,0,0)
  love.graphics.printf(tostring(buildings.checkCollision(player.getPx(),
        player.getPy(), player.getSize(), player.getSize())), 20, HEIGHT-40, WIDTH, "center")
  love.graphics.printf(tostring(buildings.checkFloorCollision(player.getPx(),
        player.getPy(), player.getSize(), player.getSize())), 200, HEIGHT-40, WIDTH, "center")
  
  
end

return ui