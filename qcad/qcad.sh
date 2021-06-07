#!/bin/bash


APPNAME="qcad"   # binary's name
DESKTOPDIR="/usr/share/applications/"   # desktop files dir
# find MYDIR to refer to files relative to the directory of this script:
MYSELF="$(readlink -f "$0")"
MYDIR="${MYSELF%/*}"
MYDESKTOPFILE="$MYDIR/usr-share-applications/Qcad" # My desktop file
MYEXE="$MYDIR/usr-local-bin/qcad" # startup script

install () {
# app should be located : ./assets/apps/qcad
cd $MYDIR
cd ..
cd ..
cd assets/apps/qcad
if [ -f $APPNAME ]; then
    echo "$APPNAME present"
    echo
    # link dotfile dir to config dir
    sudo ln -sf $MYDESKTOPFILE $DESKTOPDIR 
    sudo chown mi $DESKTOPDIR
    sudo ln -sf $MYEXE /usr/local/bin/qcad
else
    echo "$APPNAME NOT FOUND in assets/apps/qcad"
    echo "exiting..."
    echo
fi
}


configure () {
echo
}


ask () {
# DIALOG
read -p "install $APPNAME (y/n)?" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
    then
        install
fi
read -p "configure $APPNAME (y/n)?" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
    then
        configure
        echo DONE
        echo
fi
}

ask

