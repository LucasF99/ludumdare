local player = {}
local data = {
  sprite = {},
  audio = {},
  hp = 10,
  px = 500, py = 812,
  size = (WIDTH/1920)*4.5,
  velocity = (WIDTH/1920)*800,  
  keys = {right = "right", left = "left", jump = "space"},
  time = 17,
  moving = false,
  jumping = false,
  jumpInitSpeed = 25,
  jumpSpeed = 30,
  jumpDecay = 1
}

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
    data.velocity = (WIDTH/1920)*a
end
function player.getVelocity()
    return data.velocity
end
function player.getJumpKey()
    return data.keys.jump
end
function player.setSize(a)
    data.size = a*(WIDTH/1920)
end

function player.getSize()
    return data.size
end
function player.setAudio(num, a)
    data.audio[num] = a
end

function player.jumped()
    if not jumping then
      data.jumpSpeed = data.jumpInitSpeed
      data.audio[2]:play()
    end
    jumping = true
end
--
function player.getFrame()    
    if data.moving == "right" and not jumping then
      return player.getSprite(math.floor(data.time)%((#data.sprite-1)/2) + 1)
    elseif data.moving == "left" and not jumping then
      return player.getSprite(math.floor(data.time)%((#data.sprite-1)/2) + 1 + (#data.sprite-1)/2)
    elseif data.moving == "right" and jumping then
      return player.getSprite(1)
    elseif data.moving == "left" and jumping then
      return player.getSprite(13)
    else
      return player.getSprite(17)
    end    
end
function player.uFrame(dt)
    data.time = data.time+dt*data.velocity*0.05
end

--
function player.move(dt)
    if love.keyboard.isDown(data.keys.right) and not love.keyboard.isDown(data.keys.left) and data.px < WIDTH - (data.sprite[17]:getWidth())*player.getSize() then
      data.px = data.px + data.velocity*dt
      data.moving = "right"
    elseif love.keyboard.isDown(data.keys.left) and not love.keyboard.isDown(data.keys.right)  and data.px > 0  then
      data.px = data.px - data.velocity*dt
      data.moving = "left"
    else
      data.moving = false
    end
    
    if jumping == true then
      
      if data.jumpSpeed > -data.jumpInitSpeed then
        data.py = data.py - data.jumpSpeed*70*dt
        data.jumpSpeed = data.jumpSpeed - data.jumpDecay*95*dt
      else
        data.jumpSpeed = 0
        player.setPy(900 - player.getSprite(17):getHeight()*player.getSize())
        jumping = false
      end
    end
    
end

function player.update(dt)
    player.uFrame(dt)
    player.move(dt)
    
    if data.moving ~= false and not jumping then
      data.audio[1]:play()
    end
    
end

function player.draw()
    love.graphics.setColor(1,1,1)
    love.graphics.draw(player.getFrame(), player.getPx(), player.getPy(), 0, player.getSize(), player.getSize())
end
--
return player