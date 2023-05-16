--- Digs a 3x3 tunnel for the given distance (also places torches if available)

function tunnel(dist)

    function dig()
        while turtle.detect() do
            turtle.dig()
        end
    end

    dist = dist or 50
    initial_dist = dist
    print('digging for ' .. tostring(dist) .. ' blocks...')

    repeat
        if turtle.getFuelLevel() < 100 then
            error("Fuel too low! Please refuel")
        elseif turtle.getFuelLevel() < 1000 then
            print("Warning: Low fuel")
        end

        -- Digging Up
        dig()
        turtle.forward()

        turtle.turnLeft()
        dig()
        turtle.turnRight()
        turtle.turnRight()
        dig()
        turtle.turnLeft()

        turtle.digUp()
        turtle.up()

        -- Place torches every 10 blocks
        if dist % 10 == 0 and turtle.getItemDetail()['name'] == 'minecraft:torch' then
            print(initial_dist - dist .. ' tunnelled , placing torch...')
            turtle.placeDown()
        end

        turtle.turnLeft()
        dig()
        turtle.turnRight()
        turtle.turnRight()
        dig()
        turtle.turnLeft()

        turtle.digUp()
        turtle.up()

        turtle.turnLeft()
        dig()
        turtle.turnRight()
        turtle.turnRight()
        dig()
        turtle.turnLeft()

        -- Digging Down

        dig()
        turtle.forward()

        turtle.turnLeft()
        dig()
        turtle.turnRight()
        turtle.turnRight()
        dig()
        turtle.turnLeft()

        turtle.digDown()
        turtle.down()

        turtle.turnLeft()
        dig()
        turtle.turnRight()
        turtle.turnRight()
        dig()
        turtle.turnLeft()

        turtle.digDown()
        turtle.down()

        turtle.turnLeft()
        dig()
        turtle.turnRight()
        turtle.turnRight()
        turtle.dig()
        turtle.turnLeft()

        dist = dist - 2
    until dist == 0
end

tunnel(...)
