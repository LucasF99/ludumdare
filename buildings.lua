local buildings = {}
local data = {
  towers = {},
  images = {},
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
end

function buildings.build(px, py)
    index = math.ceil((px)/data.tw)
    table.insert(data.towers[index], player.getBuildType())
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