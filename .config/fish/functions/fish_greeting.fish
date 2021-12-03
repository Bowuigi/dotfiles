function fish_greeting
	echo -e "Calendar:\n"
	ncal -Mb
	# echo -e "\nWeather report for today:\n"
	# curl wttr.in 2> /dev/null | awk 'NR==3 || NR==4 || NR==5 || NR==6 || NR==7'
	echo -e "Todo list:\n"
	stask ~/tasks.st
	echo -e "\nWelcome to fish!"
end
