# Set environment variables (available to all sessions)
set -gx EDITOR nvim

if status is-interactive
    set -g fish_greeting

    # Init Starship prompt
    starship init fish | source

    # Welcome screen
    fastfetch
end
