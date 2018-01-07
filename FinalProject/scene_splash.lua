

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
storyboard.removeAll()

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

function scene:createScene( event )
  local group = self.view
  titleBg = display.newImage('images/menu.png')
  titleBg.anchorX = 0
  titleBg.anchorY = 0
  playBtn = display.newImage('images/playButton.png')
  playBtn.x = 240
  playBtn.y = 200
  local function  onTap()
    storyboard.gotoScene("scene_game")
  end
    playBtn:addEventListener('tap', onTap)
    group:insert(titleBg)
    group:insert(playBtn)
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )
return scene

