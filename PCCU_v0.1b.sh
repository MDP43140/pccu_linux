#!/bin/bash
# ==============================
#
#  PCCU By MDP43140.
#  Based on kali_cleaner by MasterButcher.
#
#  Linux Compatible.
#  Tested On Kali linux, And Linux Mint.
#
#  Ported Project
#  This Project Was Ported From PCCU For Windows.
#
#  Changelog:
#  v0.1:
#  - Clean Apt Cache.
#  - Empty Trash bin.
#  - Remove old kernel and old config.
#
# ==============================
clear
echo "============================================"
echo " PCCU v0.1"
echo "============================================"
OLDCONF=$(dpkg -l|grep "^rc"|awk '{print $2}')
CURKERNEL=$(uname -r|sed 's/-*[a-z]//g'|sed 's/-386//g')
LINUXPKG="linux-(image|headers|debian-modules|restricted-modules)"
METALINUXPKG="linux-(image|headers|restricted-modules)-(generic|i386|server|common|rt|xen)"
OLDKERNELS=$(dpkg -l|awk '{print $2}'|grep -E $LINUXPKG |grep -vE $METALINUXPKG|grep -v $CURKERNEL)
if [ $USER != root ]; then echo "Warning: Non-Root User, Error Could Be Happen."&fi
echo "PCCU: Fixing Apt Problems..."
sudo apt -f install
echo "PCCU: Cleaning apt cache..."
sudo apt autoremove
sudo apt autoclean
sudo apt clean
echo "PCCU: Removing old kernel and old config files..."
sudo apt purge $OLDCONF
sudo apt purge $OLDKERNELS
echo "Emptying trash..."
rm -rf /home/*/.local/share/Trash/*/** &> /dev/null
rm -rf /root/.local/share/Trash/*/** &> /dev/null
echo "PCCU: Finished!"
echo "============================================"