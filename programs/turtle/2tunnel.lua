--- Digs a 2x1 tunnel for the given distance
function dig(dist)
    repeat
        turtle.dig()
        turtle.forward()
        turtle.digUp()
        dist = dist - 1
    until dist == 0
end

dig(...)
