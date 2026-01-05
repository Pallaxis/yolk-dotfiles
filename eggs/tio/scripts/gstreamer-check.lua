function shell_ready()
	tio.expect("~]# ")
end

tio.write("\n")

while true do
	if not tio.expect("~]# ", 100) then
		tio.write("\n")
		tio.expect("login: ")
		tio.write("root\n")
		shell_ready()
	end
	tio.write("clear\n")

	tio.write("oclea_gstreamer_interactive_example -V\n")
	tio.expect(">>>")

	tio.write("vout set zoom 3\nvout set offset-x 1400\nvout set offset-y 800\n")

	tio.expect("login: ")
end
