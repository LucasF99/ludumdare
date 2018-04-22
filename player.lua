local player = {}
<<<<<<< HEAD
local data = {sprite = {}, hp = 10, time = 0, px = 500, py = 800, velocity = 40}
=======
local data = {sprite = {}, hp = 10, time = 0}
>>>>>>> 2f32450dc3913f4ef3b1e0d6cf9c99a49f442ccd

function player.setSprite(a, num)
    data.sprite[num] = a
end

function player.getSprite(num)
    return data.sprite[num]
end
<<<<<<< HEAD
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
=======

--
function player.setHp(a)
    data.hp = a
end

function player.getHp()
    return data.hp
>>>>>>> 2f32450dc3913f4ef3b1e0d6cf9c99a49f442ccd
end
function player.setVelocity(a)
    data.velocity = a
end
function player.getVelocity(a)
    return data.velocity
end
--
function player.getFrame()
    return player.getSprite(math.floor(data.time)%(#data.sprite-1) + 1)
end
function player.uFrame(dt)
    data.time = data.time+dt*data.velocity
end

--
--function player.move(dt, dir)
  
    --data.px
    
--end

return player