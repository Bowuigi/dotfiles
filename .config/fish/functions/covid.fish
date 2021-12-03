function covid
	curl -s "https://corona-stats.online/$argv[1]" | less -SR
end
