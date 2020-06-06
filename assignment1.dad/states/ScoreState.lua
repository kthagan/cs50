--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

local BRONZE_LEVEL = 2
local SILVER_LEVEL = 4
local GOLD_LEVEL = 6

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
    self.medals = {
	['Bronze'] = love.graphics.newImage('images/bird.png'),
	['Silver'] = love.graphics.newImage('images/bird.png'),
	['Gold'] = love.graphics.newImage('images/bird.png')
    }
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

    -- KTH here with medals
    local medalKey
    if self.score >= GOLD_LEVEL then
	medalKey = 'Gold'
    elseif self.score >= SILVER_LEVEL then
	medalKey = 'Silver'
    elseif self.score >= BRONZE_LEVEL then
	medalKey = 'Bronze'
    end

    if medalKey then
        love.graphics.printf('Congratulations you earned the ' .. medalKey .. ' medal!', 0, 120, VIRTUAL_WIDTH, 'center')
	local medalImg = self.medals[medalKey]
	local medalX = (VIRTUAL_WIDTH/2) - (medalImg:getWidth()/2)
	love.graphics.draw(medalImg, medalX, 140)
    end

    love.graphics.printf('Press Enter to Play Again!', 0, 180, VIRTUAL_WIDTH, 'center')
end
