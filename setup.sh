#!/bin/bash

check_dependencies(){
    #Declare list of dependencies
    declare -Ag deps=(
        [tmux]='tmux'
    )

    #Declare list of package managers and their usages
    declare -Ag packman_list=(
        [pacman]='sudo pacman -Sy'
        [apt]='sudo apt update -yqq; sudo apt install -yqq 2>/dev/null'
        [yum]='yum install -y epel-release; yum repolist -y; yum install -y')

    #Find the package manager on the system and install the package
    install_deps(){
        for packman in ${!packman_list[@]}
        do
            which $packman &>/dev/null && eval $(echo ${packman_list[$packman]} "$*")
        done
    }

    #Find the missing packages from list of dependencies
    declare -ag missing_deps=()
    for pack in ${!deps[@]}
    do
        which $pack &>/dev/null || missing_deps+=(${deps[$pack]})
    done

    #Install missing dependencies
    test -z ${missing_deps[0]} || install_deps ${missing_deps[@]} || fail "Dependencies could not provide"
}

setup_vim(){
	if [ ! -f ~/.vim/autoload/plug.vim ]
	then 
		echo Installing plug.vim
		mkdir -p ~/.vim/autoload && curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	fi
}

check_dependencies
setup_vim
find $PWD/confs -maxdepth 1 -type f -exec ln -sf {} $HOME/ \;
