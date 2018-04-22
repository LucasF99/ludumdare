------Ludum Dare------
----Bra1 e Zimmer----

------Variables------
---system---
local fullScreenState = false

----keys----
local keys = {
    quit = "escape"
}
----game----
local bgColor = {0.8, 0.4, 0.8}

---------------------

function love.load()
    local _, _, flags = love.window.getMode()
    WIDTH, HEIGHT = love.window.getDesktopDimensions(flags.display)
    
    
    ------Setups------
    love.graphics.setBackgroundColor(bgColor)
    love.window.setMode(WIDTH, HEIGHT, {resizable=true, vsync=false, borderless=true, fullscreen = fullScreenState})
end
  
function love.update(dt)
   
end
  
function love.draw()
    
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