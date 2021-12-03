function man
	command mman $argv | ul | sed 's/\[1m/\[1;34m/gi' | less -R
end
