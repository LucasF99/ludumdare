local buildings = {}
local data = {
  towers = {},
  images = {},
  audio = {},
  twMult = (WIDTH/1920)*4,
  fhMult = (WIDTH/1920)*4,
  tw = (WIDTH/1920)*4*32,-- largura de cada torre
  fh = (WIDTH/1920)*4*32,-- altura de cada andar
  keys = {build = "down"}
}

function buildings.load()
    for i = 1, math.ceil(WIDTH/data.tw), 1 do
      data.towers[i] = {}
    end
    
    buildings.addImage(love.graphics.newImage("res/buildings/residential_1.png"), 1)
    buildings.addImage(love.graphics.newImage("res/buildings/commercial_1.png"), 2)
    buildings.addImage(love.graphics.newImage("res/buildings/industrial_1.png"), 3)
    
    buildings.setAudio(1 , love.audio.newSource("res/audio/build.mp3", "static")) 
end

function buildings.build(px, py)
    index = math.ceil((px+(player.getSize()/2))/data.tw)
    table.insert(data.towers[index], player.getBuildType())
    data.audio[1]:play()
end

function buildings.addImage(img, i)
    table.insert(data.images, i, img)
end

function buildings.getImage(num)
    return data.images[num]
end

function buildings.getFloorImage(towerIndex, floorIndex)
    return data.images[data.towers[towerIndex][floorIndex]]
end

function buildings.getFh()
    return data.fh
end

function buildings.getTw()
    return data.tw
end

function buildings.getFhMult()
    return data.fhMult
end

function buildings.getTwMult()
    return data.twMult
end

function buildings.getBuildKey()
    return data.keys.build
end

function buildings.setAudio(num, a)
    data.audio[num] = a
end

function buildings.checkCollision(x, y, w, h)
    index_start = math.ceil(x/data.tw)
    index_end = math.ceil((x+w)/data.tw)
    for i = index_start, index_end, 1 do
      max_h = FLOOR - buildings.getFh()*#data.towers[i]
      if y+h > max_h then
        return true
      else
        return false
      end
    end
end

function buildings.checkFloorCollision(x, y, w, h)
    index_start = math.ceil(x/data.tw)
    index_end = math.ceil((x+w)/data.tw)
    for i = index_start, index_end, 1 do
      if buildings.checkCollision(x,y,w,h) then
        love.graphics.setColor(1,0,0)
        inv_y = HEIGHT - y
        -----Debug--------------
        love.graphics.printf(tostring(math.floor(inv_y/data.fh)), 400,400, WIDTH, "center")
        love.graphics.printf(tostring(math.floor((inv_y-h)/data.fh)), 500,400, WIDTH, "center")
        ------------------------
        andar = math.floor(((-(WIDTH/1920)*4*2+inv_y - h)/data.fh)) - 1
        if not (math.floor((inv_y)/data.fh) == math.floor((-(WIDTH/1920)*4*2+inv_y - h)/data.fh)) then
          return true
        else
          return false
        end
      else
        return false
      end
    end
  end

function buildings.draw()
    for i = 1, #data.towers, 1 do
      for j = 1, #data.towers[i], 1 do
        love.graphics.setColor(1,1,1)
        love.graphics.draw(buildings.getFloorImage(i, j), (i-1)*buildings.getTw(),
          HEIGHT-((j+1)*buildings.getFh()), 0, buildings.getTwMult(), buildings.getFhMult())
      end
    end
end

return buildings