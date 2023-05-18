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
    ["*"] = "t[i] = t[i] * r ;\n"; -- multiply cell by register
    ["/"] = "t[i] = math.floor(t[i] / r) ;\n"; -- divide cell by register (floor division)
    ["%"] = "t[i] = t[i] % r ;\n"; -- modulus of cell by register
    ["|"] = "return t[i] ;\n"; -- returns the cell value (careful, can only use once at the end)

    [":"] = "i = r"; --goto cell
    [";"] = "r = i"; --save cell

    ["~"] = "if t[i] == 0 then t[i] = 1 else t[i] = 0 end ;\n"; -- invert 0 and 1
    ["="] = "if t[i] == r then t[i] = 1 else t[i] = 0 end ;\n"; -- if cell equals to register set to 1
    ["("] = "if t[1] < r then t[i] = 1 else t[i] = 0 end ;\n";  --less than
    [")"] = "if t[1] > r then t[i] = 1 else t[i] = 0 end ;\n";  --more than

    ["!"] = "r = t[i] ;\n"; -- save cell to operational register
    ["$"] = "t[i] = r ;\n"; -- load operational register into cell

    ["1"] = "r1 = t[i] ;\n"; -- save cell to register 1
    ["4"] = "t[i] = r1 ;\n"; -- load register into cell 1
    ["7"] = "t[i] = r1 ;\n"; -- load register 1 into op register

    ["2"] = "r2 = t[i] ;\n"; -- save cell to register 2
    ["5"] = "t[i] = r2 ;\n"; -- load register into cell 2
    ["8"] = "t[i] = r1 ;\n"; -- load register 2 into op register

    ["3"] = "r3 = t[i] ;\n"; -- save cell to register 3
    ["6"] = "t[i] = r3 ;\n"; -- load register into cell 3
    ["9"] = "t[i] = r1 ;\n"; -- load register 3 into op register

    ["´"] = "cls(t[i]) ;\n"; -- clear screen 0 for whole 1 for line
    ["`"] = "term.setCursorPos(t[i],r) ;\n";

    ["_"] = "os.sleep(t[i]) ;\n";
    ["&"] = "os.sleep(t[i] / 20) ;\n";

    ["("] = "redstone.setAnalogOutput(sides[r], t[i]) ;\n";
    [")"] = "t[i] = redstone.getAnalogInput(sides[r]) ;\n";

    ["W"] = "turtle.up() ;\n";
    ["S"] = "turtle.down() ;\n";
    ["a"] = "turtle.turnLeft() ;\n";
    ["d"] = "turtle.turnRight() ;\n";
    ["w"] = "turtle.forward() ;\n";
    ["s"] = "turtle.back() ;\n";

    ["p"] = "turtle.attack() ;\n";
    ["P"] = "turtle.attackDown() ;\n";
    ["Ç"] = "turtle.attackUp() ;\n";

    ["e"] = "turtle.dig() ;\n";
    ["E"] = "turtle.digDown() ;\n";
    ["D"] = "turtle.digUp() ;\n";

    ["f"] = "turtle.place() ;\n";
    ["F"] = "turtle.placeDown() ;\n";
    ["V"] = "turtle.placeUp() ;\n";

    ["q"] = "turtle.drop(t[i]) ;\n";
    ["Q"] = "turtle.dropDown(t[i]) ;\n";
    ["A"] = "turtle.dropUp(t[i]) ;\n";

    ["t"] = "turtle.suck() ;\n";
    ["T"] = "turtle.suckDown() ;\n";
    ["G"] = "turtle.suckUp() ;\n";

    ["y"] = "if turtle.detect() then t[i] = 1 else t[i] = 0 end ;\n";
    ["Y"] = "if turtle.detectDown() then t[i] = 1 else t[i] = 0 end ;\n";
    ["H"] = "if turtle.detectUp() then t[i] = 1 else t[i] = 0 end ;\n";

    ["u"] = "if turtle.compare() then t[i] = 1 else t[i] = 0 end ;\n";
    ["U"] = "if turtle.compareDown() then t[i] = 1 else t[i] = 0 end ;\n";
    ["J"] = "if turtle.compareUp() then t[i] = 1 else t[i] = 0 end ;\n";

    ["i"] = "turtle.select(t[i]) ;\n";

    ["z"] = "t[i] = turtle.getItemCount() ;\n"; -- get number of items in slot
    ["x"] = "t[i] = turtle.getItemSpace() ;\n"; -- get space remaining in slot

    ["r"] = "turtle.refuel(t[i]) ;\n";
    ["R"] = "turtle.refuel() ;\n";
}
-- if character isn't on list return nothing
etmetatable(brainfuck.charmap, {__index=function() return "" end})
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
  code = code .. 'sides = {}; sides[0] = "bottom"; sides[1] = "top"; sides[2] = "back"; sides[3] = "front"; sides[4] = "right"; sides[5] = "left"; sides["bottom"] = 0; sides["top"] = 1; sides["back"] = 2; sides["front"] = 3; sides["right"] = 4; sides["left"] = 5;\n'
  code = code .. "function cls(i) if i == 0 then term.clear() else term.clearLine() end;\n"

  local i = 1
  while i < src:len() + 1 do
    local char = src:sub(i,i)
      code = code..charmap[char]
    i = i + 1
  end

  return code
end

function brainfuck.fuck(src)
  local code = brainfuck.compile(src)
  return load(code)()
end

return brainfuck
