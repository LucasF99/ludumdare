local buildings = {}
local data = {
  towers = {},
  images = {},
  twMult = (WIDTH/1920)*4.5,
  fhMult = (WIDTH/1920)*4.5,
  tw = (WIDTH/1920)*4.5*32,-- largura de cada torre
  fh = (WIDTH/1920)*4.5*32,-- altura de cada andar
  keys = {build = "down"}
}

function buildings.initTowers()
    for i = 1, math.ceil(WIDTH/data.tw), 1 do
      data.towers[i] = {}
    end
end

function buildings.build(px, py)
    index = math.ceil((px)/data.tw)
    table.insert(data.towers[index], 1)
end

function buildings.addImage(img)
    table.insert(data.images, img)
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
          HEIGHT-((j)*buildings.getFh()), 0, buildings.getTwMult(), buildings.getFhMult())
      end
    end
end

return buildings