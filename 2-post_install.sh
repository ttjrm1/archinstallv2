
#!/bin/bash

##
## Post Install reboot configure
##

install_paru () {
    mkdir AUR
    cd AUR
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si
}

intstall_snap_pac_grub () {
    paru -S --noconfirm snap-pac-grub
}

take_post_install_snaphot () {
   sudo snapper -v -c root create -t single -d "Post Clean Install Snapshot"
}

pacman -Syy
install_paru
intstall_snap_pac_grub
