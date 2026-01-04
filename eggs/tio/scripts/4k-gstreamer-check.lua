function shell_ready()
	tio.expect("~]# ")
end

-- Function to check if a process is running
local function is_process_running(pid)
	local handle = io.popen("ps -p " .. pid)  -- For Unix/Linux
	local result = handle:read("*a")
	handle:close()
	return result:match(pid) ~= nil
end


tio.write("\n")

while true do
	-- Puts SoM into EVK2 mode for this boot only
	-- while true do
	-- 	tio.write("t")
	-- 	if tio.readline():find("5. Continue booting") then
	-- 		print("PASSED")
	-- 		tio.write("2\n")
	-- 		tio.msleep("200")
	-- 		tio.write("4\n")
	-- 		tio.msleep("200")
	-- 		tio.write("5\n")
	-- 		break
	-- 	end
	-- end

	if not tio.expect("~]# ", 100) then
		tio.write("\n")
		tio.expect("login: ")
		tio.write("root\n")
		shell_ready()
	end

	-- Grabs serial
	tio.write("oclea_info\n")
	serial = ""
	while true do
		local current_line = tio.readline()
		serial = current_line:match('"serial%-number"%s*:%s*"(.-)"')
		if serial then break end
	end

	-- Grabs IP addr
	tio.write("ip a show eth0\n")
	ip = ""
	while(true)
		do
		local current_line = tio.readline()
		ip = current_line:match("%f[%a]inet%f[%A]%s+(%d+%.%d+%.%d+%.%d+)")
		if ip then break end
	end

	-- Provision sensor, modprobe driver
	tio.write("hydra_provision -i 0 -s 0x0101 0x0106 -s 0x0401 0x0f00 -s 0x0402 0x0870 -s 0x0403 0x001e -s 0x0103 0x0101 -s 0x0102 0x0037\n")
	tio.expect("~]# ")

	tio.write("hydra\n")
	tio.expect("~]# ")

	-- Start and pick up stream with ffplay storing pid for later
	tio.write("oclea_gstreamer_interactive_example -r\n")
	tio.expect(">>>")
	tio.sleep(1)

	tio.write("set cap resolution 3840x2160\n")
	-- tio.expect(">>>")
	-- tio.write("set prop sensor-fps 5\n")
	-- tio.expect(">>>")
	-- tio.write("set cap bitrate 10000000\n")
	tio.expect(">>>")

	local command = "sh -c 'setsid ffplay -fflags nobuffer -flags low_delay -probesize 32 -analyzeduration 1 -autoexit rtsp://" .. ip .. ":8554/test >/dev/null 2>&1 & echo $!'"
	print(command)
	local fh = io.popen(command, "r")
	local pid = tonumber(fh:read("*l"))
	fh:close()

	-- Wait for the process to stop
	while is_process_running(pid) do
		os.execute("sleep 1")  -- Wait for 1 second before checking again
	end

	-- tio.msleep("20000")
	-- print(serial)
	-- os.execute("kill -TERM -" .. pid)
end
