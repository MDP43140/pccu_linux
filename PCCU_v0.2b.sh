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
#  v0.2:
#  - GUI Added.
#  - Basic Option.
#  - Added Clean Tmp Folders (beta, not working, still needs feedback about temp folders to clean)
#  - Added One-click Trigger.
#  - Added Exit Support.
#  - Added Apt autoremove And autoclean.
#
# ==============================
clear
echo "============================================"
echo " PCCU v0.2"
echo "============================================"
if [ $USER != root ]; then echo "Warning: Non-Root User, Error Could Be Happen."&fi
echo "[1] Clean Temporary Folders"
echo "[2] Clean Apt Cache"
echo "[3] Clean Apt Package List"
echo "[4] Clear Bash History"
echo "[5] Purge Old Kernel And Config"
echo "[B] Empty Trash Bin"
echo "[F] Fix Apt"
echo "[C] Clear All Cache"
echo "[X] Exit"
read -n 1 -s CHOICES
clear
if [ $CHOICES = X ];then exit 0&fi
OLDCONF=$(dpkg -l|grep "^rc"|awk '{print $2}')
CURKERNEL=$(uname -r|sed 's/-*[a-z]//g'|sed 's/-386//g')
LINUXPKG="linux-(image|headers|debian-modules|restricted-modules)"
METALINUXPKG="linux-(image|headers|restricted-modules)-(generic|i386|server|common|rt|xen)"
OLDKERNELS=$(dpkg -l|awk '{print $2}'|grep -E $LINUXPKG |grep -vE $METALINUXPKG|grep -v $CURKERNEL)

if [ $CHOICES = 1 ];then
	echo "PCCU: Cleaning Temporary Folder..."
	rm -rf /root/.cache/
	rm -rf /root/.thumbnails/
	rm -rf /root/.xsession-errors
	rm -rf /root/.xsession-errors.old
	rm -rf /home/*/.cache/
	rm -rf /home/*/.thumbnails/
	rm -rf /home/*/.xsession-errors
	rm -rf /home/*/.xsession-errors.old
	rm -rf /var/log/*
	rm -rf /var/tmp/*
fi
if [ $CHOICES = F ];then
	echo "PCCU: Fixing Apt Problems..."
	sudo apt -f install
	sudo aptitude -f install
fi
if [ $CHOICES = 2 ];then
	echo "PCCU: Cleaning Apt Cache..."
	sudo apt autoremove
	sudo apt autoclean
	sudo apt clean
fi
if [ $CHOICES = 3 ];then
	echo "PCCU: Cleaning Apt Package List..."
	sudo rm -rf /var/lib/apt/lists/*
fi
if [ $CHOICES = 4 ];then
	echo "PCCU: Clearing Bash History..."
	sudo rm -rf /home/*/.bash_history
	sudo rm -rf /root/.bash_history
fi
if [ $CHOICES = 5 ];then
	echo "PCCU: Removing old kernel and old config files..."
	sudo apt purge $OLDCONF
	sudo apt purge $OLDKERNELS
fi
if [ $CHOICES = B ];then
	echo "PCCU: Emptying trash..."
	rm -rf /home/*/.local/share/Trash/*/** &> /dev/null
	rm -rf /root/.local/share/Trash/*/** &> /dev/null
fi
if [ $CHOICES = C ];then
	echo "PCCU: Cleaning Temporary Folder..."
	rm -rf /root/.cache/
	rm -rf /root/.thumbnails/
	rm -rf /root/.xsession-errors
	rm -rf /root/.xsession-errors.old
	rm -rf /home/*/.cache/
	rm -rf /home/*/.thumbnails/
	rm -rf /home/*/.xsession-errors
	rm -rf /home/*/.xsession-errors.old
	rm -rf /var/log/*
	rm -rf /var/tmp/*
	echo "PCCU: Fixing Apt Problems..."
	sudo apt -f install
	sudo aptitude -f install
	echo "PCCU: Cleaning apt cache..."
	sudo apt autoremove
	sudo apt autoclean
	sudo apt clean
	echo "PCCU: Removing old kernel and old config files..."
	sudo apt purge $OLDCONF
	sudo apt purge $OLDKERNELS
	echo "PCCU: Emptying trash..."
	rm -rf /home/*/.local/share/Trash/*/** &> /dev/null
	rm -rf /root/.local/share/Trash/*/** &> /dev/null
fi
echo "PCCU: Finished"
echo "============================================"