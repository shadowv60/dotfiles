if status is-interactive	
    set -g fish_greeting
    starship init fish | source
    # This runs fastfetch every time a new shell starts
    fastfetch
end
