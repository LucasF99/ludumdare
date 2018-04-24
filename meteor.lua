local meteor = {}
local data = {
  sprite = {},
  meteor = {
    px = {},
    py = {},
    velocityX = {},
    velocityY = {},
    size = {},
    time = {}
  },
 gravity = 300,
 animSpd = 10,
 meteorRate = 10
}

function meteor.load()
    for i = 1, 2, 1 do
      data.sprite[i] = love.graphics.newImage("res/enemy/meteor_".. i .. ".png")
    end
    math.randomseed(os.time())
end

function meteor.init()
    table.insert(data.meteor.px, math.random(0, WIDTH))
    table.insert(data.meteor.py, math.random(-HEIGHT/2, -HEIGHT/4))
    table.insert(data.meteor.velocityY, math.random(150, 350))
    table.insert(data.meteor.size, math.random(3.7, 4.3))
    table.insert(data.meteor.time, 0)
    
    if data.meteor.px[#data.meteor.px] <= WIDTH/2 then
      table.insert(data.meteor.velocityX, math.random(0, 520))
    else
      table.insert(data.meteor.velocityX, math.random(-520, 0))
    end
end

function meteor.remove(i)
    table.remove(data.meteor.px, i)
    table.remove(data.meteor.py, i)
    table.remove(data.meteor.velocityX, i)
    table.remove(data.meteor.velocityY, i)
    table.remove(data.meteor.time, i)
    table.remove(data.meteor.size, i)
end

function meteor.update(dt)
    if math.random(1,10000)<data.meteorRate then
      meteor.init()
    end
    if #data.meteor.px > 0 and #data.sprite > 0 then
      for i = #data.meteor.px, 1, -1 do
        data.meteor.px[i] = data.meteor.px[i] + data.meteor.velocityX[i]*dt
        data.meteor.velocityY[i] = data.meteor.velocityY[i] + data.gravity*dt
        data.meteor.py[i] = data.meteor.py[i] + data.meteor.velocityY[i]*dt
        data.meteor.time[i] = data.meteor.time[i] + data.animSpd*dt
        if data.meteor.px[i] ~= nil and 
        data.meteor.py[i] ~= nil and 
        data.meteor.size[i] ~= nil and player.checkCollision(data.meteor.px[i], data.meteor.py[i]) then
          player.setHp(player.getHp()-2)
          meteor.remove(i)
          return
        end
        if data.meteor.py[i] > HEIGHT*3/2 then
          meteor.remove(i)
          return
        end
        if buildings.checkCollision(data.meteor.px[i], data.meteor.py[i], (32*data.meteor.size[i]), (32*data.meteor.size[i])) then
          if buildings.getTowers()[buildings.getTowerIndex(data.meteor.px[i]+data.meteor.size[i]*32/2)]~=nil then
            table.remove(buildings.getTowers()[(buildings.getTowerIndex(data.meteor.px[i]+data.meteor.size[i]*32/2))],1)
            --math.floor((HEIGHT-data.meteor.py[i])/buildings.getFh())
            if meteor~=nil then
              meteor.remove(i)
              return
            end
          end
        end
      end
    end
end

function meteor.draw()
    for i = #data.meteor.px, 1, -1 do
      love.graphics.setColor(1,1,1)
      if data.meteor.velocityX[i] <= 0 then 
        love.graphics.draw(data.sprite[math.floor(data.meteor.time[i])%2 + 1], data.meteor.px[i], data.meteor.py[i],
         math.atan(data.meteor.velocityY[i]/data.meteor.velocityX[i]) - math.pi*3/2, data.meteor.size[i], data.meteor.size[i])
      else
        love.graphics.draw(data.sprite[math.floor(data.meteor.time[i])%2 + 1], data.meteor.px[i], data.meteor.py[i],
         math.atan(data.meteor.velocityY[i]/data.meteor.velocityX[i]) -math.pi/2, data.meteor.size[i], data.meteor.size[i])
      end
    end
end

return meteor