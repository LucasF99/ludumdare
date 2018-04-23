------Ludum Dare------
----Bra1 e Zimmer----

------Variables------
---system---
local fullScreenState = false
local _, _, flags = love.window.getMode()
WIDTH, HEIGHT = love.window.getDesktopDimensions(flags.display)
gameState = 0

----keys----
local keys = {
    quit = "escape",
    selectUp = "up",
    selectDown = "down",
    selectOption = "return"
}
----game----
local bgColor = {0.2, 0.6, 0.8}
local selection = 1
FLOOR = HEIGHT - (WIDTH/1920)*32*4

---------------------

function love.load()
    ------Initializations------
    
    ----song----
    music = love.audio.newSource("res/audio/song.mp3", "static") --game song
    music:setVolume(1.4)
    music:setLooping(true)
    
    introSong = love.audio.newSource("res/audio/intro.mp3", "static") --intro song
    introSong:setVolume(1.4)
    introSong:setLooping(true)
    
    ---player---
    player = require "player"
    player.load()
    
    --buildings--
    buildings = require "buildings"
    buildings.load()
    
    -----ui-----
    ui = require "ui"
    ui.load()
    
    ---meteor---
    meteor = require "meteor"
    meteor.load()
    
    ------Setups------
    love.graphics.setBackgroundColor(bgColor)
    if WIDTH >= 1920 and HEIGHT >= 1080 then
      love.window.setMode(WIDTH, HEIGHT, {resizable=false, vsync=false, borderless=true, fullscreen = fullScreenState})
    else
      love.window.setMode(WIDTH, HEIGHT, {resizable=false, vsync=false, fullscreen = fullScreenState})
    end
    love.mouse.setVisible(false)
    
    font = love.graphics.setNewFont("res/fonts/thintel.ttf", WIDTH/40)
    bigFont = love.graphics.setNewFont("res/fonts/thintel.ttf", WIDTH/15)
    mediumFont = love.graphics.setNewFont("res/fonts/thintel.ttf", WIDTH/25)
    
    love.audio.setVolume(0.85)
    introSong:play()
end
  
function love.update(dt)
    if gameState == 1 then
      player.update(dt)
      meteor.update(dt)
    end
end
  
function love.draw()
    if gameState == 1 then
      love.graphics.setColor(0.4, 0.4, 0.4)
      love.graphics.rectangle("fill", 0 , FLOOR, WIDTH, (HEIGHT/1080)*(HEIGHT - FLOOR)*2)
      
      buildings.draw()
      player.draw()
      ui.draw()
      meteor.draw()
      
    elseif gameState == 0 then
      love.graphics.draw(player.getSprite(1), WIDTH/2, HEIGHT*1/3, 0 ,12, 12, player.getSprite(1):getWidth()/2, player.getSprite(1):getHeight()/2)
      
      love.graphics.setFont(bigFont)
      love.graphics.printf("Start Game", 0, (HEIGHT/1080)*500, WIDTH, "center")
      love.graphics.setFont(mediumFont)
      love.graphics.printf("Options", 0, (HEIGHT/1080)*600, WIDTH, "center")
      love.graphics.printf("Credits", 0, (HEIGHT/1080)*670, WIDTH, "center")
      love.graphics.printf("Exit", 0, (HEIGHT/1080)*740, WIDTH, "center")
      
      if selection == 1 then
        love.graphics.setFont(bigFont)
        love.graphics.printf(">", -(WIDTH/1920)*200, (HEIGHT/1080)*500, WIDTH, "center")
      elseif selection == 2 then
        love.graphics.setFont(mediumFont)
        love.graphics.printf(">", -(WIDTH/1920)*100, (HEIGHT/1080)*600, WIDTH, "center")
      elseif selection == 3 then
        love.graphics.setFont(mediumFont)
        love.graphics.printf(">", -(WIDTH/1920)*100, (HEIGHT/1080)*670, WIDTH, "center")
      elseif selection == 4 then
        love.graphics.setFont(mediumFont)
        love.graphics.printf(">", -(WIDTH/1920)*60, (HEIGHT/1080)*740, WIDTH, "center")
      end
    end
    
end

function love.keypressed(key)
   --quits game if key.quit is pressed
    if key == keys.quit then
      love.event.quit()
    end
    
    if gameState == 1 then
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
      
      if key == "t" and player.getHp() > 0 then
        player.setHp(player.getHp()-1)
      end
      
      if key == "g" then
        meteor.init()
      end
      
    elseif gameState == 0 then
      if key == keys.selectUp and selection ~= 1 then
        selection = selection - 1
      elseif key == keys.selectUp then
        selection = 4
      end
      if key == keys.selectDown and selection ~= 4 then
        selection = selection + 1
      elseif key == keys.selectDown then
        selection = 1 
      end
      if key == keys.selectOption then
        if selection == 1 then
          love.audio.stop(introSong)
          music:play()
          gameState = 1
        elseif selection == 2 then
          
        elseif selection == 3 then
          
        elseif selection == 4 then
          
        end
      end
      
    end
    
end
function rgb(r, g, b)
    return r/255, g/255, b/255
end