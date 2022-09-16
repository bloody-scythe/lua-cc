function gametime()    
    time = os.time()
    if time > 6 and time < 18.5 then
        term.setTextColor(colors.green)
        print(textutils.formatTime(time))
        term.setTextColor(colors.white)
    else
        term.setTextColor(colors.red)
        print(textutils.formatTime(time))
        term.setTextColor(colors.white)
    end
end

function main ()
    print(os.date())
    gametime()
end

for k,v in pairs(arg) do
    if v == '-d' then main() return end
end

while true do
    term.clear()
    term.setCursorPos(1,1)
    main()
    sleep(0.5)
end 
