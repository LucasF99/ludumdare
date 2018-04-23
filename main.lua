------Ludum Dare------
----Bra1 e Zimmer----

------Variables------
---system---
local fullScreenState = false
local _, _, flags = love.window.getMode()
WIDTH, HEIGHT = love.window.getDesktopDimensions(flags.display)
gameState = 1

----keys----
local keys = {
    quit = "escape"
}
----game----
local bgColor = {0.2, 0.6, 0.8}
FLOOR = HEIGHT - (WIDTH/1920)*32*4

---------------------

function love.load()
    ------Initializations------
    
    ----song----
    music = love.audio.newSource("res/audio/song.mp3", "static")
    music:setVolume(1.4)
    music:setLooping(true)
    love.audio.setVolume(0.85)
    music:play()
    
    ---player---
    player = require "player"
    player.load()
    
    --buildings--
    buildings = require "buildings"
    buildings.load()
    
    --startScreen--
    playButton = love.graphics.newImage("res/ui/play_button.png")
    
    -----ui-----
    ui = require "ui"
    ui.load()
    ------------
    
    ------Setups------
    love.graphics.setBackgroundColor(bgColor)
    if WIDTH >= 1920 and HEIGHT >= 1080 then
      love.window.setMode(WIDTH, HEIGHT, {resizable=false, vsync=false, borderless=true, fullscreen = fullScreenState})
    else
      love.window.setMode(WIDTH, HEIGHT, {resizable=false, vsync=false, fullscreen = fullScreenState})
    end
    love.mouse.setVisible(false)
    
    font = love.graphics.setNewFont("res/fonts/thintel.ttf", WIDTH/40)
end
  
function love.update(dt)
    player.update(dt)
    
end
  
function love.draw()
    if gameState == 1 then
      love.graphics.setColor(0.4, 0.4, 0.4)
      love.graphics.rectangle("fill", 0 , FLOOR, WIDTH, (HEIGHT/1080)*(HEIGHT - FLOOR)*2)
      
      buildings.draw()
      
      player.draw()
      
      ui.draw()
      
    elseif gameState == 0 then
      love.graphics.draw(playButton, WIDTH/2, HEIGHT*1/3, 0 ,4, 4, playButton:getWidth()/2, playButton:getHeight()/2)
    end
    
end

function love.keypressed(key)
   --quits game if key.quit is pressed
    if key == keys.quit then
      love.event.quit()
    end
    
    if key == player.getJumpKey() then
      player.jumped()
    end
    
    if key == buildings.getBuildKey() then
      buildings.build(player.getPx(), player.getPy())
    end
    
    if key == player.getBuildResKey() then
      player.setBuildType(1)
    end
    
    if key == player.getBuildCommKey() then
      player.setBuildType(2)
    end
    
    if key == player.getBuildIndKey() then
      player.setBuildType(3)
    end
    
    if key == "k" then
      player.setPy(player.getPy()+10)
    end
    
    if key == "i" then
      player.setPy(player.getPy()-10)
    end
end
function rgb(r, g, b)
    return r/255, g/255, b/255
end