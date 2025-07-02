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

	write("tek_ota -D 3\n")
	shell_ready()

	write("tek_ota -d\n")

	expect("login: ")
end
