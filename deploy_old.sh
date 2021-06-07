#!/bin/bash

# pop_os post install script
# before running:
#     - verify paths
#     - comment / uncomment installations as needed

################################################################################
#                                   functions                                  #
################################################################################

apt_install () {  # Test to see if app is installed, (arg = package name)
    echo "***"
    if [ -f /bin/$1 -o -f /usr/bin/$1 ]; then
        echo "already installed : $1" >> ~/log
    else
        sudo apt install --assume-yes $1 && echo "installed : $1" >> ~/log  ||  echo "failed : $1" >> ~/log
    fi
    }


gem_install () {
    echo "***"
    if [ -f /bin/ruby -o -f /usr/bin/ruby ]; then
       echo "ruby is already installed" >> ~/log
    else
        sudo apt install --assume-yes ruby && echo "installed : ruby" >> ~/log  ||  echo "failed : ruby" >> ~/log
    fi
    sudo gem install $1 && echo "installed : $1" >> ~/log  ||  echo "failed : $1" >> ~/log
}


pip_install () {
    echo "***"
    if [ -f /bin/pip3 -o -f /usr/bin/pip3 ]; then
       echo "pip3 is already installed" >> ~/log
    else
        sudo apt install --assume-yes python3-pip && echo "installed : pip" >> ~/log  ||  echo "failed : pip" >> ~/log
    fi
    pip3 install --user --upgrade $1 && echo "installed : $1" >> ~/log  ||  echo "failed : $1" >> ~/log

}


system_setup () {
    echo "*** system setup"
    #TODO ./dconf.sh
    #TODO ./hibernate.sh
    # disable middle button paste
    gsettings set org.gnome.desktop.interface gtk-enable-primary-paste false
    #apt_install gnome-tweaks
    # IF MATE CAJA FILE MANAGER
    #apt_install caja-extensions-common
    #apt_install caja-rename
    #apt_install caja-image-converter
    #apt_install caja-dropbox
    #apt_install caja-open-terminal
    #apt_install caja-admin
    #apt_install chrome-gnome-shell
    # BLUETOOTH USELESS FOR POP-OS
    #apt_install blueman              # bluetooth
    #apt_install bluetooth            # bluetooth
    #apt_install bluez                # bluetooth
    #apt_install bluez-tools          # bluetooth
    #apt_install rfkill               # bluetooth
    apt_install plank
    }


utilities () {
    echo "*** utilities"
    apt_install ack                  # search for vim
    apt_install feh
    apt_install fonts-inconsolata    # for vim
    apt_install gnome-disk-utility
    apt_install rsync
    apt_install w3m
    apt_install w3m-img 
    apt_install wkhtmltox            # html page to pdf conversion

    apt_install wget
    
    apt_install xsane
    }


base_apps () {
    echo "*** base apps"
    apt_install mpv
    #TODO ./mpv.sh
    apt_install vim-gtk3
    apt_install ranger
    apt_install scite
    apt_install tmux
    #TODO ./ncmpcpp.sh
    }


link_dotfiles () {
    ln -sf $HOME_DOTFILES/bashrc ~/.bashrc
    ln -sf $HOME_DOTFILES/profile ~/.profile
    ln -sf $HOME_DOTFILES/bash_aliases ~/.bash_aliases
    ln -sf $HOME_DOTFILES/bash_functions ~/.bash_functions
    ln -sf $HOME_DOTFILES/Xresources ~/.Xresources
    ln -sf $HOME_DOTFILES/SciTE.session ~/.SciTE.session
    ln -sf $HOME_DOTFILES/SciTEUser.properties ~/.SciTEUser.properties
    ln -sf $HOME_DOTFILES/Xresources_dark ~/.Xresources_dark
    ln -sf $HOME_DOTFILES/Xresources_light ~/.Xresources_light
    ln -sf $HOME_DOTFILES/Xresources_molokai ~/.Xresources_molokai
    echo "done symlinks to home dotfiles"
    echo "symlinks : home dotfiles" >> ~/log
    }


gui_apps () {
    apt_install inkscape     #--------- GRAPHICS
    apt_install nomacs       #--------- GRAPHICS
    apt_install krita        #--------- GRAPHICS
    apt_install scribus      #--------- GRAPHICS
    #TODO ./qcad.sh          #--------- GRAPHICS
    apt_install qbittorrent  #--------- INTERNET
    #apt_install clementine  #--------- MEDIA music mp3 tagging
    apt_install mcomix       #--------- MEDIA cbr comix reader
    apt_install totem        #--------- MEDIA video streamer
    #TODO SKYPE
    }


dev_utilities () {
    apt_install astyle
    apt_install bcpp
    apt_install codeblocks       #code::blocks gui app
    apt_install dialog
    apt_install git-core
    apt_install libncurses5-dev  #ncurses
    apt_install libncursesw5-dev #ncurses
    apt_install python-autopep8
    # METAPOST etc
    apt_install texlive-metapost
    apt_install context
    apt_install gifsicle
    # pyglet is installable from PyPI:
    pip_install pyglet

    #ASCIIDOC is installable from ruby
    gem_install asciidoc
    gem_install "asciidoctor-pdf --pre"
    gem_install rouge
    gem_install pygments.rb
    gem_install coderay  #code highlighting for asciidoc
    }


configure_vim () {
    if [ -d "$VIM_CONFIGDIR" -o -L "$VIM_CONFIGDIR" ]; # Check if ~/.vim exists.
    then
      echo "$VIM_CONFIGDIR directory exists, it will be moved to $VIM_CONFIGDIR.previous"
      mv "$VIM_CONFIGDIR" "$VIM_CONFIGDIR.previous"
    fi
    ln -s "$VIM_DOTFILES" "$VIM_CONFIGDIR"  # symlink dotfile dir to config dir
    cd /usr/share/vim/vim81/colors/   #remove all other colors except default.vim
    sudo find . ! -name 'default.vim' -type f -exec rm -f {} +
    }


configure_tmux () {
    if [ -d "$TMUX_CONFIGDIR/" ]; # Check if $TMUX_CONFIGDIR exists.
    then
      echo "$TMUX_CONFIGDIR exists, it will be moved to $TMUX_CONFIGDIR.previous"
      mv "$TMUX_CONFIGDIR" "$TMUX_CONFIGDIR.previous"
    fi
    ln -s "$TMUX_DOTFILES" "$TMUX_CONFIGDIR"  # link dotfile dir to config dir
    ln -sf $HOME_DOTFILES/tmux.conf ~/.tmux.conf 
    }


configure_mpv () {
    if [ -d "$MPV_CONFIGDIR/" ]; # Check if $MPV_CONFIGDIR exists.
    then
      echo "$MPV_CONFIGDIR exists, it will be moved to $MPV_CONFIGDIR.previous"
      mv "$MPV_CONFIGDIR" "$MPV_CONFIGDIR.previous"
    fi
    ln -s "$MPV_DOTFILES" "$MPV_CONFIGDIR"  # link dotfile dir to config dir
    }


configure_ranger () {
    if [ -d "$RANGER_CONFIGDIR/" ]; # Check if $RANGER_CONFIGDIR exists.
    then
      echo "$RANGER_CONFIGDIR exists, it will be moved to $RANGER_CONFIGDIR.previous"
      mv "$RANGER_CONFIGDIR" "$RANGER_CONFIGDIR.previous"
    fi
    ln -s "$RANGER_DOTFILES" "$RANGER_CONFIGDIR"  # link dotfile dir to config dir
    }


package_DROPBOX () {
    apt install -y $APPS_DIR/dropbox/dropbox* && echo "installed : dropbox" >> ~/log  ||  echo "failed : dropbox" >> ~/log
    dropbox autostart y
    dropbox start -i
	}




#package_PROCESSING #TODO

package_QCAD () { #TODO
    ln -sf $QCAD_DOTFILES/dot-config-QCAD/QCAD3.conf ~/.config/QCAD/
    sudo ln -sf $APPS_DIR/qcad/qcad /usr/local/bin/qcad
    sudo ln -sf $QCAD_DOTFILES/usr-share-applications/Qcad /usr/share/applications/Qcad
}

package_SUBLIME () {	
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
	sudo apt update
	sudo apt install sublime-text
}

################################################################################
#                                  variables                                   #
################################################################################

# NO SPACE around the EQUAL SIGN
# applications config directories
VIM_CONFIGDIR="$HOME/.vim"                # vim will look into this dir
TMUX_CONFIGDIR="$HOME/.config/tmux"       # tmux will look into this dir
RANGER_CONFIGDIR="$HOME/.config/ranger"   # ranger will look into this dir
MPV_CONFIGDIR="$HOME/.config/mpv"         # mpv will look into this dir
QCAD_CONFIGDIR="$HOME/.config/QCAD"       # QCAD will look into this dir
# find MYDIR to refer to paths relative to this script:
MYSELF="$(readlink -f "$0")"
MYDIR="${MYSELF%/*}"
APPS_DIR="$MYDIR/apps"
HOME_DOTFILES="$MYDIR/dotfiles/dotfiles"
MPV_DOTFILES="$MYDIR/dotfiles/dot-config-mpv"
QCAD_DOTFILES="$MYDIR/dotfiles/qcad"
RANGER_DOTFILES="$MYDIR/dotfiles/dot-config-ranger"
TMUX_DOTFILES="$MYDIR/dotfiles/dot-config-tmux"
VIM_DOTFILES="$MYDIR/dotfiles/dot-vim"


################################################################################
#                                  deploy                                      #
################################################################################

sudo apt update -y
touch ~/log
#
system_setup
base_apps
#package_DROPBOX
utilities
configure_vim
configure_ranger
configure_tmux
configure_mpv
link_dotfiles
gui_apps
dev_utilities
package_SUBLIME
#
sudo apt upgrade -y --fix-missing
#
cat ~/log
rm ~/log
