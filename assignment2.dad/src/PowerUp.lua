PowerUp = Class{}

function PowerUp:init()
    -- simple positional and dimensional variables
    self.width = 16
    self.height = 16

    -- set initial x, y and velocities
    self.x = math.random(self.width + 5, VIRTUAL_WIDTH - self.width - 5)
    self.y = self.height + 10 -- start near top of screen
    self.dx = 0
    self.dy = 25  -- 25 seems to be a nice fall rate; may need to take into account frame rate
end

--[[
    Expects an argument with a bounding box, be that a paddle or a brick,
    and returns true if the bounding boxes of this and the argument overlap.
]]
function PowerUp:collides(target)
    -- first, check to see if the left edge of either is farther to the right
    -- than the right edge of the other
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end

    -- then check to see if the bottom edge of either is higher than the top
    -- edge of the other
    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end 

    -- if the above aren't true, they're overlapping
    return true
end

--[[
KTH - I think we will delete this function
    Places the ball in the middle of the screen, with no movement.
]]
function PowerUp:reset()
    self.x = VIRTUAL_WIDTH / 2 - 2
    self.y = VIRTUAL_HEIGHT / 2 - 2
    self.dx = 0
    self.dy = 0
end

function PowerUp:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt

    -- allow ball to bounce off walls
    if self.x <= 0 then
        self.x = 0
        self.dx = -self.dx
        gSounds['wall-hit']:play()
    end

    if self.x >= VIRTUAL_WIDTH - 8 then
        self.x = VIRTUAL_WIDTH - 8
        self.dx = -self.dx
        gSounds['wall-hit']:play()
    end

    if self.y <= 0 then
        self.y = 0
        self.dy = -self.dy
        gSounds['wall-hit']:play()
    end
end

function PowerUp:render()
    -- index 9 is the add a ball powerup graphic
    love.graphics.draw(gTextures['main'], gFrames['powerUps'][9],
        self.x, self.y)
end
