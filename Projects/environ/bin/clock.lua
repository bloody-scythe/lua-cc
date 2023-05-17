function gametime()
    time = os.time()
    if time >= 8 and time < 18.5 then
        term.setTextColor(colors.green)
        print(textutils.formatTime(time))
        term.setTextColor(colors.white)
    elseif time > 5.5 and time < 8 then
        term.setTextColor(colors.orange)
        print(textutils.formatTime(time))
        term.setTextColor(colors.white)
    else
        term.setTextColor(colors.red)
        print(textutils.formatTime(time))
        term.setTextColor(colors.white)
    end
end

function text ()
    print(os.date())
    gametime()
end

for k,v in pairs(arg) do
    if v == '-d' then
        text()
        return
    end
end

while true do
    term.clear()
    term.setCursorPos(1,1)
    text()
    sleep(0.5)
end
