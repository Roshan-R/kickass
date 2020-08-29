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
    cat "$config"
    cp baseout.tex "$confdir/baseout.tex"
    echo "Installed Sucessfully!"
    echo "To access kickass from anywhere, use sudo cp kickass.sh /usr/bin/kickass"
    exit
}

confdir="/home/$USER/.config/kickass"
echo $confdir
config="$confdir/kickass.conf"
echo $config

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
