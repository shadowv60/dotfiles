function smci --wraps='sudo make clean install' --description 'alias smci=sudo make clean install'
    sudo make clean install $argv
end
