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
    echo "name=\"$name\"" >> "$config"
    echo "editor=\"$editor\"" >> "$config"
    echo "Done sucessfully"
    echo "Reload the script.."
    exit
}

confdir="/home/$USER/.config/kickass"
config="$confdir/kickass.conf"

Install
