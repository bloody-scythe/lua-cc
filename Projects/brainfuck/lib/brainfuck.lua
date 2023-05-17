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
    ["{"] = "if t[i] ~= 0 then \n";
    ["}"] = "end ;\n";
    ["^"] = "break ;\n"; -- print number from cell
    ["?"] = "io.write(tostring(t[i])) ;\n"; -- print number from cell
    ["!"] = "r = t[i] ;\n"; -- save cell to register
    ["$"] = "t[i] = r ;\n"; -- load register into cell
    ["*"] = "t[i] = t[i] * r ;\n"; -- multiply cell by register
    ["/"] = "t[i] = math.floor(t[i] / r) ;\n"; -- divide cell by register (floor division)
    ["%"] = "t[i] = t[i] % r ;\n"; -- modulus of cell by register
    ["="] = "if t[i] == r then t[i] = 1 else t[i] = 0 end ;\n"; -- if cell equals to register set to 1
    ["~"] = "if t[i] == 0 then t[i] = 1 else t[i] = 0 end ;\n";
    ["|"] = "return t[i] ;\n"; -- returns the cell value (careful, can only use once at the end)

    ["@"] = ""; -- for reading a byte ahead from source into cell
    ["&"] = ""; -- for reading a byte ahead from source into register

    ["_"] = "os.sleep(t[i]) ;\n";
    ["("] = "redstone.setAnalogOutput(sides[r], t[i]) ;\n";
    [")"] = "t[i] = redstone.getAnalogInput(sides[r]) ;\n";

    ["u"] = "turtle.up() ;\n";
    ["d"] = "turtle.down() ;\n";
    ["l"] = "turtle.turnLeft() ;\n";
    ["r"] = "turtle.turnRight() ;\n";
    ["f"] = "turtle.forward() ;\n";
    ["b"] = "turtle.back() ;\n";

    ["D"] = "turtle.dig() ;\n";
    ["E"] = "turtle.digUp() ;\n";
    ["C"] = "turtle.digDown() ;\n";

    ["P"] = "turtle.place() ;\n";
    ["O"] = "turtle.placeUp() ;\n";
    ["I"] = "turtle.placeDown() ;\n";

    ["i"] = "if turtle.detect() then t[i] = 1 else t[i] = 0 end ;\n";
    ["R"] = "turtle.refuel() ;\n";
    ["S"] = "turtle.select(t[i]) ;\n";
    [":"] = "if turtle.compare() then t[i] = 1 else t[i] = 0 end ;\n";
    ["´"] = "t[i] = turtle.getItemCount() ;\n"; -- get number of items in slot
    ["`"] = "t[i] = turtle.getItemSpace() ;\n"; -- get space remaining in slot
    ["d"] = "turtle.drop(t[i]) ;\n";
    ["e"] = "turtle.dropUp(t[i]) ;\n";
    ["c"] = "turtle.dropDown(t[i]) ;\n";
}

-- if character isn't on list return nothing
setmetatable(brainfuck.charmap, {__index=function() return "" end})
function brainfuck.uncomment(src)
  src = src:gsub("#=.-=#", "") -- remove comments "(::)"
  src = src:gsub("[\n\t ]", "")-- remove newlines tabs and spaces
  return src
end

function brainfuck.compile(src, charmap)
  local charmap = charmap or brainfuck.charmap

  -- src = brainfuck.uncomment(src)

  -- set environment for code to run
  local code = "local i = 0; local r = 0; local t = {}; setmetatable(t, {__index=function() return 0 end});\n"
  code = code .. 'sides = {}; sides[0] = "bottom"; sides[1] = "top"; sides[2] = "back"; sides[3] = "front"; sides[4] = "right"; sides[5] = "left"; sides["bottom"] = 0; sides["top"] = 1; sides["back"] = 2; sides["front"] = 3; sides["right"] = 4; sides["left"] = 5; \n'

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
