local player = {}
local data = {sprite = {}, hp = 10, time = 17, px = 500, py = 800, velocity = 800,  keys = {right = "right", left = "left"}}

function player.setSprite(a, num)
    data.sprite[num] = a
end

function player.getSprite(num)
    return data.sprite[num]
end

function player.setPx(a)
    data.px = a
end

function player.getPx()
    return data.px
end
function player.setPy(a)
    data.py = a
end

function player.getPy()
    return data.py
end
function player.setHp(a)
    data.hp = a
end

function player.getHp()
    return data.hp
end
function player.setVelocity(a)
    data.velocity = a
end
function player.getVelocity(a)
    return data.velocity
end
--
function player.getFrame()
    if love.keyboard.isDown(data.keys.right) and not love.keyboard.isDown(data.keys.left) then
      return player.getSprite(math.floor(data.time)%((#data.sprite-1)/2) + 1)
    elseif love.keyboard.isDown(data.keys.left) and not love.keyboard.isDown(data.keys.right) then
      return player.getSprite(math.floor(data.time)%((#data.sprite-1)/2) + 1 + (#data.sprite-1)/2)
    else
      return player.getSprite(17)
    end
end
function player.uFrame(dt)
    data.time = data.time+dt*data.velocity*0.05
end

--
function player.move(dt)
    if love.keyboard.isDown(data.keys.right) and not love.keyboard.isDown(data.keys.left) then
      data.px = data.px + data.velocity*dt
    elseif love.keyboard.isDown(data.keys.left) and not love.keyboard.isDown(data.keys.right) then
      data.px = data.px - data.velocity*dt
    end
    
end


return player