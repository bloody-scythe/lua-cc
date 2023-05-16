for k,name in pairs(arg) do
    if k == 0 then 
    elseif fs.exists(name) and not fs.isDir(name) then
        for line in io.lines(name) do
            print(line)
        end
    end
end
