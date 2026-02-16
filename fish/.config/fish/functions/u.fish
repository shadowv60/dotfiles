function u --wraps='sudo pacman -Rns' --description 'alias u=sudo pacman -Rns'
    sudo pacman -Rns $argv
end
