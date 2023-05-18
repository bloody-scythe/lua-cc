local brainfuck = require("/lib/brainfuck")

local function help()
  print("Usage: ".. arg[0] .." inputfile.bf")
end

local function main()
  if #arg ~= 1 then error("Incorrect number of arguments") end

  if fuck_this then
    local src=""
    for k,v in ipairs(arg) do
      src = src .. v
    end
    brainfuck.fuck(src)

  else
    input = arg[1]
    input_exists = fs.exists(input)
    if input_exists then
      local src = fs.open(input,'r'):readAll()
      brainfuck.fuck(src)
    else
      error("File doesn't exist!")
    end
  end
end


--- argument handling
if arg[1] == '-h' or arg[1] == '--help' then help() os.exit() end
if arg[1] == '-it' then fuck_this = true table.remove(arg, 1) end

main()
