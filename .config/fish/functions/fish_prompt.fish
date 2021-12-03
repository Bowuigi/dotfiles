function fish_prompt
    set_color cyan
    echo -n "Mateo"
    set_color green
    echo -n "@"
    echo -n (hostname)" "
    set_color cyan
    echo -n (prompt_pwd)
    echo -n " >"
end