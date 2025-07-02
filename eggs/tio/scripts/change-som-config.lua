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
	write(
		'grep -q "^vm.admin_reserve_kbytes=" /etc/sysctl.d/ambarella.conf && sed -i "s/^vm.admin_reserve_kbytes=.*/vm.admin_reserve_kbytes=512/g" /etc/sysctl.d/ambarella.conf || echo "vm.admin_reserve_kbytes=512" >> /etc/sysctl.d/ambarella.conf && cat /etc/sysctl.d/ambarella.conf\n'
	)
	shell_ready()
	write("reboot\n")

	expect("login: ")
	write("root\n")
	shell_ready()
	write("sysctl vm.admin_reserve_kbytes\n")

	expect("login: ")
end
