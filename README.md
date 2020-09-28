# kickass
*the one step C assignment maker*

KickAss takes your C source code, compiles the code, executes it, takes a screenshot, converts C to Alogrithmish format and generates a .tex file
which can be used to generate a .pdf file.

# Demo

![](demo.gif)

# Installation

run the installation script 
```bash
./install.sh
sudo cp kickass.sh /usr/bin/kickass
```
this will install kickass to `/usr/bin`.

## Dependencies

For converting C code to Algorithm format, make sure you have installed [ctoalgo](https://github.com/Roshan-R/ctoalgo).

For converting .tex files to .pdf format, make sure you have these packages installed 

`texlive-core texlive-formatsextra texlive-latexextra texlive-pictures texlive-science`

and for screenshot, install `maim`




