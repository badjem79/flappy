--[[
    PauseState Class
    Author: FG
    badjem79@gmail.com

    The PauseState is the screen of the game that set pause,
    shown during PlayState. It should
    display "Press P to resume" and also a demi transparent layer.
]]

PauseState = Class{__includes = BaseState}

function PauseState:init()
    self.image = love.graphics.newImage('images/pause.png')
    sounds['pause']:play()
    sounds['music']:pause()
end

function PauseState:update(dt)
    -- resume the game old status
    if love.keyboard.wasPressed('P') or love.keyboard.wasPressed('p') then
        sounds['music']:play()
        gStateMachine:resume('play')
    end
end

function PauseState:render()
    gStateMachine.previous:render() -- renders but without update it is freezed
    -- simple UI code
    love.graphics.setColor( 0, 0, 0, 0.4) -- transparent layer overlay
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(self.image, VIRTUAL_WIDTH/2 - self.image:getWidth()/2, VIRTUAL_HEIGHT/2 - self.image:getHeight()/2 - 30)

    love.graphics.setFont(flappyFont)
    love.graphics.printf('Press [P] to resume the Game', 0, 200, VIRTUAL_WIDTH, 'center')
    
end