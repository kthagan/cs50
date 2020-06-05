PauseState = Class{__includes = BaseState}

function PauseState:init()
end

--[[
    Keeps track of how much time has passed and decreases count if the
    timer has exceeded our countdown time. If we have gone down to 0,
    we should transition to our PlayState.
]]
function PauseState:update(dt)
    -- transition to play when 'p' is pressed
    if love.keyboard.wasPressed('p') then
        gStateMachine:change('play')
    end
end

function PauseState:render()
    -- render pause spause string big in the middle of the screen
    love.graphics.setFont(hugeFont)
    love.graphics.printf("||", 0, 120, VIRTUAL_WIDTH, 'center')
end
