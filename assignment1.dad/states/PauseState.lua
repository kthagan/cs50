PauseState = Class{__includes = BaseState}

function PauseState:init()
    self.count = 2
    self.timer = 0
end

--[[
    Keeps track of how much time has passed and decreases count if the
    timer has exceeded our countdown time. If we have gone down to 0,
    we should transition to our PlayState.
]]
function PauseState:update(dt)
        -- when 0 is reached, we should enter the PlayState
        if self.count == 0 then
            gStateMachine:change('play')
        end

--[[
    self.timer = self.timer + dt

    -- loop timer back to 0 (plus however far past COUNTDOWN_TIME we've gone)
    -- and decrement the counter once we've gone past the countdown time
    if self.timer > COUNTDOWN_TIME then
        self.timer = self.timer % COUNTDOWN_TIME
        self.count = self.count - 1

    end
]]
end

function PauseState:render()
    -- render count big in the middle of the screen
    love.graphics.setFont(hugeFont)
    love.graphics.printf("||", 0, 120, VIRTUAL_WIDTH, 'center')
end
