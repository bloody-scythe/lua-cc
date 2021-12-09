--- XYZ movement libraty
--- For keeping track of position and rotation
--- and also moving automaticaly

xyz = {}

--- x is +F and -B, y is +R and -L. Z is for height
xyz.pos = { x = 0, y = 0, z = 0 }
xyz.rotation = 0

--- Updates the rotation by the angle
function xyz.rotate(angle)
	xyz.rotation = xyz.rotation + angle
	if xyz.rotation >= 360 then
		xyz.rotation = xyz.rotation - 360
	elseif xyz.rotation <= -360 then
		xyz.rotation = xyz.rotation + 360
	end
end

--- Turns left accounting for rotation
function xyz.left(times)
	times = times or 1
	for i=1,times do
		turtle.left()
		xyz.rotate(-90)
	end
end

--- Turns left accounting for rotation
function xyz.right(times)
	times = times or 1
	for i=1,times do
		turtle.right()
		xyz.rotate(90)
	end
end

--- TODO functions to move (front, back, up and down) updating position and accounting for rotation

return xyz
