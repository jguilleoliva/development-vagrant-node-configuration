#!/bin/bash
cd /tmp
#--- SETUP
echo "##--- UPDATE SYSTEM ---#"
apt-get -qq update
apt-get -y upgrade
echo "##--- END:UPDATE SYSTEM ---#"
echo "##--- CONFIGURE-TIMEZONE ---#"
sudo timedatectl set-timezone America/Guatemala
echo "##--- END:CONFIGURE-TIMEZONE ---#"
#--- !SETUP
echo "##--- ALL-DONE ---##"