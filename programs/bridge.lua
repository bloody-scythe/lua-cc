--- Bridges while digging for as long as it has blocks (reuses broken blocks)
function countItems()
    count = 0
    for slot=1,16 do
        turtle.select(slot)
        n = turtle.getItemCount()
        count = count + n
    end
    return count
end

while countItems() > 0 do
    for slot=1,16 do
        turtle.select(slot)
        while turtle.getItemCount() > 0
        do
            turtle.dig()
            turtle.forward()
            turtle.placeDown()
            turtle.digUp()
        end
    end
end
