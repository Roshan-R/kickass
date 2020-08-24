#!/bin/bash

Help(){
    echo
    echo "kickass - Make assignment latext files"
    echo
    echo "Syntax : kickass file.c"
    echo
    echo "file.c : C source code"
}

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

if [[ ! -e "$confdir" ]];then
    Install
fi

if [[ "$#" != 1 ]];then
    source "$config"
    echo "$name"
    echo $editor
    Help
    exit
fi

source="$1"


if [[ ! -e "$source" ]];then
    echo "Input an existing file"
    exit
else
    if [[ "$source" == *".c" ]];then
        base=$(basename $source .c )
        dirx="$base.x"
        if [[ -e "$dirx"  ]];then
            echo "A directoy named $dirx already exists!"
            echo "Remove and try again"
            echo "Exiting Script"
            exit
        fi
        echo
        echo "--Detected C Code--"
        echo
        mkdir $dirx
        cp $source "$dirx/"
        cp baseout.tex "$dirx/" 
        cd $dirx
        
        echo 
        echo "--Compiling code using gcc --"
        echo
        gcc "$source" -o "$base"
        echo 
        echo "--Compilation completed-- "
        echo 

        echo "--Opening bash for making output--"
        sleep 0.6
        echo "Press any key to continue.."
        read
        clear
        bash
        spectacle -b -r -o "$base.png"
        echo
        echo "--Created Screenshot sucessfully--"

        echo 
        echo "--Making .tex file--"
        echo

        code=$(cat "$source")
        (awk -v r="$code" '{gsub(/--CODE--/,r)}1' baseout.tex) > temp
        sed -i "s/--OUTPUT.png--/$base.png/g" temp
        algo=$(ctoalgo "$source")
        (awk -v r="$algo" '{gsub(/--ALGORITHM--/,r)}1' temp) > "$base.tex"
        rm temp
        rm baseout.tex

        echo
        echo -n "Do you want to edit the document? (y/n) : "
        read doc

        if [[ "$doc" == 'y' ]];then
            echo
            echo "--Opening VIM--"
            nvim "$base.tex"
        fi

        echo -n "Do you want to compile the pdf using pdflatex? (y/n) : "
        read inp
        if [[ "$inp" == 'y' ]];then
            pdflatex "$base.tex"
            echo "Created .pdf file sucessfully"
        fi

        
    fi
fi
