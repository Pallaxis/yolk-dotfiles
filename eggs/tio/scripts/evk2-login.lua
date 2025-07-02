function shell_ready()
	expect("~]# ")
end

write("\n")

if expect("~]# ", 100) == 0 then
	write("\n")
	expect("login: ")
	write("root\n")
	shell_ready()
end
write("clear\n")
