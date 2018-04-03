# Script for quick installation of arch Linux
  
  
### ***Features***
-Base devel installation  
-Patitions 4: boot, swap, root, home  
-Network manager  
-Time zone: Bogota  
-Locale: es_CO  
-Linux Zen Kernel  
### ***Before start***
This script is lazy and not totally automated. You need have some knowledge about command line Linux installation on arch for some things manually. This script was thought just for 1 Linux distribution on efi file system, if you wanna do a double/triple boot or other file system install feel free to modify the script to your need

#### Requirements

[stow](http://www.gnu.org/software/stow/)  

## ***Instructions***
1. Connect your computer to internet with wifi-menu or Ethernet cable.  
2. Manual disk: partition use your prefer tool.  
**Note**: this script only works with 4 partition in the follow strict.  
***Partition table:***  
1st partition-> Boot: 500 MiB - 1 GiB ||  
2nd partition-> Swap: double of your ram capacity(less or more if you want) ||  
3rd partition-> Root: 15~50 GiB ||  
4th partition-> Home: space you want(i usually use all the rest of my HDD space)  
3. Download kuroArch script file:
```bash
curl -OL https://raw.githubusercontent.com/Kitsukai/kuroArch/master/kuroArch.sh
```
4. Run script file:
```bash
bash kuroArch.sh
```
