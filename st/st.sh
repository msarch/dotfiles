#!/bin/bash - 



# find MYDIR to refer to files under the same directory of this script: 
MYSELF="$(readlink -f "$0")"
MYDIR="${MYSELF%/*}"
# use also symbolic home folder
# ln -s $MYDIR/dot-files/test ~/.test 
ln -s $MYDIR/assets/st/st.desktop /usr/share/applications
