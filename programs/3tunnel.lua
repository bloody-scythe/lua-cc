--- Digs a 3x1 tunnel for the given distance (also places torches if available)
function dig(dist)
    dist = dist or 50
    print('digging for ' .. tostring(dist) .. ' blocks...')
    repeat
        if turtle.getFuelLevel() < 10 then
            error("Fuel too low! Please refuel")
        elseif turtle.getFuelLevel() < 1000 then
            print("Warning: Low fuel")
        end

        turtle.dig()
        turtle.forward()
        turtle.digUp()
        turtle.digDown()

        if dist % 10 == 0 and turtle.getItemDetail()['name'] == 'minecraft:torch' then
            print('placing torch...')
            turtle.placeDown()
        end

        dist = dist - 1
    until dist == 0
end

dig(...)
