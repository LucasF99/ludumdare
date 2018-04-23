local meteor = {}
local data = {
  sprite = {},
  meteor = {
    px = {},
    py = {},
    velocityX = {},
    velocityY = {}
  },
 gravity = 300
}

function meteor.load()
    for i = 1, 2, 1 do
      data.sprite[i] = love.graphics.newImage("res/enemy/meteor_".. i .. ".png")
    end
    
end

function meteor.init()
    table.insert(data.meteor.px, math.random(0, WIDTH))
    table.insert(data.meteor.py, math.random(-HEIGHT/2, -HEIGHT/4))
    table.insert(data.meteor.velocityY, math.random(150, 350))
    
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
end

function meteor.update(dt)
    if #data.meteor.px > 0 then
      for i = #data.meteor.px, 1, -1 do
        data.meteor.px[i] = data.meteor.px[i] + data.meteor.velocityX[i]*dt
      end
      for i = #data.meteor.velocityY, 1, -1 do
        data.meteor.velocityY[i] = data.meteor.velocityY[i] + data.gravity*dt
      end
      for i = #data.meteor.py, 1, -1 do
        data.meteor.py[i] = data.meteor.py[i] + data.meteor.velocityY[i]*dt
      end
    end
    for i = #data.meteor.px, 1, -1 do
        if data.meteor.py[i] > HEIGHT*3/2 then
          meteor.remove(i)
        end
    end
    
end

function meteor.draw()
    for i = #data.meteor.px, 1, -1 do
      love.graphics.setColor(1,1,1)
      if data.meteor.velocityX[i] <= 0 then 
        love.graphics.draw(data.sprite[1], data.meteor.px[i], data.meteor.py[i], math.atan(data.meteor.velocityY[i]/data.meteor.velocityX[i]) - math.pi*3/2, 4, 4)
      else
        love.graphics.draw(data.sprite[1], data.meteor.px[i], data.meteor.py[i], math.atan(data.meteor.velocityY[i]/data.meteor.velocityX[i]) -math.pi/2, 4, 4)
      end
    end
end

return meteor