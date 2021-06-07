# this script will edit fstab to automount this drive as ~/Milux
# 15/06/2020 10:23:21


install() {
    # we have root password
    cd /etc

    echo "doing it" #debug
    milux_UUID="eab71441-e2c0-4cc4-9d3e-a0bf188c3af3"
    #cp fstab ~/fstab.tmp
    #echo $pass | sudo -S mv fstab fstab.bak
    #echo "# Automount Milux at startup" >> ~/fstab.tmp
    #echo "UUID=$milux_UUID /home/mi/Milux auto nosuid,nodev,nofail,x-gvfs-show 0 0" >> ~/fstab.tmp

    echo
    echo
    echo " List of all UUID"
    echo " ........................................."
    sudo blkid
    echo
    echo
    echo " Please check new fstab before overwriting"
    echo " Modify this script if necessary"
    echo " ........................................."
    echo
    
    echo "cat ~/fstab.tmp" #debug
    #cat ~/fstab.tmp
    echo
    echo


    # DIALOG
    # display fstab, confirm before overwriting
    # restore old fstab if not confirmed
    read -p "write (y/n)?" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
        then
            #echo $pass | sudo -S mv ~/fstab.tmp fstab
            echo "DONE, please restart for change to take effect"
        else
            #echo $pass | sudo -S mv fstab.bak fstab
            #rm ~/fstab.tmp
            echo "ABANDONNED"
            exit 0
    fi
    }


checkroot () {
# check if we run as ROOT
if [ "$(id -nu)" != "root" ];
    then
        # we're not ROOT : ask for ROOT password
        echo -n "password for [sudo] : "
        read -s pass
        echo
        # use of the sudo pass
        # the -S switch reads the password from STDIN:
        echo $pass | sudo -S echo 'ok'
        # TODO : stop here if wrong password
        install
    else
        echo " please run this script as NON-root"
        exit 0
fi
}


ask () {
# DIALOG
read -p "edit fstab to mount Milux as '~/Milux' at startup (y/n)?" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
    then
        checkroot
    else
        echo "ABANDONNED"
        exit 0
fi
}

ask
