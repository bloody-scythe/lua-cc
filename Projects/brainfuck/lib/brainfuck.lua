local brainfuck = {}

brainfuck.charmap = {
  -- list of command characters
    [">"] = "i = i+1 ;\n";
    ["<"] = "i = i-1 ;\n";
    ["+"] = "t[i] = t[i]+1 ;\n";
    ["-"] = "t[i] = t[i]-1 ;\n";
    [","] = "t[i] = io.read():byte() ;\n";
    ["."] = "io.write(string.char(tostring(t[i]))) ;\n";
    ["["] = "while t[i] ~= 0 do\n";
    ["]"] = "end ;\n";
    ["="] = "io.write(tostring(t[i])) ;\n"; -- print number from cell
    ["!"] = "r = t[i] ;\n"; -- save cell to register
    ["$"] = "t[i] = r ;\n"; -- load register into cell
    ["*"] = "t[i] = t[i] * r ;\n"; -- multiply cell by register
    ["/"] = "t[i] = t[i] // r ;\n"; -- divide cell by register (floor division)
    ["%"] = "t[i] = t[i] % r ;\n"; -- modulus of cell by register
    ["|"] = "return t[i] ;\n"; -- returns the cell value (careful, can only use once at the end)

    ["@"] = ""; -- for reading a byte ahead from source into cell
    ["&"] = ""; -- for reading a byte ahead from source into register

    ["_"] = "os.sleep(t[i]) ;\n";

    ["u"] = "tutle.up() ;\n";
    ["d"] = "tutle.down() ;\n";
    ["l"] = "tutle.turnLeft() ;\n";
    ["r"] = "tutle.turnRight() ;\n";
    ["f"] = "tutle.forward() ;\n";
    ["b"] = "tutle.back() ;\n";

    ["D"] = "tutle.dig() ;\n";
    ["E"] = "tutle.digUp() ;\n";
    ["C"] = "tutle.digDown() ;\n";

    ["P"] = "tutle.place() ;\n";
    ["O"] = "tutle.placeUp() ;\n";
    ["I"] = "tutle.placeDown() ;\n";

    ["i"] = "if tutle.detect() then t[i] = 1 else t[i] = 0 end ;\n";
    ["R"] = "turtle.refuel() ;\n";
    ["S"] = "turtle.select(t[i]) ;\n";

    ["d"] = "turtle.drop(t[i]) ;\n";
    ["e"] = "turtle.dropUp(t[i]) ;\n";
    ["c"] = "turtle.dropDown(t[i]) ;\n";

}

-- if character isn't on list return nothing
setmetatable(brainfuck.charmap, {__index=function() return "" end})
function brainfuck.uncomment(src)
  src = src:gsub("[\n\t ]", "") -- remove newlines tabs and spaces
  src = src:gsub("(:.-:)", "") -- remove comments "(::)"
  return src
end

function brainfuck.compile(src, charmap)
  local charmap = charmap or brainfuck.charmap

  src = brainfuck.uncomment(src)

  -- set environment for code to run
  local code = "local i = 0; local r = 0; local t = {}; setmetatable(t, {__index=function() return 0 end})\n"

  local i = 1
  while i < src:len() + 1 do
    local char = src:sub(i,i)
    if char == "@" then
      i = i + 1 -- go to next character
      code = code.."t[i] = '"..src:sub(i,i):byte().."';"

    elseif char == "&" then
      i = i + 1 -- go to next character
      code = code.."r = '"..src:sub(i,i):byte().."';"

    else
      code = code..charmap[char]
    end
  i = i + 1
  end

  return code
end

function brainfuck.fuck(src)
  local code = brainfuck.compile(src)
  return load(code)()

end

return brainfuck
