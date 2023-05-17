#!/usr/bin/lua
project="brainfuck"

files = {
"bin/bfc.lua",
"bin/fuck.lua",
"lib/brainfuck.lua"
}


installer = ""

-- create file table

installer = installer .. "files = {}\n"

-- add files to list with filename as key and content as value
for k,file in ipairs(files) do
  installer = installer .. "files['" .. file .. "'] = [[\n" -- create key and start string
  contents = io.open(file,'r'):read("*all") -- read file contents
  installer = installer .. contents .. "]]\n" -- append file contents and string close
end

-- create files with contents
  installer = installer .. [[for name,contents in pairs(files) do
if fs.exists(name) then fs.delete(name) end;
file = fs.open(name, 'w')
file:write(contents)
file:close()
end
]]

-- create actual installer file
io.open(project .. '_installer.lua', 'w'):write(installer):close()
