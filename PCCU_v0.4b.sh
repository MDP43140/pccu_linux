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
#  v0.2:
#  - GUI Added.
#  - Basic Option.
#  - Added Clean Tmp Folders.
#  - Added One-click Trigger.
#  - Added Apt autoremove And autoclean.
#  - Added Exit Support.
#
#  v0.3:
#  - Added Cleaning Old "Journal" Cache (Source: BleachBit).
#  - Added Color (based on People From Stack Overflow).
#  - Added Home Function (for Goto home Implementation).
#  - Added non case-sensitive for key input.
#
#  v0.4:
#  - Go to PCCU Home Instead of exit After Cleaning.
#  - Fixing bug that caused error pops up when choices is blank.
#  - Added Blank Input Alert If No Choices Selected.
#  - Added Swap Cache Cleaning Option.
#  - Added Some Color On 'Homescreen'.
#  - Added Flush DNS.
#
#  What Things Will Be Added (0.4):
#  - Adding More Cache Cleaning Option (Experimental)(
#    sync;echo $cleaninglevel > /proc/sys/vm/drop_caches
#      0:None.
#      1:Clear PageCache (recommended).
#      2:Clear dentries and inodes.
#      3:Clear Both (not recommended).
#  )
# ==============================

__COLOR_BLACK="\033[0;30m"
__COLOR_DGRAY="\033[1;30m"
__COLOR_RED="\033[0;31m"
__COLOR_LRED="\033[1;31m"
__COLOR_GREEN="\033[0;32m"
__COLOR_LGREEN="\033[1;32m"
__COLOR_BROWN="\033[0;33m"
__COLOR_YELLOW="\033[1;33m"
__COLOR_BLUE="\033[0;34m"
__COLOR_LBLUE="\033[1;34m"
__COLOR_PURPLE="\033[0;35m"
__COLOR_LPURPLE="\033[1;35m"
__COLOR_CYAN="\033[0;36m"
__COLOR_LCYAN="\033[1;36m"
__COLOR_LGRAY="\033[0;37m"
__COLOR_WHITE="\033[1;37m"
__COLOR_END="\033[0m"

clear
home(){
	echo -e $__COLOR_LBLUE"============================================"
	echo -e $__COLOR_LGREEN" PCCU v0.4"
	echo -e $__COLOR_LBLUE"============================================"
	if [ "$USER" != "root" ];then echo -e $__COLOR_RED"Warning: Non-Root User, Error Could Be Happen.";fi
	echo -e $__COLOR_YELLOW"[1] Clean Temporary Folders"
	echo "[2] Clean Apt Cache"
	echo "[3] Clean Apt Package List"
	echo "[4] Clean Old Journal Cache"
	echo "[5] Clear Bash History"
	echo "[6] Purge Old Kernel And Config"
	echo "[B] Empty Trash Bin"
	echo "[F] Fix Apt"
	echo "[S] Clear Swap Space"
	echo "[D] Flush DNS"
	echo "[C] Clear All Cache"
	echo -e $__COLOR_LGREEN"[U] Update System"
	echo -e $__COLOR_LRED"[X] Exit"$__COLOR_END
	read -n 1 -s CHOICES
	clear
	if [ "$CHOICES" != "X" ] || [ "$CHOICES" != "x" ];then
		echo -e $__COLOR_LBLUE"============================================"
		echo -e $__COLOR_YELLOW" PCCU v0.4"
		echo -e $__COLOR_LBLUE"============================================"$__COLOR_END
		OLDCONF=$(dpkg -l|grep "^rc"|awk '{print $2}')
		CURKERNEL=$(uname -r|sed 's/-*[a-z]//g'|sed 's/-386//g')
		LINUXPKG="linux-(image|headers|debian-modules|restricted-modules)"
		METALINUXPKG="linux-(image|headers|restricted-modules)-(generic|i386|server|common|rt|xen)"
		OLDKERNELS=$(dpkg -l|awk '{print $2}'|grep -E $LINUXPKG |grep -vE $METALINUXPKG|grep -v $CURKERNEL)
		if [ "$CHOICES" = "1" ];then
			echo -e $__COLOR_YELLOW"PCCU: Cleaning Temporary Folder..."$__COLOR_END
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
		if [ "$CHOICES" = "F" ] || [ "$CHOICES" = "f" ];then
			echo -e $__COLOR_YELLOW"PCCU: Fixing Apt Problems..."$__COLOR_END
			sudo apt -f install
			sudo aptitude -f install
		fi
		if [ "$CHOICES" = "2" ];then
			echo -e $__COLOR_YELLOW"PCCU: Cleaning Apt Cache..."$__COLOR_END
			sudo apt autoremove
			sudo apt autoclean
			sudo apt clean
		fi
		if [ "$CHOICES" = "3" ];then
			echo -e $__COLOR_YELLOW"PCCU: Cleaning Apt Package List..."$__COLOR_END
			sudo rm -rf /var/lib/apt/lists/*
		fi
		if [ "$CHOICES" = "4" ];then
			echo -e $__COLOR_YELLOW"PCCU: Cleaning Old Journal Cache..."$__COLOR_END
			sudo journalctl --vacuum-time=1
		fi
		if [ "$CHOICES" = "5" ];then
			echo -e $__COLOR_YELLOW"PCCU: Clearing Bash History..."$__COLOR_END
			sudo rm -rf /home/*/.bash_history
			sudo rm -rf /root/.bash_history
		fi
		if [ "$CHOICES" = "6" ];then
			echo -e $__COLOR_YELLOW"PCCU: Removing old kernel and old config files..."$__COLOR_END
			sudo apt purge $OLDCONF
			sudo apt purge $OLDKERNELS
		fi
		if [ "$CHOICES" = "B" ] || [ "$CHOICES" = "b" ];then
			echo -e $__COLOR_YELLOW"PCCU: Emptying trash..."$__COLOR_END
			rm -rf /home/*/.local/share/Trash/*/** &> /dev/null
			rm -rf /root/.local/share/Trash/*/** &> /dev/null
		fi
		if [ "$CHOICES" = "U" ] || [ "$CHOICES" = "u" ];then
			echo -e $__COLOR_YELLOW"PCCU: Downloading Updates..."$__COLOR_END
			sudo apt update
			echo -e $__COLOR_YELLOW"PCCU: Updating System..."$__COLOR_END
			sudo apt -y upgrade
			echo -e $__COLOR_YELLOW"PCCU: Cleaning Apt Cache..."$__COLOR_END
			sudo apt -y autoremove
			sudo apt autoclean
			sudo apt clean
		fi
		if [ "$CHOICES" = "S" ] || [ "$CHOICES" = "s" ];then
			echo -e $__COLOR_YELLOW"PCCU: Cleaning Swap Cache..."$__COLOR_END
			swapoff -a && swapon -a
		fi
		if [ "$CHOICES" = "D" ] || [ "$CHOICES" = "d" ];then
			echo -en $__COLOR_YELLOW"PCCU: systemd-resolved Status: "$__COLOR_END & sudo systemctl is-active systemd-resolved
			echo -e $__COLOR_YELLOW"PCCU: Flushing DNS..."$__COLOR_END
			sudo systemd-resolve --flush-caches
			sudo /etc/init.d/dns-clean restart
			sudo /etc/init.d/networking force-reload
			sudo /etc/init.d/nscd restart
			sudo /etc/init.d/dnsmasq restart
			sudo /etc/init.d/named restart
			sudo rndc restart
			sudo rndc exec
			sleep 10s
		fi
		if [ "$CHOICES" = "C" ] || [ "$CHOICES" = "c" ];then
			echo -e $__COLOR_YELLOW"PCCU: Cleaning Temporary Folder..."$__COLOR_END
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
			echo -e $__COLOR_YELLOW"PCCU: Fixing Apt Problems..."$__COLOR_END
			sudo apt -f install
			sudo aptitude -f install
			echo -e $__COLOR_YELLOW"PCCU: Cleaning apt cache..."$__COLOR_END
			sudo apt autoremove
			sudo apt autoclean
			sudo apt clean
			echo -e $__COLOR_YELLOW"PCCU: Removing old kernel and old config files..."$__COLOR_END
			sudo apt purge $OLDCONF
			sudo apt purge $OLDKERNELS
			echo -e $__COLOR_YELLOW"PCCU: Emptying trash..."$__COLOR_END
			rm -rf /home/*/.local/share/Trash/*/** &> /dev/null
			rm -rf /root/.local/share/Trash/*/** &> /dev/null
		fi

		if [ "$CHOICES" = "X" ] || [ "$CHOICES" = "x" ];then
			clear
			exit 0
		fi
		if [ "$CHOICES" = "" ];then
			echo -e $__COLOR_LRED"Input Can't Be Empty"$__COLOR_END
			sleep 1s
		fi
	fi
	clear
	home
}
home
exit 0