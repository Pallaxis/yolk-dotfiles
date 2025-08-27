function Shell_Ready()
	tio.expect("~]# ")
end

tio.write("\n")

while true do
	if not tio.expect("~]# ", 100) then
		tio.write("\n")
		tio.expect("login: ")
		tio.write("root\n")
		Shell_Ready()
	end
	--tio.write([[echo -e "\e[33mProbe status: $(x cert probe 2>&1 | awk '/status_text/ {print $2}')\e[0m"]])
	--tio.write("\n")

	--tio.write([[echo -e "\e[33mVerify status: $(x cert verify 2>&1 | awk '/status_text/ {print $2}')\e[0m"]])
	--tio.write("\n")

	--tio.write([[echo -e "\e[33mManifest status: $(x manifest 2>&1 | awk '/status_text/ {print $2}')\e[0m"]])
	--tio.write("\n")

	tio.write("tek_ota --bootloader-version\n")
	tio.write("oclea_info\n")
	tio.write("rm .bash_history\n")

	tio.expect("login: ")
end
