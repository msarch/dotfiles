#!/bin/bash

# MOUNTING MILUX
echo :: mounting Milux ...
mkdir $HOME/Milux
sudo mount /dev/sda3 $HOME/Milux
sudo chown mi $HOME/Milux
echo :: ok

