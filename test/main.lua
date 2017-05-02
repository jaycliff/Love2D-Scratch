--[[
    NOTE(S):
        do...end is used for scoping, similar to why IIFEs in JavaScript are used
        looping statements usually follow a 'do' to start a block
    REFERENCE(S):
        Learning Lua from JavaScript - http://phrogz.net/lua/LearningLua_FromJS.html
        Variable declarations - http://wiki.roblox.com/index.php?title=Variable#Multiple_Assignment
        Scoping - http://lua-users.org/wiki/ScopeTutorial
        Gotchas - http://www.luafaq.org/gotchas.html
        Check types via type(variable) - http://www.lua.org/pil/2.html
        Assert - http://luatut.com/assert.html
        Create a simple game - http://osmstudios.com/tutorials/your-first-love2d-game-in-200-lines-part-1-of-3
        Metatables - http://wiki.roblox.com/index.php?title=Metatable
        Metatable, extra - http://stackoverflow.com/questions/2761713/programming-in-lua-objects
        Metamethods - http://wiki.roblox.com/index.php?title=Metamethods
        'Classes' - http://lua-users.org/wiki/SimpleLuaClasses
        Lua for Programmers - http://nova-fusion.com/2012/08/27/lua-for-programmers-part-1/
        lua doesn't support named function expressions
]]
-- debug = true
do
    local image = nil
    local timers = {
        object = 0
    }
    local object = {
        name = 'Jaycliff Arcilla',
        age = 29,
        gender = 'male',
        sanity = 'insane',
        x = 10,
        y = 10,
        sayMyName = function (self)
            return self.name
        end
    }
    local doObjectMovement = ((function ()
        local x_active = false
        local y_active = false
        local direction_priority = {
            x = {
                set = false,
                key = ''
            },
            y = {
                set = false,
                key = ''
            }
        }
        function move(object, axis, key, speed)
            if not direction_priority[axis].set then
                direction_priority[axis].set = true
                direction_priority[axis].key = key
                object[axis] = object[axis] + speed
                return true
            end
            if direction_priority[axis].key == key then
                object[axis] = object[axis] + speed
                return true
            end
            return false
        end
        return function ()
            local x_active = false
            local y_active = false
            if love.keyboard.isDown('w') then
                y_active = move(object, 'y', 'w', -1)
            end
            if love.keyboard.isDown('s') then
                y_active = move(object, 'y', 's', 1)
            end
            if love.keyboard.isDown('a') then
                x_active = move(object, 'x', 'a', -1)
            end
            if love.keyboard.isDown('d') then
                x_active = move(object, 'x', 'd', 1)
            end
            if not x_active then
                direction_priority.x.set = false
                direction_priority.x.key = ''
            end
            if not y_active then
                direction_priority.y.set = false
                direction_priority.y.key = ''
            end
        end
    end)())
    -- Love2D's loading mechanism
    function love.load()
        image = love.graphics.newImage('images/steve_jobs.jpg')
    end
    -- Love2D's 'step' event equivalent
    function love.update()
        doObjectMovement()
    end
    -- The draw step, similar to Game Maker's 'draw' event
    function love.draw()
        --love.graphics.draw(image, 0, 0)
        love.graphics.print(object:sayMyName(), object.x, object.y)
        love.graphics.print('Hello, world.', 160, 120)
    end
end