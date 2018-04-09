#!/bin/bash
#second part of the kuroArch script
passwd
pacman -S --noconfirm dialog

TZuser=$(cat tzfinal.tmp)

ln -sf /usr/share/zoneinfo/$TZuser /etc/localtime

hwclock --systohc

echo "es_CO.UTF-8 UTF-8" >> /etc/locale.gen
echo "es_CO ISO-8859-1" >> /etc/locale.gen
locale-gen
function setKbEs() { echo "KEYMAP=es" > /etc/vconsole.conf ;}
function getVim() { pacman --noconfirm --needed -S vim ;}
function getZen() { pacman --noconfirm --needed -S linux-zen linux-zen-headers ;}
function zenOnly() { pacman -Rscn linux ;}
function askForOnlyZen() { dialog --title "kuroArch Tweaks" --yesno "Do you want remove the generic linux kernel?"  8 60 && zenOnly ;}
function zenSystem() { getZen && askForOnlyZen ;}
function getNM() { pacman --noconfirm --needed -S networkmanager && systemctl enable NetworkManager && systemctl start NetworkManager ;}
#ask for little tweaks
#ask for install and enable networkmanager
dialog --title "kuroArch Tweaks" --yesno "Do you want install Network Nanager?"  8 60 && getNM
dialog --title "kuroArch Tweaks" --yesno "Do you want set keybord layout to es?"  8 60 && setKbEs
dialog --title "kuroArch Tweaks" --yesno "Do you want install vim?"  8 60 && getVim
dialog --title "kuroArch Tweaks" --yesno "Do you want install the linux-zen kernel?"  8 60 && zenSystem

pacman --noconfirm --needed -S grub efibootmgr && grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB && grub-mkconfig -o /boot/grub/grub.cfg
