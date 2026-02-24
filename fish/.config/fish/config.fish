# Set environment variables (available to all sessions)
set -gx EDITOR nvim
set -gx PATH $HOME/.local/bin $PATH

if status is-interactive
    set -g fish_greeting

    # Init Starship prompt
    #starship init fish | source

    # Welcome screen
    fastfetch
end

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv fish)"
