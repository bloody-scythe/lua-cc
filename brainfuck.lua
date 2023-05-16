local brainfuck = {}

brainfuck.charmap = {
  -- list of command characters
    [">"] = "i = i+1;";
    ["<"] = "i = i-1;";
    ["+"] = "t[i] = t[i]+1;";
    ["-"] = "t[i] = t[i]-1;";
    [","] = "t[i] = io.read():byte()";
    ["."] = "io.write(string.char(tostring(t[i])));";
    ["="] = "io.write(tostring(t[i]));"; -- print number from cell
    ["["] = "while t[i] ~= 0 do ";
    ["]"] = "end;";
    ["#"] = "r = t[i];"; -- save cell to register
    ["$"] = "t[i] = r;"; -- load register into cell
    ["*"] = "t[i] = t[i] * r;"; -- multiply cell by register
    ["/"] = "t[i] = t[i] // r;"; -- divide cell by register (floor division)
    ["%"] = "t[i] = t[i] % r;"; -- modulus of cell by register
    ["!"] = "return t[i];"; -- returns the cell value (careful, can only use once at the end)
    ["@"] = ""; -- for reading a byte ahead from source into cell
    ["&"] = ""; -- for reading a byte ahead from source into register
}

-- if character isn't on list return nothing
setmetatable(brainfuck.charmap, {__index=function() return "" end})
function brainfuck.uncomment(src)
  src = src:gsub("[\n\t ]", "") -- remove newlines tabs and spaces
  src = src:gsub("%(:.-:%)", "") -- remove comments "(::)"
  return src
end

function brainfuck.compile(src, charmap)
  local charmap = charmap or brainfuck.charmap

  src = brainfuck.uncomment(src)

  -- set environment for code to run
  local code = "local i = 0; local r = 0 ; local t = {}; setmetatable(t, {__index=function() return 0 end})"

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
