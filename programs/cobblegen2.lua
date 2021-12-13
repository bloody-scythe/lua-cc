--- Smart cobblegen

storage = peripheral.wrap(... or 'back')
slot_size = storage.getItemLimit(1)
slots = storage.size()
limit = slots * slot_size

function item_count()
    list = storage.list()
    count = 0
    for slot=1,#list do
        count = count + list[slot]['count']
    end
    return count
end


--=========================--

space = limit - item_count()

print('log: There is ' .. space .. ' items of space remaining.')

while space >= 64 do
    repeat
    turtle.dig()
    until turtle.getItemCount() == 64
 
    turtle.turnLeft()
    turtle.turnLeft() 
    turtle.drop()
    turtle.turnLeft()
    turtle.turnLeft()

    space = space - 64
    print('log: There is ' .. space .. ' items of space remaining.')
end

error("No space remaining !!!")
