#!/bin/bash
#--- NODE-VERSION-MANAGER
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
source ~/.nvm/nvm.sh
nvm install node
#--- !NODE-VERSION-MANAGER

# Disable ipv6 built-in kernel module.
#
# 1. Edit /etc/default/grub and append ipv6.disable=1 to GRUB_CMDLINE_LINUX and GRUB_CMDLINE_LINUX_DEFAULT like the following sample:
# FROM:
#   GRUB_CMDLINE_LINUX_DEFAULT=""
#   GRUB_CMDLINE_LINUX=""
# TO:
#   GRUB_CMDLINE_LINUX_DEFAULT="ipv6.disable=1"
#   GRUB_CMDLINE_LINUX="ipv6.disable=1"
#
# 2. Run the update-grub command to regenerate the grub.cfg file:
#   update-grub
# 3. Reboot the system to disable IPv6 support.
