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
FLOOR = HEIGHT - 32*4

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
    
    ---buildings---
    buildings = require "buildings"
    
    buildings.load()
    
    ---ui---
    ui = require "ui"
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
    love.graphics.setColor(0.4, 0.4, 0.4)
    love.graphics.rectangle("fill", 0 , FLOOR, WIDTH, (HEIGHT/1080)*(HEIGHT - 900))
    
    buildings.draw()
    
    player.draw()
    
    ui.draw()
    
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
    
end
