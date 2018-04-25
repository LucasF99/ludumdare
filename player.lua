local player = {}

------Variables------
local sprite = {}
local audio = {}
local sizeMult = (WIDTH/1920)*4.5
local keys = {right = "right", left = "left", jump = "space", build = "down", buildRes = "1", buildComm = "2", buildInd = "3"}

local px = WIDTH/2
local py = 0 --is initialized later
local hp = 10
local velocity = (WIDTH/1920)*800
local buildType = 1
local moving = false
local building = false

local jumpInitSpeed = (HEIGHT/1080)*1300
local gravVel = 0
local gravity = (HEIGHT/1080)*5000
local limit = FLOOR

local meteorTime = 0

local time = 0
local frame = 17
local frameTime = 0.035 --for how long in seconds each frame of the sprite is displayed

------Functions------
function player.load()
    --loads player sprite
    love.graphics.setDefaultFilter("nearest")
    for i = 1, 21, 1 do
      sprite[i] = love.graphics.newImage("res/player/player_".. i .. ".png")
    end
    
    --loads player sounds
    audio[1] = love.audio.newSource("res/audio/step.mp3", "static")
    audio[2] = love.audio.newSource("res/audio/jump.mp3", "static")
    
    --setup
    buildings = require "buildings"
   
    --sets player's initial height
    py = FLOOR - player.getSpriteWidth(1)
end

function player.update(dt)
    player.move(dt)
    
    --goes to start screen if player is killed
    if hp <= 0 then
      gameState = 0
    end
    
    time = time + dt
    --resets time after waiting for the time a frame should last based on 'frameTime'
    if time >= frameTime then
      time = 0
      frame = frame + 1
    end
    
    if meteorTime < 600 then
      meteorTime = meteorTime + 25*dt
    else
      meteorTime = 600
    end
    
    --makes stepping sound when moving and not jumping
    if moving ~= false and player.isTouching() then
      audio[1]:play()
    end
    
    if buildings.floorCollision() and buildings.getPlayerYblock() <= 7 then
      limit = HEIGHT - buildings.getPlayerYblock()*buildings.getSpriteSize()
    else
      limit = FLOOR
    end
    
    if not player.isTouching() then
      gravVel = gravVel + gravity*dt
      py = py + gravVel*dt
    end
    
    if py + player.getSpriteWidth(1) > limit then
      gravVel = 0
      py = limit - player.getSpriteWidth(1)
    end
    
end

function player.draw()
    --draws player
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(sprite[player.defineSprite()], px, py, 0, sizeMult, sizeMult)
    
    if DEBUG then
      love.graphics.print("Player touching floor? "..tostring(player.isTouching()), 100, 200)
    end
    
end

-----------------
function player.defineSprite()
    -- loops through building animation frames
    if building and frame >= 24 then
      frame = 0
      building = false
    end
    
    --returns the sprite index to draw based on the direction the player is moving
    if building then
      return frame%4 + 18
    elseif moving == "right" and player.isTouching() then
      return frame%8 + 1
    elseif moving == "left" and player.isTouching() then
      return frame%8 + 9
    elseif moving == "right" then
      return 1
    elseif moving == "left" then
      return 13
    else
      return 17
    end
    
end

function player.move(dt)
    --walks right or left or doesn't walk
    if love.keyboard.isDown(keys.right) and not love.keyboard.isDown(keys.left) and px < WIDTH - player.getSpriteWidth(1) then
      px = px + velocity*dt
      moving = "right"
    elseif love.keyboard.isDown(keys.left) and not love.keyboard.isDown(keys.right)  and px > 0  then
      px = px - velocity*dt
      moving = "left"
    else
      moving = false
    end
    
    --doesn't allow player to walk out of screen
    if px < 0 then
      px = 0
    elseif px > WIDTH - player.getSpriteWidth(1) then
      px = WIDTH - player.getSpriteWidth(1)
    end
    
end

function player.build()
    --when build key is pressed, start build animation
    frame = 18
    building = true
    
end

function player.jumped()
    if player.isTouching() then --buildings.checkFloorCollision(px, py, size, size) then
      py = py-1
      gravVel = -jumpInitSpeed
      audio[2]:play()
    end
    
end

function player.isTouching()
    if py + player.getSpriteWidth(1) == limit then
      return true
    else
      return false
    end
    
  end

------gets/sets------
function player.getSpriteWidth(i, kind)
    kind = kind or "ready"
    if kind == "ready" then
      return sprite[i]:getWidth() * sizeMult
    elseif kind == "pure" then
      return sprite[i]:getWidth()
    end
end

function player.getSpriteHeight(i, kind)
    kind = kind or "ready"
    if kind == "ready" then
      return sprite[i]:getHeight() * sizeMult
    elseif kind == "pure" then
      return sprite[i]:getHeight()
    end
end

function player.getMeteorTime()
    return meteorTime
end

function player.getPx()
    return px
end

function player.getPy()
    return py
end

function player.getHp()
    return hp
end

function player.getKeys()
    return keys
end

function player.getBuildType()
    return buildType
end

function player.getGravVel()
    return gravVel
end

function player.setBuildType(a)
    buildType = a
end

function player.damage(a)
    hp = hp - a
end

--
return player