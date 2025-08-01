function Shell_Ready()
	expect("~]# ")
end

write("\n")

while true do
	if expect("~]# ", 100) == 0 then
		write("\n")
		expect("login: ")
		write("root\n")
		Shell_Ready()
	end
	--write([[echo -e "\e[33mProbe status: $(x cert probe 2>&1 | awk '/status_text/ {print $2}')\e[0m"]])
	--write("\n")

	--write([[echo -e "\e[33mVerify status: $(x cert verify 2>&1 | awk '/status_text/ {print $2}')\e[0m"]])
	--write("\n")

	--write([[echo -e "\e[33mManifest status: $(x manifest 2>&1 | awk '/status_text/ {print $2}')\e[0m"]])
	--write("\n")

	write("tek_ota --bootloader-version\n")
	write("oclea_info\n")
	write("rm .bash_history\n")

	expect("login: ")
end
