------Ludum Dare------
----Bra1 e Zimmer----

------Variables------
---system---
local fullScreenState = false
local vsyncState = false
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
local pause = false

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
      love.window.setMode(WIDTH, HEIGHT, {resizable=false, vsync=vsyncState, borderless=true, fullscreen = fullScreenState})
    else
      love.window.setMode(WIDTH, HEIGHT, {resizable=false, vsync=vsyncState, fullscreen = fullScreenState})
    end
    love.mouse.setVisible(false)
    
    font = love.graphics.setNewFont("res/fonts/thintel.ttf", WIDTH/40)
    bigFont = love.graphics.setNewFont("res/fonts/thintel.ttf", WIDTH/15)
    mediumFont = love.graphics.setNewFont("res/fonts/thintel.ttf", WIDTH/25)
    hugeFont = love.graphics.setNewFont("res/fonts/thintel.ttf", WIDTH/5)
    
    introImg = love.graphics.newImage("res/player/player_1.png")
    
    love.audio.setVolume(0.85)
    introSong:play()
end
  
function love.update(dt)
    if gameState == 1 and not pause then
      player.update(dt)
      meteor.update(dt)
      buildings.update(dt)
      --ui.updateResources(dt)
    end
end
  
function love.draw()
    ------GAMESTATE 1------
    if gameState == 1 then      
      love.graphics.setColor(0.4, 0.4, 0.4)
      love.graphics.rectangle("fill", 0 , FLOOR, WIDTH, (HEIGHT/1080)*(HEIGHT - FLOOR)*2)
      
      buildings.draw()
      player.draw()
      ui.draw()
      meteor.draw()
    if pause then
      love.graphics.setColor(0, 0, 0, 0.5)
      love.graphics.rectangle("fill", 0 , 0, WIDTH, HEIGHT)
      
      love.graphics.setFont(hugeFont)
      love.graphics.setColor(1,1,1)
      love.graphics.printf("||", 0, (HEIGHT/1080)*400, WIDTH, "center", 0)
      
      love.graphics.setFont(font)
      love.graphics.setColor(0.15,0.15,0.15)
      love.graphics.printf("Press '" .. keys.quit .. "' to resume", 0, (HEIGHT/1080)*700, WIDTH, "center", 0)
      love.graphics.printf("Press '" .. keys.selectOption .. "' to go to menu", 0, (HEIGHT/1080)*750, WIDTH, "center", 0)
    end
    
    ------GAMESTATE 0------
    elseif gameState == 0 then
      love.graphics.setColor(1,1,1)
      love.graphics.draw(introImg, WIDTH/2, HEIGHT*1/3, 0 ,12, 12, 
       player.getSpriteWidth(1, "pure")/2, player.getSpriteHeight(1, "pure")/2)
      
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
    
    ------GAMESTATE 2------
    elseif gameState == 2 then
      love.graphics.setFont(bigFont)
      if not vsyncState then
        love.graphics.printf("VSync: Off", 0, (HEIGHT/1080)*450, WIDTH, "center")
      elseif vsyncState then
        love.graphics.printf("VSync:  On", 0, (HEIGHT/1080)*450, WIDTH, "center")
      end
      
    ------GAMESTATE 3------
    elseif gameState == 3 then
      love.graphics.setFont(mediumFont)
      love.graphics.printf("code by", 0, (HEIGHT/1080)*150, WIDTH, "center")
      love.graphics.printf("art by", 0, (HEIGHT/1080)*450, WIDTH, "center")
      love.graphics.printf("music and sounds by", 0, (HEIGHT/1080)*750, WIDTH, "center")
      
      love.graphics.setFont(bigFont)
      love.graphics.printf("Bra1 and Zimmer", 0, (HEIGHT/1080)*230, WIDTH, "center")
      love.graphics.printf("Bra1", 0, (HEIGHT/1080)*530, WIDTH, "center")
      love.graphics.printf("Zimmer", 0, (HEIGHT/1080)*830, WIDTH, "center")  
     
    end
    -----------------------
end

function love.keypressed(key)
    ------GAMESTATE 1------
    if gameState == 1 then
      if key == keys.quit and not pause then
        love.audio.pause(music)
        pause = true
      elseif key == keys.quit then
        love.audio.play(music)
        pause = false
      end
      
      if key == keys.selectOption and pause then
        love.audio.stop(music)
        introSong:play()
        pause = false
        gameState = 0
      end
      
      if key == player.getKeys().jump then
        player.jumped()
      end
      
      if key == player.getKeys().build then
        player.build()
        buildings.init( (player.getPx() - player.getSpriteWidth(1, "ready")/2), (player.getPy() + player.getSpriteHeight(1, "ready")))
      end
      
      if key == player.getKeys().buildRes then
        player.setBuildType(1)
      end
      
      if key == player.getKeys().buildComm then
        player.setBuildType(2)
      end
      
      if key == player.getKeys().buildInd then
        player.setBuildType(3)
      end
      
      if key == "t" and player.getHp() > 0 then
        player.damage(1)
      end
      
      if key == "g" then
        meteor.init()
      end
      
    ------GAMESTATE 0------  
    elseif gameState == 0 then
      if key == keys.quit then
        love.event.quit()
      end
      
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
          gameState = 2
        elseif selection == 3 then
          gameState = 3
        elseif selection == 4 then
          love.event.quit()
        end
      end
      
    ------GAMESTATE 2------
    elseif gameState == 2 then
      if key == keys.quit then
        gameState = 0
      end
      if key == 'return' then
        if vsyncState then
          vsyncState = false
          if WIDTH >= 1920 and HEIGHT >= 1080 then
            love.window.setMode(WIDTH, HEIGHT, {resizable=false, vsync=vsyncState, borderless=true, fullscreen = fullScreenState})
          else
            love.window.setMode(WIDTH, HEIGHT, {resizable=false, vsync=vsyncState, fullscreen = fullScreenState})
          end
        else
          vsyncState = true
          if WIDTH >= 1920 and HEIGHT >= 1080 then
            love.window.setMode(WIDTH, HEIGHT, {resizable=false, vsync=vsyncState, borderless=true, fullscreen = fullScreenState})
          else
            love.window.setMode(WIDTH, HEIGHT, {resizable=false, vsync=vsyncState, fullscreen = fullScreenState})
          end
        end
      end
     
    ------GAMESTATE 3------
    elseif gameState == 3 then
      if key == keys.quit or key == keys.selectOption then
        gameState = 0
      end
    end
    ----------------------- 
end

function rgb(r, g, b)
    return r/255, g/255, b/255
end
