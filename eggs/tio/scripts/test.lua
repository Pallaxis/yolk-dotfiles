-- stupid copilot script that doesn't do what i want it to do even remotely
local coroutine = coroutine

function shell_ready()
    expect("~]# ")
end

local function automation()
    write("\n")

    if expect("~]# ", 100) == 0 then
        write("\n")
        expect("login: ")
        write("root\n")
        shell_ready()
    end

    write("clear\n")

    expect("rand")
end

-- Wrap the script in a coroutine
local script = coroutine.create(automation)

-- Periodically resume the coroutine
while true do
    local status, err = coroutine.resume(script)
    if not status then
        print("Error: " .. err)
        break
    end

    -- Introduce a short delay or yield control to allow manual input
    os.execute("sleep 0.1") -- Adjust this for your environment
end

