-- Tests both hydra and non hydra streaming, before wiping hydra
-- Assumes you have the IP already, as it shouldn't change while testing sensors.
-- Also assumes that the sensor is unprovisioned to begin with
-- You need to have run oclea_bootstrap SENSORNAME at least once beforehand

function ShellReady()
	expect("~]# ")
end

IP = "10.71.0.73"
Command = string.format("alacritty -e ffplay -fflags nobuffer -flags low_delay -probesize 32 -analyzeduration 1 rtsp://%s:8554/test", IP)

write("\n")

while true do
	if expect("~]# ", 100) == 0 then
		write("\n")
		expect("login: ")
		write("root\n")
		ShellReady()
	end
	write("clear\n")
	ShellReady()

	write("oclea_gstreamer_interactive_example -r\n")
	expect(">>>")
	os.execute(Command)

	write("exit\n")
	ShellReady()

	write("hydra_provision -i 0 -s 0x0101 0x0103 -s 0x0401 0x0780 -s 0x0402 0x0438 -s 0x0403 0x001e -s 0x0103 0x0101\n")
	ShellReady()

	write("reboot\n")
	if expect("~]# ", 100) == 0 then
		write("\n")
		expect("login: ")
		write("root\n")
		ShellReady()
	end
	write("clear\n")
	ShellReady()

	write("oclea_gstreamer_interactive_example -r\n")
	expect(">>>")
	os.execute(Command)
	write("exit\n")
	ShellReady()

	write("hydra_provision -i 0 -e\n")
	ShellReady()

	expect("login: ")
end
