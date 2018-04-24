local meteor = {}

------Variables------
local sprite = {}
local gravity = 300
local animSpd = 10
local meteorRate = 12
local meteors = {
    px = {},
    py = {},
    velocityX = {},
    velocityY = {},
    size = {},
    time = {}
  }
  
------Functions------
function meteor.load()
  --load sprite
    for i = 1, 2, 1 do
      sprite[i] = love.graphics.newImage("res/enemy/meteor_".. i .. ".png")
    end
    
end

function meteor.update(dt)
    if math.random(1,10000)<meteorRate*math.log(ui.getPoints())/10 then
      meteor.init()
    end
    
    if #meteors.px > 0 then
      for i = #meteors.px, 1, -1 do
        --updates meteors positions and velocities
        meteors.px[i] = meteors.px[i] + meteors.velocityX[i]*dt
        meteors.velocityY[i] = meteors.velocityY[i] + gravity*dt
        meteors.py[i] = meteors.py[i] + meteors.velocityY[i]*dt
        meteors.time[i] = meteors.time[i] + animSpd*dt
        
        --removes meteor if its offscreen
        if meteors.py[i] > HEIGHT*3/2 then
          meteor.remove(i)
          return
        end
        
        --checks meteor-player collission
        if player.checkCollision(meteors.px[i], meteors.py[i]) then
          player.setHp(player.getHp()-2)
          meteor.remove(i)
        end
        
        if buildings.checkCollision(meteors.px[i], meteors.py[i], (32*meteors.size[i]), (32*meteors.size[i])) then
          if buildings.getTowers(buildings.getTowerIndex(meteors.px[i]+meteors.size[i]*32/2))~=nil then
            --table.remove(buildings.getTowers((buildings.getTowerIndex(meteors.px[i]+meteors.size[i]*32/2))), 1)
            --meteor.remove(i)
          end
        end
        
      end
    end
    
end

function meteor.draw()
    for i = #meteors.px, 1, -1 do
      --[[ debug (draws x and y lines): 
      love.graphics.setColor(1,1,1)
      love.graphics.rectangle("fill", meteors.px[i], 0, 1, HEIGHT)
      love.graphics.rectangle("fill", 0, meteors.py[i], WIDTH, 1)
      ]]
      
      --draws meteor
      love.graphics.setColor(1,1,1)
      love.graphics.draw(sprite[math.floor(meteors.time[i])%2 + 1], meteors.px[i], meteors.py[i],
       math.atan2(meteors.velocityY[i], meteors.velocityX[i]) - math.pi/2, --angle of meteor using x and y speeds
       meteors.size[i], meteors.size[i], --sets size multiplier
       sprite[1]:getWidth()/2, sprite[1]:getHeight()*7/8) --offsets center point to center of meteor
      
    end
    
end

function meteor.init()
    --initializes meteors
    table.insert(meteors.px, math.random(0, WIDTH))
    table.insert(meteors.py, math.random(-HEIGHT/2, -HEIGHT/4))
    table.insert(meteors.velocityY, math.random(150, 350))
    table.insert(meteors.size, math.random(3.7, 4.3))
    table.insert(meteors.time, 0)
    if meteors.px[#meteors.px] <= WIDTH/2 then
      table.insert(meteors.velocityX, math.random(0, 520))
    else
      table.insert(meteors.velocityX, math.random(-520, 0))
    end
    
end

function meteor.remove(i)
    --deletes a meteor
    table.remove(meteors.px, i)
    table.remove(meteors.py, i)
    table.remove(meteors.velocityX, i)
    table.remove(meteors.velocityY, i)
    table.remove(meteors.time, i)
    table.remove(meteors.size, i)
end

return meteor