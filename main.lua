------Ludum Dare------
----Bra1 e Zimmer----

------Variables------
---system---
local fullScreenState = false
time = 0

----keys----
local keys = {
    quit = "escape"
}
----game----
local bgColor = {0.2, 0.6, 0.8}

---------------------

function love.load()
    local _, _, flags = love.window.getMode()
    WIDTH, HEIGHT = love.window.getDesktopDimensions(flags.display)
    
    
    player = require "player"
    
    love.graphics.setDefaultFilter( "nearest" )
    for i = 1, 17, 1 do
      player.setSprite(love.graphics.newImage("res/player/player_".. i .. ".png"), i)
    end
    
    ------Setups------
    love.graphics.setBackgroundColor(bgColor)
    love.window.setMode(WIDTH, HEIGHT, {resizable=true, vsync=false, borderless=true, fullscreen = fullScreenState})
end
  
function love.update(dt)
   player.uFrame(dt)
   player.move(dt)
end
  
function love.draw()
    love.graphics.draw(player.getFrame(), player.getPx(), player.getPy(), 0, (WIDTH/1920)*5.5, (WIDTH/1920)*5.5)
    
    love.graphics.print("", 100, 100)
end

function love.keypressed(key)
   --quits game if key.quit is pressed
    if key == keys.quit then
      love.event.quit()
    end
    
end

function rgb(r, g, b)
    return r/255, g/255, b/255
end