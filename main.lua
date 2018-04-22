------Ludum Dare------
----Bra1 e Zimmer----

------Variables------
---system---
local fullScreenState = false
local _, _, flags = love.window.getMode()
WIDTH, HEIGHT = love.window.getDesktopDimensions(flags.display)

----keys----
local keys = {
    quit = "escape"
}
----game----
local bgColor = {0.2, 0.6, 0.8}


---------------------

function love.load()
    ------Initializations------
    ---player---
    player = require "player"
    love.graphics.setDefaultFilter("nearest")
    for i = 1, 17, 1 do
      player.setSprite(love.graphics.newImage("res/player/player_".. i .. ".png"), i)
    end
    ------------
    
    
    ------Setups------
    love.graphics.setBackgroundColor(bgColor)
    love.window.setMode(WIDTH, HEIGHT, {resizable=true, vsync=false, borderless=true, fullscreen = fullScreenState})
    love.mouse.setVisible(false)
end
  
function love.update(dt)
    player.update(dt)
    
end
  
function love.draw()
    player.draw()
    
    love.graphics.setColor(0.4, 0.4, 0.4)
    love.graphics.rectangle("fill", 0 , (HEIGHT/1080)*900, WIDTH, (HEIGHT/1080)*(HEIGHT - 900))
    
end

function love.keypressed(key)
   --quits game if key.quit is pressed
    if key == keys.quit then
      love.event.quit()
    end
    
    if key == player.getJumpKey() then
      player.jumped()
    end
    
end
