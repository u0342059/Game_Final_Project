
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
storyboard.removeAll()

function scene:createScene( event )
  local group = self.view
  --set game variables
  local inEvent = 0
  local eventRun = 0
  --set background
  local backbackground = display.newImage("images/background.png")
  backbackground.x = display.contentCenterX
  backbackground.y = display.contentCenterY
  local backgroundfar = display.newImage("images/bgfar1.png")
  backgroundfar.x = 480
  backgroundfar.y = 235
  local backgroundnear1 = display.newImage("images/bgnear2.png")
  backgroundnear1.x = 240
  backgroundnear1.y = 145
  local backgroundnear2 = display.newImage("images/bgnear2.png")
  backgroundnear2.x = 760
  backgroundnear2.y = 145
  
  --set alert view
  local gameOver = display.newImage("images/gameOver.png")
  gameOver.name = "gameOver"
  gameOver.x = 0
  gameOver.y = 500
  local yesButton = display.newImage("images/yesButton.png")
  yesButton.x = 100
  yesButton.y = 600
  local noButton = display.newImage("images/noButton.png")
  noButton.x = 100
  noButton.y = 600

  --variable to hold our game's score
  local score = 0
  local scoreText = display.newText("score: " .. score, 0, 0,
                                   native.systemFont, 50)
  scoreText.anchor = 0
  scoreText.x = 0
  scoreText.y = 30
  scoreText:setFillColor(0,0,0)

  -- Group
  local blocks = display.newGroup()
  local player = display.newGroup()
  local screen = display.newGroup()
  local enemys = display.newGroup()
  local spikes = display.newGroup()
  local blasts = display.newGroup()
  local bossSpits = display.newGroup()

  --create enemy
  for a = 1, 3, 1 do
    enemy = display.newImage("images/bug.png")
    enemy.name = ("enemy" .. a)
    enemy.id = a
    enemy.x = 800
    enemy.y = 600
    enemy.speed = 0
    enemy.isAlive = false
    enemys:insert(enemy)
  end

--create spikes
for a = 1, 3, 1 do
    spike = display.newImage("images/spikeBlock.png")
    spike.name = ("spike" .. a)
    spike.id = a
    spike.x = 900
    spike.y = 500
    spike.isAlive = false
    spikes:insert(spike)
end

--create blasts
for a=1, 5, 1 do
    blast = display.newImage("images/ring.png")
    blast.name = ("blast" .. a)
    blast.id = a
    blast.x = 800
    blast.y = 500
    blast.isAlive = false
    blasts:insert(blast)
end

--create ground
  local groundMin = 420
  local groundMax = 260
  local groundLevel = groundMin
 
  for a = 1, 8, 1 do
    isDone = false
    numGen = math.random(2)
    local newBlock  
   if(numGen == 1 and isDone == false) then
     newBlock = display.newImage("images/ground1.png")
     isDone = true
    end
   if(numGen == 2 and isDone == false) then
      newBlock = display.newImage("images/ground2.png")
      isDone = true
    end
    newBlock.name = ("block" .. a)
    newBlock.id = a
    newBlock.x = (a * 79) - 79
    newBlock.y = groundLevel
    blocks:insert(newBlock)
  end

-- create boss
  local boss = display.newImage("images/egg.png", 150, 150)
  boss.x = 300
  boss.y = 550
  boss.isAlive = false
  boss.health = 10
  boss.goingDown = true
  boss.canShoot = false
  boss.spitCycle = 0

-- create boss spit
  for a=1, 3, 1 do
    bossSpit = display.newImage("images/bullet.png")    
    bossSpit.x = 400
    bossSpit.y = 550
    bossSpit.isAlive = false
    bossSpit.speed = 3
    bossSpits:insert(bossSpit)
  end

--create monster sprite sheet
  local speed = 5
  local sheetInfo = require("sonicSpriteSheet")
  local myImageSheet =
        graphics.newImageSheet("images/sonicSpriteSheet.png", 
                                           sheetInfo:getSheet())
  local sequenceDate = {{name = "running", start = 1, count = 6, time = 300}, 
                       {name = "jumping", start = 7, count = 1, time = 100}}

  local monster = display.newSprite(myImageSheet, sequenceDate)
  monster:play()
  monster.x = 60
  monster.y = 220
  monster.gravity = -6
  monster.accel = 0
  monster.isAlive = true

  local collisionRect = display.newRect(monster.x + 36, monster.y, 1, 70)
  collisionRect.strokeWidth = 1
  collisionRect:setFillColor(140, 140, 140)
  collisionRect:setStrokeColor(180, 180, 180)
  collisionRect.alpha = 0

-- Group
  screen:insert(backbackground)
  screen:insert(backgroundfar)
  screen:insert(backgroundnear1)
  screen:insert(backgroundnear2)
  screen:insert(blocks)
  screen:insert(spikes)
  screen:insert(blasts)
  screen:insert(enemys)
  screen:insert(monster)
  screen:insert(boss)
  screen:insert(bossSpits)
  screen:insert(collisionRect)
  screen:insert(scoreText)
  screen:insert(gameOver)
  screen:insert(yesButton)
  screen:insert(noButton)

-- update
local function update( event )
  updateBackgrounds()
  updateSpeed()
  updateMonster()
  updateBlocks()
  updateBlasts()
  updateSpikes()
  updateenemys()
  updateBossSpit()
  if(boss.isAlive == true) then   
    updateBoss()    
  end
  checkCollisions()
end

-- Boss update 
function updateBoss()
  if(boss.health > 0) then
    if(boss.y > 210) then
      boss.goingDown = false
    end
    if(boss.y < 100) then
      boss.goingDown = true
    end
    if(boss.goingDown) then
      boss.y = boss.y + 2
    else
      boss.y = boss.y - 2
    end
  else
    boss.alpha = boss.alpha - .01
  end
  if(boss.alpha <= 0) then
    boss.isAlive = false
    boss.x = 300
    boss.y = 550
    boss.alpha = 1
    boss.health = 10
    inEvent = 0
    boss.spitCycle = 0
  end 
end

-- BossSpit update
function updateBossSpit()
  for a = 1, bossSpits.numChildren, 1 do
    if(bossSpits[a].isAlive) then
      (bossSpits[a]):translate(speed * -1, 0)
      if(bossSpits[a].y > monster.y) then
        bossSpits[a].y = bossSpits[a].y - 1
      end
      if(bossSpits[a].y < monster.y) then
        bossSpits[a].y = bossSpits[a].y + 1
      end
      if(bossSpits[a].x < -80) then
        bossSpits[a].x = 400
        bossSpits[a].y = 550
        bossSpits[a].speed = 0
        bossSpits[a].isAlive = false;
      end
    end
  end
end

-- Collisions check
function checkCollisions()
  --Ground
  wasOnGround = onGround
  for a = 1, blocks.numChildren, 1 do
    if(collisionRect.y - 10> blocks[a].y - 170 and
            blocks[a].x - 40 < collisionRect.x and
            blocks[a].x + 40 > collisionRect.x) then
      --stop the monster
      speed = 0
      monster.isAlive = false
      --this simply pauses the current animation
      monster:pause()
      gameOver.x = display.contentWidth*.5
      gameOver.y = display.contentHeight/2
      yesButton.x = display.contentWidth*.5 - 80
      yesButton.y = display.contentHeight/2 + 40
      noButton.x = display.contentWidth*.5 + 80
      noButton.y = display.contentHeight/2 + 40
    end
  end
  
  --spike wall
  for a = 1, spikes.numChildren, 1 do
    if(spikes[a].isAlive == true) then
      if(collisionRect.y - 10> spikes[a].y - 170 and
              spikes[a].x - 40 < collisionRect.x and
              spikes[a].x + 40 > collisionRect.x) then
        --stop the monster
        speed = 0
        monster.isAlive = false
        --this simply pauses the current animation
        monster:pause()
        gameOver.x = display.contentWidth*.5
        gameOver.y = display.contentHeight/2
        yesButton.x = display.contentWidth*.5 - 80
        yesButton.y = display.contentHeight/2 + 40
        noButton.x = display.contentWidth*.5 + 80
        noButton.y = display.contentHeight/2 + 40
      end
    end
  end
  
  -- enemy
  for a = 1, enemys.numChildren, 1 do
    if(enemys[a].isAlive == true) then
      if(((  ((monster.y-enemys[a].y))<70) and
        ((monster.y - enemys[a].y) > -70)) and
        (enemys[a].x - 40 < collisionRect.x and
        enemys[a].x + 40 > collisionRect.x)) then
        --stop the monster
        speed = 0
        monster.isAlive = false
        --this simply pauses the current animation
        monster:pause()
        gameOver.x = display.contentWidth*.5
        gameOver.y = display.contentHeight/2
        yesButton.x = display.contentWidth*.5 - 80
        yesButton.y = display.contentHeight/2 + 40
        noButton.x = display.contentWidth*.5 + 80
        noButton.y = display.contentHeight/2 + 40
      end
    end
  end
  
  --boss spit
  for a = 1, bossSpits.numChildren, 1 do
    if(bossSpits[a].isAlive == true) then
     if((monster.y-bossSpits[a].y <45) and
        (monster.y-bossSpits[a].y >-45) and 
        (monster.x-bossSpits[a].x >-45)) then 
        --stop the monster
        speed = 0
        monster.isAlive = false
        --this simply pauses the current animation
        monster:pause()
        gameOver.x = display.contentWidth*.5
        gameOver.y = display.contentHeight/2
        yesButton.x = display.contentWidth*.5 - 80
        yesButton.y = display.contentHeight/2 + 40
        noButton.x = display.contentWidth*.5 + 80
        noButton.y = display.contentHeight/2 + 40
      end
    end
  end

-- onGround
  for a = 1, blocks.numChildren, 1 do
    if(monster.y >= blocks[a].y - 170 and
      blocks[a].x < monster.x + 60 and
      blocks[a].x > monster.x - 60) then
      monster.y = blocks[a].y - 171
      onGround = true
      break
    else
      onGround = false
    end
  end
end

-- enemys update
function updateenemys()
  for a = 1, enemys.numChildren, 1 do
    if(enemys[a].isAlive == true) then
      (enemys[a]):translate(speed * -1, 0)
      if(enemys[a].y > monster.y) then
        enemys[a].y = enemys[a].y - 1
      end
      if(enemys[a].y < monster.y) then
        enemys[a].y = enemys[a].y + 1
      end
      if(enemys[a].x < -80) then
        enemys[a].x = 800
        enemys[a].y = 600
        enemys[a].speed = 0
        enemys[a].isAlive = false;
      end
    end
  end
end

--Spikes update
function updateSpikes()
    for a = 1, spikes.numChildren, 1 do
        if(spikes[a].isAlive == true) then
            (spikes[a]):translate(speed * -1, 0)
            if(spikes[a].x < -80) then
                spikes[a].x = 900
                spikes[a].y = 500
                spikes[a].isAlive = false
            end
        end
    end
end

-- Blasts update
function updateBlasts()
    for a = 1, blasts.numChildren, 1 do
        if(blasts[a].isAlive == true) then
            (blasts[a]):translate(5, 0)
            if(blasts[a].x > 550) then
                    blasts[a].x = 800
                blasts[a].y = 500
                blasts[a].isAlive = false
            end
        end
        --check for collisions between the blasts and the spikes
        for b = 1, spikes.numChildren, 1 do
            if(spikes[b].isAlive == true) then
                if(blasts[a].y - 25 > spikes[b].y - 120 and
                   blasts[a].y + 25 < spikes[b].y + 120 and
                    spikes[b].x - 40 < blasts[a].x + 25 and
                    spikes[b].x + 40 > blasts[a].x - 25) then
                   blasts[a].x = 800
                   blasts[a].y = 500
                   blasts[a].isAlive = false
                   spikes[b].x = 900
                   spikes[b].y = 500
                   spikes[b].isAlive = false
                end
            end
        end
        
        --check for collisions between the blasts and the enemys
       for b = 1, enemys.numChildren, 1 do
            if(enemys[b].isAlive == true) then
                if(blasts[a].y - 25 > enemys[b].y - 120 and
                   blasts[a].y + 25 < enemys[b].y + 120 and
                    enemys[b].x - 40 < blasts[a].x + 25 and
                    enemys[b].x + 40 > blasts[a].x - 25) then
                    blasts[a].x = 800
                    blasts[a].y = 500
                    blasts[a].isAlive = false
                    enemys[b].x = 800
                    enemys[b].y = 600
                    enemys[b].isAlive = false
                    enemys[b].speed = 0
                end
            end
        end   
        --check for collisions with the boss
        if(boss.isAlive == true) then
             if(blasts[a].y - 25 > boss.y - 120 and
                blasts[a].y + 25 < boss.y + 120 and
                 boss.x - 40 < blasts[a].x + 25 and
                 boss.x + 40 > blasts[a].x - 25) then
                blasts[a].x = 800
                blasts[a].y = 500
                blasts[a].isAlive = false
                boss.health = boss.health - 1
             end
         end
    
        --check for collisions between the blasts and the bossSpit
        for b = 1, bossSpits.numChildren, 1 do
             if(bossSpits[b].isAlive == true) then
                 if(blasts[a].y - 20 > bossSpits[b].y - 120 and
                    blasts[a].y + 20 < bossSpits[b].y + 120 and
                     bossSpits[b].x - 25 < blasts[a].x + 20 and
                     bossSpits[b].x + 25 > blasts[a].x - 20) then
                     blasts[a].x = 800
                     blasts[a].y = 500
                     blasts[a].isAlive = false
                     bossSpits[b].x = 400
                     bossSpits[b].y = 550
                     bossSpits[b].isAlive = false
                     bossSpits[b].speed = 0
                 end
             end
        end 
    end
end

-- Monster update
function updateMonster()
     if(monster.isAlive == true) then
          if(onGround) then
               if(wasOnGround) then
               else
                    monster:setSequence("running")
                    monster:play()
               end
          else
               monster:setSequence("jumping")
               monster:play()
          end
          if(monster.accel > 0) then
               monster.accel = monster.accel - 1
          end
          monster.y = monster.y - monster.accel
          monster.y = monster.y - monster.gravity
     else
          monster:rotate(5)
     end
     collisionRect.y = monster.y
end

--Speed update
function updateSpeed()
  if(monster.isAlive) then
    speed = speed + .0005
  end
end

-- Block update
function updateBlocks()
     for a = 1, blocks.numChildren, 1 do
        if(a > 1) then
           newX = (blocks[a - 1]).x + 79
        else
           newX = (blocks[8]).x + 79 - speed
        end
        if((blocks[a]).x < -40) then
           if (boss.isAlive == false) then
              score = score + 1
              scoreText.text = "score: " .. score
              scoreText.anchorX = 0
              scoreText.x = 0
              scoreText.y = 30
           else
              boss.spitCycle = boss.spitCycle + 1
              if(boss.y > 100 and boss.y < 300 and boss.spitCycle%3 == 0) then
                for a=1, bossSpits.numChildren, 1 do
                  if(bossSpits[a].isAlive == false) then
                    bossSpits[a].isAlive = true
                    bossSpits[a].x = boss.x - 35
                    bossSpits[a].y = boss.y + 55
                    bossSpits[a].speed = math.random(5,10)
                  break
                  end
                end
             end
          end
        
       if(inEvent == 11) then
          (blocks[a]).x, (blocks[a]).y = newX, 600
       else
          (blocks[a]).x, (blocks[a]).y = newX, groundLevel
       end
       if(inEvent == 12) then
         for a=1, spikes.numChildren, 1 do
          if(spikes[a].isAlive == true) then
          --do nothing
          else
          spikes[a].isAlive = true
          spikes[a].y = groundLevel - 200
          spikes[a].x = newX
          break
          end
         end
       end
       if(inEvent == 15) then
        groundLevel = groundMin
       end
       checkEvent()
       else
         (blocks[a]):translate(speed * -1, 0)
       end
    end
end

--Backgrounds update
function updateBackgrounds()
  --far background movement
  backgroundfar.x = backgroundfar.x - (speed/55)
  
  --near background movement
  backgroundnear1.x = backgroundnear1.x - (speed/5)
  if(backgroundnear1.x < -239) then
    backgroundnear1.x = 760
  end
  
  backgroundnear2.x = backgroundnear2.x - (speed/5)
  if(backgroundnear2.x < -239) then
    backgroundnear2.x = 760
  end
end

-- Restart game
function restartGame()
     --move menu
     gameOver.x = 0
     gameOver.y = 500
     --reset the score
     score = 0
     --reset the game speed
     speed = 4
     --reset the monster
     monster.isAlive = true
     monster.x = 60
     monster.y = 200
     monster:setSequence("running")
     monster:play()
     monster.rotation = 0
     --reset the groundLevel
     groundLevel = groundMin
     for a = 1, blocks.numChildren, 1 do
          blocks[a].x = (a * 79) - 79
          blocks[a].y = groundLevel
     end
     
     --reset the enemys
     for a = 1, enemys.numChildren, 1 do
          enemys[a].x = 800
          enemys[a].y = 600
     end
     --reset the spikes
     for a = 1, spikes.numChildren, 1 do
          spikes[a].x = 900
          spikes[a].y = 500
     end
     --reset the blasts
     for a = 1, blasts.numChildren, 1 do
          blasts[a].x = 800
          blasts[a].y = 500
     end
     --reset the backgrounds
     backgroundfar.x = 240
     backgroundfar.y = 235
     backgroundnear1.x = 240
     backgroundnear1.y = 160
     backgroundnear2.x = 760
     backgroundnear2.y = 160
     
     --reset the boss
     boss.isAlive = false
     boss.x = 300
     boss.y = 550
     --reset the boss's spit
     for a = 1, bossSpits.numChildren, 1 do
          bossSpits[a].x = 400
          bossSpits[a].y = 550
      bossSpits[a].isAlive = false
     end
    --reset Button
    noButton.x = 100
    noButton.y = 600
    yesButton.x = 100
    yesButton.y = 600
end

-- Touch event
function touched( event )
if(monster.isAlive == true) then
    if(event.phase == "began") then
        if(event.x < 241) then
            if(onGround) then
                monster.accel = monster.accel + 25
            end
            else
                for a=1, blasts.numChildren, 1 do
                    if(blasts[a].isAlive == false) then
                        blasts[a].isAlive = true
                        blasts[a].x = monster.x + 50
                        blasts[a].y = monster.y
                        break
                    end
                end
            end
        end
    end
end

-- NO
function noListener()
    storyboard.gotoScene("scene_splash")
    return true
end
-- YES
function yesListener(event)
    restartGame()
    return true
end

-- Check Event
function checkEvent()
     if(eventRun > 0) then
          eventRun = eventRun - 1
          if(eventRun == 0) then
               inEvent = 0
          end
     end
     if(inEvent > 0 and eventRun > 0) then
          --Do nothing
     else   
        if(boss.isAlive == false and score%10 == 0) then
            boss.isAlive = true
            boss.x = 400
            boss.y = -200
            boss.health = 10
        end
        
        -- boss event
        if(boss.isAlive == true) then
            inEvent = 15
        else        
          check = math.random(100)
          if(check > 80 and check < 99) then
            inEvent = math.random(10)
            eventRun = 1
          end
          -- broken event
          if(check > 98) then
            inEvent = 11
            eventRun = 2
          end   
          -- spike event 
          if(check > 72 and check < 81) then
             inEvent = 12
             eventRun = 1
          end
          --enemy event
          if(check > 60 and check < 73) then
             inEvent = 13
             eventRun = 1
          end
        end
      end
      runEvent()
end

-- Run Event
function runEvent()
     if(inEvent < 6) then
          groundLevel = groundLevel + 20
     end
     if(inEvent > 5 and inEvent < 11) then
          groundLevel = groundLevel - 20
     end
     if(groundLevel < groundMax) then
          groundLevel = groundMax
     end
     if(groundLevel > groundMin) then
          groundLevel = groundMin
     end
  if(inEvent == 13) then
    for a=1, enemys.numChildren, 1 do
      if(enemys[a].isAlive == false) then
        enemys[a].isAlive = true
        enemys[a].x = 500
        enemys[a].y = math.random(-50, 400)
        enemys[a].speed = math.random(2,4)
        break
      end
    end
  end
end

timer.performWithDelay(1, update, -1)
Runtime:addEventListener("touch", touched, -1)
yesButton:addEventListener("touch", yesListener )
noButton:addEventListener("touch", noListener )
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )
return scene


