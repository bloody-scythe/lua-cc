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

print('log: space is  ' .. limit - item_count() .. '(' .. ( limit - item_count() ) / 64 .. ' stacks)')

while limit - item_count() >= 64 do
    repeat
    turtle.dig()
    until turtle.getItemCount() == 64
 
    turtle.turnLeft()
    turtle.turnLeft() 
    turtle.drop()
    turtle.turnLeft()
    turtle.turnLeft()

    print('log: space is  ' .. limit - item_count() .. '(' .. ( limit - item_count() ) / 64 .. ' stacks)')
end

error("No space remaining !!!")
