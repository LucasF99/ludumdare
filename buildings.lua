local buildings = {}

------Variables------
local building = {}
local mult = 4
local size = 0

local playerXblock = 1
local playerYblock = 1

local Imgs = {resImg, comImg, indImg}
local audio

------Functions------
function buildings.load()
    --[[Inicializes matrix that represents the buildings.
    'z' means empty, 'r' is for residential, 'c' for commercial and 'i', industrial]]
    for i = 1, 15, 1 do
      building[i] = {"z", "z", "z", "z", "z", "z"}
    end
    
    player = require "player"
    meteor = require "meteor"
    
    Imgs.resImg = love.graphics.newImage("res/buildings/residential_1.png")
    Imgs.comImg = love.graphics.newImage("res/buildings/commercial_1.png")
    Imgs.indImg = love.graphics.newImage("res/buildings/industrial_1.png")
    
    audio = love.audio.newSource("res/audio/build.mp3", "static")
    
    size = Imgs.resImg:getWidth()*mult
  end

function buildings.update(dt)
    playerXblock = math.floor(((player.getPx() - player.getSpriteWidth(1, "ready")/2) + size/2)/size) + 1 --translates player's x position to position in building matrix
    playerYblock = math.floor(HEIGHT/size - (player.getPy() + player.getSpriteHeight(1, "ready"))/size)   --translates player's y position to position in building matrix
    
end

function buildings.draw()
    love.graphics.setColor(1,1,1)
    for i = 1, 15, 1 do
      for j = 1, 6, 1 do
        
        if DEBUG then --DEBUG: draws matrix
          love.graphics.setColor(rgb(146, 244, 66))
          love.graphics.rectangle("fill", (i-1)*size, 0, 1, HEIGHT)
          love.graphics.rectangle("fill", 0, FLOOR -j*size, WIDTH, 1)
          love.graphics.setColor(1,1,1)
        end        
        
        if building[i][j] == "r" then
          love.graphics.draw(Imgs.resImg, (i-1)*size, FLOOR - j*size, 0, mult, mult)
        elseif building[i][j] == "c" then
          love.graphics.draw(Imgs.comImg, (i-1)*size, FLOOR - j*size, 0, mult, mult)
        elseif building[i][j] == "i" then
          love.graphics.draw(Imgs.indImg, (i-1)*size, FLOOR - j*size, 0, mult, mult)
        end
        
      end
    end
    
    if DEBUG then --DEBUG: players current block
      love.graphics.print(playerXblock,  100, 250)
      love.graphics.print(playerYblock, 150, 250)
    end
    
end

------------------

function buildings.init(x, y)    
    if building[playerXblock][playerYblock] == "z" and playerYblock <= 6 and (playerYblock == 1 or building[playerXblock][playerYblock - 1] ~= "z") then
      if player.getBuildType() == 1 then
        building[playerXblock][playerYblock] = "r"
      elseif player.getBuildType() == 2 then
        building[playerXblock][playerYblock] = "c"
      elseif player.getBuildType() == 3 then
        building[playerXblock][playerYblock] = "i"
      end
      audio:play()
      
    end
    
end

--[[function buildings.remove(i, j)
    building[i][j] = "z"
    while true do
      if building[i][j + 1] ~= "z" then
        building[i][j] = building[i][j + 1]
        building[i][j + 1] = "z"
      else
        break
      end
      j = j + 1
    end
    
end]]

function buildings.floorCollision()    
    if (building[playerXblock][playerYblock - 1] ~= "z" and playerYblock > 1) or
       (playerYblock > 1 and playerXblock < 15 and building[playerXblock + 1][playerYblock - 1] ~= "z" and player.getPx() > playerXblock*buildings.getSpriteSize() - player.getSpriteWidth(1)*0.6) or
       (playerYblock > 1 and playerXblock > 1 and building[playerXblock - 1][playerYblock - 1] ~= "z" and player.getPx() < (playerXblock - 1)*buildings.getSpriteSize()- player.getSpriteWidth(1)*0.3)
    then
      return true
    else
      return false
    end
end

function buildings.meteorCollision(x, y, i)
    if x <= 15 and x >= 1 and y >= 1 and y <= 6 then
      if building[x][y] ~= "z" then
        --buildings.remove(meteor.getXblock(i), meteor.getYblock(i))
        meteor.remove(i)
      end
    end
    
end
------gets/sets------
function buildings.getSpriteSize(kind)
    kind = kind or "ready"
    if kind == "ready" then
      return Imgs.resImg:getWidth() * mult
    elseif kind == "pure" then
      return Imgs.resImg:getWidth()
    end
end

function buildings.getImgs()
    return Imgs
end

function buildings.getPlayerXblock()
    return playerXblock
  end
  
  function buildings.getPlayerYblock()
    return playerYblock
  end
--
return buildings