#!/bin/bash
# play1.sh
# Plays music files
# Invoke this script with several arguments".

E_BADARGS=65

if [ ! -n "$1" ]
then
  echo "Usage: `basename $0` argument1 argument2 etc."
  exit $E_BADARGS
fi  
echo ""
index=1          # Initialize count.

for arg in "$@"
do
  echo "resizing #$index = $arg"
  echo ""
  sips -Z 640 "$arg"
# afplay "$1" &  # & permet de fermer la fenetre shell sans quitter afplay 

  let "index+=1"
done            
