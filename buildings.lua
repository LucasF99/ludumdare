local buildings = {}

------Variables------
local building = {}
local mult = 4
local size = 0

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
    
    Imgs.resImg = love.graphics.newImage("res/buildings/residential_1.png")
    Imgs.comImg = love.graphics.newImage("res/buildings/commercial_1.png")
    Imgs.indImg = love.graphics.newImage("res/buildings/industrial_1.png")
    
    audio = love.audio.newSource("res/audio/build.mp3", "static")
    
    size = Imgs.resImg:getWidth()*mult
  end

function buildings.update(dt)
    
    
end

function buildings.draw()
    love.graphics.setColor(1,1,1)
    for i = 1, 15, 1 do
      for j = 1, 6, 1 do
        if building[i][j] == "r" then
          love.graphics.draw(Imgs.resImg, (i-1)*size, FLOOR - j*size, 0, mult, mult)
        elseif building[i][j] == "c" then
          love.graphics.draw(Imgs.comImg, (i-1)*size, FLOOR - j*size, 0, mult, mult)
        elseif building[i][j] == "i" then
          love.graphics.draw(Imgs.indImg, (i-1)*size, FLOOR - j*size, 0, mult, mult)
        end
        
      end
    end
    
    --debug
    --love.graphics.print(math.floor(HEIGHT/size - (player.getPy()+ player.getSpriteHeight(1, "ready"))/size), 100, 100)
    
end

------------------

function buildings.init(x, y)
    local temp1 = math.floor((x + size/2)/size) + 1 --translates player position to position in building matrix
    local temp2 = math.floor(HEIGHT/size - y/size)  --translates player position to position in building matrix
    
    if building[temp1][temp2] == "z" and (temp2 == 1 or building[temp1][temp2 - 1] ~= "z") then
      if player.getBuildType() == 1 then
        building[temp1][temp2] = "r"
      elseif player.getBuildType() == 2 then
        building[temp1][temp2] = "c"
      elseif player.getBuildType() == 3 then
        building[temp1][temp2] = "i"
      end
      audio:play()
      
    end
    
end

function floorCollision(x, y)
  
end

------gets/sets------
function buildings.getImgs()
    return Imgs
end

return buildings