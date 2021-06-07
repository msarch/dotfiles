#!/bin/bash

UUID="c2e662f3-3258-4774-a3ff-549772473ff9"

echo 'please verify uuid of swap partition with : '
echo
echo '    sudo blkid'
echo
echo "you should modify this script if uuid is not : $UUID"

sudo echo "UUID=$UUID  none  swap  sw  0  0" > /etc/fstab

