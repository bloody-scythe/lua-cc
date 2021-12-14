--- Simple cobblegen
while true do
    repeat
    turtle.dig()
    until turtle.getItemCount() == 64
 
    turtle.turnLeft()
    turtle.turnLeft() 
    turtle.drop()
    turtle.turnLeft()
    turtle.turnLeft()
end
