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
    echo "execute the Install script before this !"
    echo
    exit
}

confdir="/home/$USER/.config/kickass"
config="$confdir/kickass.conf"
baseout="$confdir/baseout.tex"

if [[ ! -e "$config" ]];then
    Install
fi

if [[ "$#" < 1 ]];then
    Help
    exit
fi

source="${@: -1}"
optstring=":S"
screenshot=1

while getopts ${optstring} arg; do
    case "${arg}" in
        S)  echo "No Screenshot called" 
            screenshot=0 ;;
        #?)
            #echo "Invalid option: -${OPTARG}."
            #echo
            #usage
            #;;
    esac
done


if [[ ! -e "$source" ]];then
    echo "Input an existing file"
    exit
else
    source "$config"
    if [[ -d "$source" ]];then
        echo "This is a directoy"
    fi
    if [[ "$source" == *".c" ]];then
        base=$(basename $source .c )
        dirx="$base.x"
        if [[ -e "$dirx"  ]];then
            echo "A directoy named $dirx already exists!"
            echo "Remove the directory and try again"
            echo "Exiting Script"
            exit
        fi
        echo
        echo "--Detected C Code--"
        echo
        mkdir $dirx
        cp $source "$dirx/"
        cp "$baseout" "$dirx/" 
        cd $dirx
        
        echo 
        echo "--Compiling code using gcc --"
        echo
        gcc "$source" -o "$base"
        echo 
        echo "--Compilation completed-- "
        echo 
        if [[ $screenshot == 1 ]];then
            echo "--Opening bash for making output--"
            sleep 0.6
            echo "Press any key to continue.."
            read
            clear
            bash
            maim -s "$base.png"
            #spectacle -s -b -n -r -o "$base.png"
            echo
            echo "--Created Screenshot sucessfully--"
        fi;

        echo 
        echo "--Making .tex file--"
        echo

        #Substituing code 
        code=$(cat "$source")
        (awk -v r="$code" '{gsub(/--CODE--/,r)}1' baseout.tex) > temp

        #Substituing Screenshot 
        sed -i "s/--OUTPUT.png--/$base.png/g" temp
        algo=$(ctoalgo "$source")

        #Substituing Algorithm 
        (awk -v r="$algo" '{gsub(/--ALGORITHM--/,r)}1' temp) > "$base.tex"

        #Substituing Name 
        sed -i "s/--NAME--/$name/g" "$base.tex" 
        
        #Replacing NULL
        sed -i "s/\x00/NULL/g" "$base.tex"



        #cleaning temp files
        rm temp
        rm baseout.tex

        echo
        echo -n "Do you want to edit the document? (y/n) : "
        read doc

        if [[ "$doc" == 'y' ]];then
            echo
            echo "--Opening $editor --"
            sleep 0.6
            $editor "$base.tex"
        fi

        echo -n "Do you want to compile the pdf using pdflatex? (y/n) : "
        read inp
        if [[ "$inp" == 'y' ]];then
            pdflatex "$base.tex"
            echo "Created .pdf file sucessfully"
        fi

        
    fi
fi
