function uninstall
    sudo apt remove $argv && sudo apt autoremove && sudo apt autoclean
end