function i --wraps='sudo pacman -Syu' --description 'alias i=sudo pacman -Syu'
    sudo pacman -Syu $argv
end
