PowerUp = Class{}

function PowerUp:init()
    -- simple positional and dimensional variables
    self.width = 16
    self.height = 16

    -- set initial x, y and velocities
    self.x = math.random(self.width + 5, VIRTUAL_WIDTH - self.width - 5)
    self.y = self.height + 10 -- start near top of screen
    self.dy = 25  -- 25 seems to be a nice fall rate; may need to take into account frame rate

    self.inPlay = true

    -- particle system belonging to the brick, emitted on hit
    self.psystem = love.graphics.newParticleSystem(gTextures['particle'], 64)

    -- lasts between 0.5-1 seconds seconds
    self.psystem:setParticleLifetime(2, 4)

    -- give it an acceleration of anywhere between X1,Y1 and X2,Y2 (0, 0) and (80, 80) here
    -- gives generally upward
    self.psystem:setLinearAcceleration(-50, 0, 50, -200)

    -- spread of particles; normal looks more natural than uniform
    self.psystem:setAreaSpread('normal', 10, 10)

    -- set the particle system to interpolate between two colors; in this case, we give
    -- it our self.color but with varying alpha; brighter for higher tiers, fading to 0
    -- over the particle's lifetime (the second color)
    self.color = 3;  -- see Brick.lua for colors
    self.tier = 1;  -- trying this
    self.psystem:setColors(
        paletteColors[self.color].r,
        paletteColors[self.color].g,
        paletteColors[self.color].b,
        55 * (self.tier + 1),
        paletteColors[self.color].r,
        paletteColors[self.color].g,
        paletteColors[self.color].b,
        0
    )
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
    self.dy = 0
end

function PowerUp:update(dt)
    self.y = self.y + self.dy * dt
    self.psystem:update(dt)
end

function PowerUp:hit()
    gSounds['high-score']:play()
    self.psystem:emit(64)
    self.inPlay = false  -- only allow the ball spawning to happen once
end

function PowerUp:render()
    if self.inPlay then
        -- index 9 is the add a ball powerup graphic
        love.graphics.draw(gTextures['main'], gFrames['powerUps'][9],
            self.x, self.y)
    end
    love.graphics.draw(self.psystem, self.x + 8, self.y + 8)
end
