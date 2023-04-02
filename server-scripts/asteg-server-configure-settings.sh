#!/bin/bash
#--- INSTALL-REQUIREMENTS
sudo apt install bat bytop libcap2-bin
#--- !INSTALL-REQUIREMENTS
#--- TERMINAL
echo "##--- CONFIGURE TERMINAL ---#"
sudo sed -i '/la/c\alias la="ls -lAhXG --color=always" \nalias cat=batcat' ~/.bashrc
source ~/.bashrc
echo "##--- END:CONFIGURE TERMINAL ---#"
#--- !TERMINAL
