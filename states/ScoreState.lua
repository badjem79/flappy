--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

local BLACK_SCORE_THRESHOLD = 5
local RED_SCORE_THRESHOLD = 15

function ScoreState:init()
    self.medals = {
        ["blackMedal"] = love.graphics.newImage('images/black-medal.png'),
        ["redMedal"] = love.graphics.newImage('images/red-medal.png'),
        ["rainbowMedal"] = love.graphics.newImage('images/rainbow-medal.png')
    }
end
--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(smallFont)
    if self.score < BLACK_SCORE_THRESHOLD then
        love.graphics.draw(self.medals["blackMedal"], (VIRTUAL_WIDTH/2 - self.medals["blackMedal"]:getWidth()/2), 120)
        love.graphics.printf('Black Medal...try to reach ' .. tostring(BLACK_SCORE_THRESHOLD) ..'+ points to earn a better medal', 0, 190, VIRTUAL_WIDTH, 'center')
    elseif self.score < RED_SCORE_THRESHOLD then
        love.graphics.draw(self.medals["redMedal"], (VIRTUAL_WIDTH/2 - self.medals["redMedal"]:getWidth()/2), 120)
        love.graphics.printf('Red Medal! Try to reach ' .. tostring(RED_SCORE_THRESHOLD) ..'+ points to earn a wonderful medal', 0, 190, VIRTUAL_WIDTH, 'center')
    else
        love.graphics.draw(self.medals["rainbowMedal"], (VIRTUAL_WIDTH/2 - self.medals["rainbowMedal"]:getWidth()/2), 120)
        love.graphics.printf('YOU DID IT...RAINBOW MEDAL FOR YOU!', 0, 190, VIRTUAL_WIDTH, 'center')
    end

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Press Enter to Play Again!', 0, 220, VIRTUAL_WIDTH, 'center')
end