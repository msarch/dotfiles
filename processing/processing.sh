#!/bin/bash          
APPNAME="Processing"
LATEST_TAR="processing-3.5.3-linux64.tgz"
DOWNLOAD_LINK="http://download.processing.org/$LATEST_TAR"
CONFIGDIR="$HOME/.processing"
# find MYDIR to refer to files relative to the directory of this script:
MYSELF="$(readlink -f "$0")"
MYDIR="${MYSELF%/*}"
DOTDIR="$MYDIR/dotfiles/home-dot-processing" # relative to this script
APPDIR="$MYDIR/apps/processing"


check () {
# check if we run as ROOT
if [ "$(id -nu)" != "root" ]; 
    then
    # we're not ROOT : ask for ROOT password
    echo -n "this script should be run as root: exiting..." 
    echo
    exit
fi
}


update () {

    # TO FINISH 

cd $HOME/Downloads
mkdir PSTMP
wget $DOWNLOAD_LINK 
# unzip the tarball
tar -xvzf $LATEST_TAR -C PSTMP/
#move to assets folder 

    # MOVE OLD VERSION of folder to folder.old

mv PSTMP/* $APPDIR/
rm $LATEST_TAR
rm -d PSTMP
echo 'removed downloaded archive'
}

do_install () {
check
#create a launcher file and input contents 
echo "[Desktop Entry]
Version=3.1.2
Name=Processing
Comment=Processing :) 
Exec=processing %F
Icon=$APPDIR/lib/icons/pde-256.png
Terminal=false
Type=Application
Categories=AudioVideo;Video;Graphics;Development" >  /usr/share/applications/processing.desktop

#create a mime type for .pde files. (might be an issue ith arduino too?) 
echo '<?xml version="1.0" encoding="UTF-8"?>
<mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">
<mime-type type="text/x-processing">
<comment>Processing PDE sketch file</comment>
<sub-class-of type="text/x-csrc"/>
<glob pattern="*.pde"/>
</mime-type>
</mime-info>' > /usr/share/mime/packages/processing.xml

update-mime-database /usr/share/mime
echo 'text/x-processing=processing.desktop' > /usr/share/applications/defaults.list
echo 'install complete'

#create exec link
ln -sf $APPDIR/processing /usr/local/bin/processing
}

configure () {
# link preferences file
# Test to see if pref exist
if [ -f $CONFIGDIR/preferences.txt ]; then
    mv $CONFIGDIR/preferences.txt $CONFIGDIR/preferences.old
    ln -s $DOTDIR/preferences.txt $CONFIGDIR/preferences.txt 
fi
}

ask () {
# DIALOG
read -p "update $APPNAME (y/n)?" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
    then
        update
        echo DONE
        echo
fi
echo
read -p "install $APPNAME (y/n)?" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
    then
        do_install
        configure
fi
}

ask
