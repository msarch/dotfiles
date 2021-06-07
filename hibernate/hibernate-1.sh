#!/bin/bash - 
#===============================================================================
#
#          FILE: hibernate.sh
# 
#         USAGE: ./hibernate.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 10/09/2020 21:19
#      REVISION:  ---
#===============================================================================


sudo fallocate -l 6G /swapfile # [N] = swapfile size in GB
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile


sudo echo "/swapfile none swap defaults 0 0" >> /etc/fstab
sudo swapoff -a
sudo cryptsetup remove cryptswap1
echo "edit /etc/fstab find and  comment the line mentioning cryptswap"
echo "type any key to edit /etc/fstab with vim, then save and quit..."
read key
sudo vim /etc/fstab
echo "done editing fstab"

echo "edit /etc/crypttab , comment the line mentioning cryptswap"
echo "type any key to edit /etc/crypttab with vim, save and quit"
read key
sudo vim /etc/crypttab
echo "done editing crypttab"

#sudo apt install kernelstub
#sudo kernelstub -a "resume=74351347-bacf-4bfe-a54e-d90a22b76157 resume_offset=6434816"


echo "change the line that says GRUB_CMDLINE_LINUX_DEFAULT= quiet splash"
echo "to : quiet splash resume UUID=74351347-bacf-4bfe-a54e-d90a22b76157"
sudo echo "GRUB_CMDLINE_LINUX_DEFAULT=\"quiet splash resume=UUID=74351347-bacf-4bfe-a54e-d90a22b76157\"" >> /etc/default/grub
read key
sudo vim /etc/default/grub

sudo echo "resume=UUID=74351347-bacf-4bfe-a54e-d90a22b76157" >> /etc/initramfs-tools/conf.d/resume 
sudo echo "resume_offset=6434816" >>  /etc/initramfs-tools/conf.d/resume
sudo update-initramfs -u
