local player = {}
local data = {sprite = {}, hp = 10, time = 0}

function player.setSprite(a, num)
    data.sprite[num] = a
end

function player.getSprite(num)
    return data.sprite[num]
end

--
function player.setHp(a)
    data.hp = a
end

function player.getHp()
    return data.hp
end

--
function player.getFrame()
    return player.getSprite(math.floor(data.time)%(#data.sprite-1) + 1)
end
--
function player.uFrame(dt, spd)
    data.time = data.time+dt*spd
end

--
return player