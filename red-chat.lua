args = {...}
monitor = peripheral.find("monitor")
currUser = args[1]
users = {args[1]}
function OpenPort(side)
    modem = peripheral.find("modem")
    if rednet.isOpen(side) then
        print("Rednet port is already open")
        return true
    else
        rednet.open(side)
        if rednet.isOpen("back") then
            print("Rednet port has been opened")
            return true
        else
            print("Failed to open rednet port")
            return false
        end
    end
end

function HandleMessages()
    while true do
        event, id, text = os.pullEvent()
        if event == "rednet_message" then
            username = string.match(text, "%$user:(.*)")
            if username then
                users[username] = username
            elseif string.match(text, "%$getUsers") then
                for index, name in pairs(users) do
                    rednet.broadcast("$user:" .. name)
                end
            else
                monitor.write(text)
                cX, cY = monitor.getCursorPos()
                monitor.setCursorPos(1, cY + 1)
            end
        end
    end
end

function ProcessInput()
    rednet.broadcast("User " .. currUser .. " has connected")
    userMsg = currUser .. "> "
    while true do
        text = io.read()
        if (text == "$listCurrentUsers") then
            term.clear()
            term.write("List of known users:\n")
            for index, name in pairs(users) do
                term.write(name .. "\n")
            end
        elseif text == "exit" then
            return
        else
            rednet.broadcast(userMsg .. text)
        end
    end
end
term.clear()
print("Welcome to red-chat")
print("This is a Geno Enterprises Program")
monitor.clear()
OpenPort(args[2])
parallel.waitForAny(HandleMessages, ProcessInput)