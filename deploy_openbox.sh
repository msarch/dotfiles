#!/bin/bash

# debian / openbox post install script
# before running:
#     - verify paths
#     - comment / uncomment installations as needed




TMUX () {
    if [ -d "$TMUX_CONFIGDIR/" ]; # Check if $TMUX_CONFIGDIR exists.
    then
      echo "$TMUX_CONFIGDIR exists, it will be moved to $TMUX_CONFIGDIR.previous"
      mv "$TMUX_CONFIGDIR" "$TMUX_CONFIGDIR.previous"
    fi
    ln -s "$TMUX_DOTFILES" "$TMUX_CONFIGDIR"  # link dotfile dir to config dir
    }


DROPBOX () {
    apt install -y $APPS_DIR/dropbox/dropbox* && echo "installed : dropbox" >> ~/log  ||  echo "failed : dropbox" >> ~/log
    dropbox autostart y
    dropbox start -i
	}

# PROCESSING () #TODO

QCAD () { #TODO
    ln -sf $QCAD_DOTFILES/dot-config-QCAD/QCAD3.conf ~/.config/QCAD/
    sudo ln -sf $APPS_DIR/qcad/qcad /usr/local/bin/qcad
    sudo ln -sf $QCAD_DOTFILES/usr-share-applications/Qcad /usr/share/applications/Qcad
}


############################################################### DOTFILES
DOTFILES="~/Dropbox/dotfiles"
ln -sf $DOTFILES/dot/bashrc ~/.bashrc
ln -sf $DOTFILES/dot/profile ~/.profile
ln -sf $DOTFILES/dot/bash_aliases ~/.bash_aliases
ln -sf $DOTFILES/dot/bash_functions ~/.bash_functions
ln -sf $DOTFILES/dot/Xresources ~/.Xresources
ln -sf $DOTFILES/dot/Xresources_dark ~/.Xresources_dark
ln -sf $DOTFILES/dot/Xresources_light ~/.Xresources_light
ln -sf $DOTFILES/dot/Xresources_molokai ~/.Xresources_molokai

############################################################### HARDWARE
sudo apt install -y network-manager nm-tray
#TODO 
#hibernate ?
# BLUETOOTH USELESS FOR POP-OS
#sudo apt install -y blueman              # bluetooth
#sudo apt install -y bluetooth            # bluetooth
#sudo apt install -y bluez                # bluetooth
#sudo apt install -y bluez-tools          # bluetooth
#sudo apt install -y rfkill               # bluetooth

############################################################## BASE_APPS
# sudo apt install -y git    # should be done already 
sudo apt install -y ranger                                    # RANGER
ln -sf $DOTFILES/ranger/dot-config-ranger ~/.config/ranger    # RANGER config
sudo apt install -y tmux                                      # TMUX
ln -sf $DOTFILES/tmux/tmux.conf ~/.tmux.conf                   # TMUX config
sudo apt install -y vim                                       # VIM 
mkdir -p ~/.vim                                               # VIM config
ln -sf $DOTFILES/vim/dot-vim ~/.vim                      # VIM config
cd /usr/share/vim/vim81/colors/                               # VIM remove all colors except default.vim
sudo find . ! -name 'default.vim' -type f -exec rm -f {} +    # VIM config
sudo apt install -y ack                                       # VIM search
sudo apt install -y fonts-inconsolata                         # VIM font
sudo apt install -y wget 


############################################ DEV_UTILITIES
sudo apt install -y python-autopep8        # PYTHON
sudo apt install --assume-yes python3-pip  # PYTHON necessary for pyglet
pip3 install --user --upgrade pyglet       # pyglet (from PyPI)
sudo apt install -y dialog                 # CURSES etc...
sudo apt install -y libncurses5-dev        # CURSES etc...
sudo apt install -y libncursesw5-dev       # CURSES etc...
sudo apt install -y texlive-metapost       # METAPOST etc
sudo apt install -y context                # METAPOST etc
sudo apt install -y gifsicle               # METAPOST etc
sudo apt install --assume-yes ruby         #ASCIIDOC installs from ruby
gem_install asciidoc                       #ASCIIDOC
gem_install "asciidoctor-pdf --pre"  #ASCIIDOC
gem_install rouge        #ASCIIDOC
gem_install pygments.rb  #ASCIIDOC
gem_install coderay      #ASCIIDOC code highlighting


# utilities
sudo apt install -y gparted
sudo apt install -y rsync
sudo apt install -y w3m
sudo apt install -y w3m-img 
sudo apt install -y wkhtmltox            # html page to pdf conversion
youtube dl      TODO
youtube dl config TODO



################################## X11 APPS #############################
sudo apt install xorg                # install X11       
cp /etc/X11/xinit/xinitrc ~/.xinitrc # create user’s “~/.xinitrc” file

sudo apt installx11-xserver-utils     # install XRANDR
    
################################################# DESKTOP SETUP
sudo apt install -y pcmanfm                     # FILE BROWSERs
sudo apt-install -y file-roller
sudo apt install -y rofi
sudo apt install -y catfish                     # FILE SEARCH  
# ROFI config TODO
sudo apt install -y polybar 
# polybar config TODO
sudo apt install -y vim-gtk3
sudo apt install -y geany
ln -sf $DOTFILES/geany/           # TODO
sudo apt install -y jgmenu        # TODO
sudo apt install -y plank         # TODO
sudo apt install -y xfce4-terminal   # TODO

sudo apt install -y inkscape     #--------- GRAPHICS Vector editor
sudo apt install -y nomacs       #--------- GRAPHICS image viewer
sudo apt install -y krita        #--------- GRAPHICS Image editor
sudo apt install -y scribus      #--------- GRAPHICS Xpress like
# TODO QCAD                      #--------- GRAPHICS 2d cad
sudo apt install -y qbittorrent  #--------- INTERNET
# TODO skype
#sudo apt install -y lollypop    #--------- MEDIA music mp3 tagging
sudo apt install -y mcomix       #--------- MEDIA cbr comix reader
sudo apt install -y totem        #--------- MEDIA video streamer
sudo apt install -y codeblocks   #----------DEV code::blocks gui app

# clean
sudo apt upgrade -y --fix-missing
sudo apt autoremove -y


