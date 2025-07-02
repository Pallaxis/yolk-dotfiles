function shell_ready()
	expect("~]# ")
end

write("\n")

while true do
	if expect("~]# ", 100) == 0 then
		write("\n")
		expect("login: ")
		write("root\n")
		shell_ready()
	end
	write("clear\n")

	write("oclea_gstreamer_interactive_example -r\n")

	expect("login: ")
end
