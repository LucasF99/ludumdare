local ui = {}
local data = {
  images = {},
  people = 100,
  money = 100,
  material = 100,
  points = 0,
  peopPS = 2.5,
  monPS = 2.5,
  matPS = 2.5,
  pointsPS = 1
}
local pts = 0

function ui.load()
    buildings = require "buildings"
    player = require "player"
    
    data.images[1] = love.graphics.newImage("res/ui/meteor.png")
    data.images[2] = love.graphics.newImage("res/ui/life.png")
end

function ui.getMoney()
    return data.money
end

function ui.getPeople()
    return data.people
end

function ui.getMaterial()
    return data.material
end

function ui.getPoints()
  return data.points
end

function ui.setMoney(v)
    data.money = v
end

function ui.setPeople(v)
    data.people = v
end

function ui.setMaterial(v)
    data.material = v
end

function ui.updateResources(dt)
    pts = pts + data.pointsPS*dt *0.001*(buildings.getNum()[1]+buildings.getNum()[2]+buildings.getNum()[3])
    
    for i = 1, 15, 1 do
      for j = 1, 6, 1 do
        if buildings.getBuilding()[i][j] == "r" then
          data.people = data.people + data.peopPS*dt * 2/math.log(data.points)
        elseif buildings.getBuilding()[i][j] == "c" then
          data.money = data.money + data.monPS*dt  * 2/math.log(data.points)
        elseif buildings.getBuilding()[i][j] == "i" then
          data.material = data.material + data.matPS*dt * 2/math.log(data.points)
        end
      end
    end
    
    data.people = data.people + data.peopPS*dt
    data.money = data.money + data.monPS*dt
    data.material = data.material + data.matPS*dt
    data.points = data.points + pts
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
  love.graphics.printf(tostring(math.floor(data.people)), -(WIDTH/1920)*170, (HEIGHT/1080)*80, WIDTH, "center")
  love.graphics.printf(tostring(math.floor(data.money)), 0, (HEIGHT/1080)*80, WIDTH, "center")
  love.graphics.printf(tostring(math.floor(data.material)), (WIDTH/1920)*170, (HEIGHT/1080)*80, WIDTH, "center")
  
  love.graphics.printf("Score: "..tostring(math.floor(data.points)), 0, (HEIGHT/1080)*170, WIDTH, "center")

  ------Selection------
  if player.getBuildType() == 1 then
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(buildings.getImgs().resImg, (WIDTH/1920)*150 ,(HEIGHT/1080)*40, 0, (WIDTH/1920)*3, (WIDTH/1920)*3)
    love.graphics.setColor(1,1,1, 0.3)
    love.graphics.draw(buildings.getImgs().comImg, (WIDTH/1920)*300 ,(HEIGHT/1080)*40, 0, (WIDTH/1920)*3, (WIDTH/1920)*3)
    love.graphics.draw(buildings.getImgs().indImg, (WIDTH/1920)*450 ,(HEIGHT/1080)*40, 0, (WIDTH/1920)*3, (WIDTH/1920)*3)
  elseif player.getBuildType() == 2 then
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(buildings.getImgs().comImg, (WIDTH/1920)*300 ,(HEIGHT/1080)*40, 0, (WIDTH/1920)*3, (WIDTH/1920)*3)
    love.graphics.setColor(1,1,1, 0.3)
    love.graphics.draw(buildings.getImgs().resImg, (WIDTH/1920)*150 ,(HEIGHT/1080)*40, 0, (WIDTH/1920)*3, (WIDTH/1920)*3)
    love.graphics.draw(buildings.getImgs().indImg, (WIDTH/1920)*450 ,(HEIGHT/1080)*40, 0, (WIDTH/1920)*3, (WIDTH/1920)*3)
  elseif player.getBuildType() == 3 then
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(buildings.getImgs().indImg, (WIDTH/1920)*450 ,(HEIGHT/1080)*40, 0, (WIDTH/1920)*3, (WIDTH/1920)*3)
    love.graphics.setColor(1,1,1, 0.3)
    love.graphics.draw(buildings.getImgs().resImg, (WIDTH/1920)*150 ,(HEIGHT/1080)*40, 0, (WIDTH/1920)*3, (WIDTH/1920)*3)
    love.graphics.draw(buildings.getImgs().comImg, (WIDTH/1920)*300 ,(HEIGHT/1080)*40, 0, (WIDTH/1920)*3, (WIDTH/1920)*3)
  end
  love.graphics.setColor(1,1,1,1)
  
  -----HP/Meteormeter---------
  love.graphics.draw(data.images[1], (WIDTH/1920)*1350, (HEIGHT/1080)*110, 5.8, (WIDTH/1920)*0.8, (WIDTH/1920)*0.8, data.images[1]:getWidth()/2, data.images[1]:getHeight()/2)
  love.graphics.draw(data.images[2], (WIDTH/1920)*1335, (HEIGHT/1080)*30, 0, (WIDTH/1920)*4, (WIDTH/1920)*4)
  
  -----Hp-----
  love.graphics.setColor(0.2,0.2,0.2)
  love.graphics.rectangle("line", (WIDTH/1920)*1390, (HEIGHT/1080)*27, (WIDTH/1920)*400, (HEIGHT/1080)*40)
  love.graphics.setColor(0,1,0)
  love.graphics.rectangle("fill", (WIDTH/1920)*1397, (HEIGHT/1080)*33, (WIDTH/1920)*38.6 * player.getHp(), (HEIGHT/1080)*28)
  
  ---Meteor---
  love.graphics.setColor(rgb(133, 142, 145))
  love.graphics.rectangle("fill", (WIDTH/1920)*1390, (HEIGHT/1080)*110, (WIDTH/1920)*400, (HEIGHT/1080)*7)  
  if player.getMeteorTime() < 400 then
    love.graphics.setColor(1,1,0)
    love.graphics.rectangle("fill", (WIDTH/1920)*1390, (HEIGHT/1080)*110, (WIDTH/1920)*player.getMeteorTime(), (HEIGHT/1080)*7)
  else
    love.graphics.setColor(1,1 - (player.getMeteorTime() - 400)/200,0)
    love.graphics.rectangle("fill", (WIDTH/1920)*1390, (HEIGHT/1080)*110, (WIDTH/1920)*400, (HEIGHT/1080)*7)
  end  
  
  -----Debug-----
  love.graphics.setColor(1,0,0)
  
  
end

return ui