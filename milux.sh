# this script will edit fstab to automount MILUX drive as ~/Milux
# it should NOT be run as root
# value of the 'milux_UUID' variable below
# should be verified and set manually before running
# with : > sudo blkid
# edited ; 15/10/2020 10:23:21

# milux_UUID="eab71441-e2c0-4cc4-9d3e-a0bf188c3af3"
milux_UUID="dae22eab-62be-4aa6-b794-b75be81041a4"
uuid_warning() {
    echo
    echo " ........................................."
    echo " List of all UUID"
    sudo blkid
    echo " ........................................."
    echo
    echo " ........................................."
    echo " Please check list of actual UUID's above "
    echo " Modify value of Milux UUID in this script"
    echo " if different from following value :      "
    echo " my value is :"
    echo $milux_UUID
    echo " ........................................."

    # DIALOG
    # display fstab, confirm before overwriting
    # restore old fstab if not confirmed
    read -p "do you need to modify this value ? (y/n)" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
        then
            echo "I quit, edit and run this script again"
            exit 0	
    fi
}


edit_fstab() {
    # we're not ROOT : ask for ROOT password
    echo -n "please type password for [sudo] : "
    read -s pass
    echo
    # we have root password
    # use of the sudo pass
    # the -S switch reads the password from STDIN:
    echo $pass | sudo -S echo 'ok'
    cp /etc/fstab ~/fstab.tmp
    echo $pass | sudo -S mv /etc/fstab /etc/fstab.bak
    echo "# Automount Milux at startup" >> ~/fstab.tmp
    echo "UUID=$milux_UUID /home/mi/Milux auto nosuid,nodev,nofail,x-gvfs-show 0 0" >> ~/fstab.tmp
    echo
    echo
    echo "verify file below :" #debug
    echo
    cat ~/fstab.tmp
    echo
    # DIALOG
    # display fstab, confirm before overwriting
    # restore old fstab if not confirmed
    read -p "write to /etc/fstab ? (y/n)" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
        then
            echo $pass | sudo -S mv ~/fstab.tmp /etc/fstab
            echo "DONE, please restart for change to take effect"
        else
            echo $pass | sudo -S mv /etc/fstab.bak /etc/fstab
            rm ~/fstab.tmp
            echo "ABANDONNED"
            exit 0
    fi
    }


checkroot () {
echo
echo "This script will edit fstab to mount Milux as '~/Milux" 
# check if we run as ROOT
if [ "$(id -nu)" = "root" ];
    then
        echo "* please run this script again as NON-root *"
        exit 0
fi
}


# -------------------------------------------------------
checkroot
uuid_warning
edit_fstab
