-- Script expects that it is running before device has been booted
function shell_ready()
	tio.expect("~]# ")
end

tio.write("\n")

while true do
	-- Puts SoM into EVK2 mode for this boot only
	while true do
		tio.write("t")
		if tio.readline():find("5. Continue booting") then
			print("PASSED")
			tio.write("2\n")
			tio.msleep("200")
			tio.write("4\n")
			tio.msleep("200")
			tio.write("5\n")
			break
		end
	end

	tio.expect("login:")
	tio.write("root\n")
	shell_ready()
	tio.write("clear\n")

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

	-- Start and pick up stream with ffplay storing pid for later
	tio.write("oclea_gstreamer_interactive_example -r\n")
	tio.expect(">>>")
	local command = "sh -c 'setsid ffplay -fflags nobuffer -flags low_delay -probesize 32 -analyzeduration 1 rtsp://" .. ip .. ":8554/test >/dev/null 2>&1 & echo $!'"
	print(command)
	local fh = io.popen(command, "r")
	local pid = tonumber(fh:read("*l"))
	fh:close()

	tio.msleep("8000")
	print(serial)
	os.execute("kill -TERM -" .. pid)
end
