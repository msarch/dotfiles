#!/bin/bash - 



# find MYDIR to refer to files under the same directory of this script: 
MYSELF="$(readlink -f "$0")"
MYDIR="${MYSELF%/*}"
# use also symbolic home folder
# ln -s $MYDIR/dot-files/test ~/.test 
ln -s $MYDIR/music/RADIO.m3u ~/Music/
ln -s $MYDIR/dot-moc ~/.moc 
