function shell_ready()
	tio.expect("~]# ")
end

tio.write("\n")

while true do
	tio.write("\n")
	tio.expect("login:")
	tio.write("root\n")
	shell_ready()
	tio.write("clear\n")

	tio.write("hydra_provision -i 0 -e\n")
	shell_ready()
	tio.write("hydra\n")
	-- tio.write("\n")

	tio.expect("login:")
end
