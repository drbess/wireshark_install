#!/bin/bash

#
# Source: https://computingforgeeks.com/how-to-install-wireshark-on-ubuntu-desktop/
#
# This script installs wireshark
# Check to see if user is root
echo " Are you root? Checking now"
echo
echo "Ok doing something in the background ##################################### "
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi
echo " #################################################################################################################################################"
add-apt-repository ppa:wireshark-dev/stable
echo
apt update
echo
apt -y install wireshark
echo " ################################################################################################################################################# "
add-apt-repository ppa:dreibh/ppa
echo
apt update
wait
apt -y install wireshark
# To be able to capture packets as a normal user, add your user to the wireshark group
usermod -a -G wireshark $USER
echo
echo "Changing dumpcap binary file perm..... "
# Change dumpcap binary file permissions
chgrp wireshark /usr/bin/dumpcap
echo
chmod 750 /usr/bin/dumpcap
echo
setcap cap_net_raw,cap_net_admin=eip /usr/bin/dumpcap
echo
echo "Let's verify dumcap..... "
# Verify
sudo getcap /usr/bin/dumpcap
wait
apt autoclean
echo "Done"
