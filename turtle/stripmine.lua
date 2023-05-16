--- Digs a 3x1 tunnel for the given distance (also places torches if available)

function dig(direction)
    direction = direction or 'forward'

    if direction == 'forward' then
        succeded, block = turtle.inspect()
    elseif direction == 'up' then
        succeded, block = turtle.inspectUp()
    elseif direction == 'down' then
        succeded, block = turtle.inspectDown()
    else
        printError('error:Not a valid side!')
        os.pullEvent('key')
    end

    if succeded then
        if block.name == 'minecraft:deepslate_diamond_ore' or block.name == 'minecraft:diamond_ore' then
            print('Found a diamond! waiting for input...')
            os.pullEvent('key')
        else
            if direction == 'forward' then
                turtle.dig()
            elseif direction == 'up' then
                turtle.digUp()
            elseif direction == 'down' then
                turtle.digDown()
            else
                printError('error:Not a valid side!')
                os.pullEvent('key')
            end
        end
    end
end
    

function mine(dist)
    dist = dist or 50
    print('digging for ' .. tostring(dist) .. ' blocks...')
    repeat
        if turtle.getFuelLevel() < 10 then
            error("Fuel too low! Please refuel")
        elseif turtle.getFuelLevel() < 1000 then
            print("Warning: Low fuel")
        end

        dig()
        move = turtle.forward()

        if move then dist = dist - 1 end

        dig('up')
        dig('down')

        item = turtle.getItemDetail()
        if item then
            if dist % 15 == 0 and item.name == 'minecraft:torch' then
                print('placing torch...')
                turtle.placeDown()
            end
        end

    until dist == 0
end

mine(...)
