#!/bin/bash

#This is a lazy script I have for auto-installing Arch.

#checking network conection and dialog installation
pacman -S --noconfirm dialog || (echo "Error at script start: Are you sure you're running this as the root user? Are you sure you have an internet connection?" && exit)
#warning and info message
dialog --defaultno --title "Welcome to kuroArch" --yesno "This is an Arch install script that is very rough around the edges.\n\nOnly run this script if you're a big-brane.\n\nThis script is for me, but you can use it and modify it as you want.\n\nt. Kai"  15 60 || exit
#save the hostname
dialog --no-cancel --inputbox "Enter a name for your computer.(hostname, not user name)" 10 60 2> comp
#enable ntp
timedatectl set-ntp true
#define some functions
function finalreboot() { umount -R /mnt && swapoff /dev/sda2 && reboot ;}
#formatting and mounting partitions and create needed directories
#formatting boot as fat32 mounted at /mnt/boot
#formatting swap as swap and enable swap
#formattingroot as ext4 mounted at /mnt
#formatting home as ext4 mounted at /mnt/home
mkfs.ext4 /dev/sda4
mkfs.ext4 /dev/sda3
mkfs.fat -F32 /dev/sda1
mkswap /dev/sda2
swapon /dev/sda2
mount /dev/sda3 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
mkdir /mnt/home
mount /dev/sda4 /mnt/home
#------------------------------------------------------------
#RANK MIRRORS
#------------------------------------------------------------
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
sed -i 's/^#Server/Server/' /etc/pacman.d/mirrorlist.backup
rankmirrors -n 0 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist

#------------------------------------------------------------
#installing base files for system
pacstrap /mnt base base-devel

#generating fastab
genfstab -U /mnt >> /mnt/etc/fstab

#download and execute the second part of the script
curl https://raw.githubusercontent.com/Kitsukai/kuroArch/master/shiroChroot.sh > /mnt/chroot.sh && arch-chroot /mnt bash chroot.sh && rm /mnt/chroot.sh

#setting the new hostname in the new system
cat comp > /mnt/etc/hostname && rm comp


dialog --defaultno --title "Final Qs" --yesno "Reboot computer?"  5 30 && finalreboot
dialog --defaultno --title "Final Qs" --yesno "Return to chroot environment?"  6 30 && arch-chroot /mnt
clear
