brainfuck = require("/lib/brainfuck")

local function help()
  print("Usage: ".. arg[0] .." inputfile.bf outputfile.lua")
end

local function main()
  if #arg ~= 2 then error("Incorrect number of arguments") end

  input = arg[1]
  output = arg[2]
  
  input_exists = fs.exists(input)
  output_exists = fs.exists(output)

  if input_exists then
    src = fs.open(input,'r'):readAll()
    code = brainfuck.compile(src)
    if output_exists then

      term.setTextColor(colors.yellow)
      io.write('Atention!:')
      term.setTextColor(colors.white)
      print(output .. " already exists, do you wanna overwite it? [y/N]")
      answer = string.char(io.read():byte())
      if answer == 'y' or answer == 'Y' then
        fs.delete(output)
        print('Old file deleted!')
        file = fs.open(output,'w')
        file.write(code)
        file.close()
      end
    else
      file = fs.open(output,'w')
      file.write(code)
      file.close()
    end
  end
end


--- argument handling
if arg[1] == '-h' or arg[1] == '--help' then
  help()
else
  main()
end
