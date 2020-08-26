Install(){
    echo "Welcome to KickASs ! "
    echo
    echo -n "Enter your name : "
    read name
    echo -n "Enter your editor of choice : "
    read editor
    echo "Creating config file"
    mkdir -p "$confdir"
    touch "$config"
    echo "name=\"$name\"" > "$config"
    echo "editor=\"$editor\"" >> "$config"
    echo "$configdir"
    sudo cp kickass.sh /usr/bin/kickass
    echo "Installed Sucessfully!"
    exit
}

sudoer=$(echo $SUDO_USER)
confdir="/home/$sudoer/.config/kickass"
config="$confdir/kickass.conf"

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root" 
    exit 1
fi

if [[ ! -e "$confdir" ]];then
    Install
else
    echo "you have already installed the script"
    echo -n "Do you want to reinstall ? (y/n) : "
    read inp
    if [[ "$inp" == 'y' ]];then
        Install
    else exit
    fi
fi
