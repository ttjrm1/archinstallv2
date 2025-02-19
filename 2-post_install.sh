
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

take_post_install_snapshot () {
   sudo snapper -v -c root create -t single -d "Post Clean Install Snapshot"
}

install_extra_pkgs () {
    paru -S --noconfirm grub-btrfs-git
    paru -S --noconfirm  mkinitcpio-numlock
    sudo mkinitcpio -P
    sudo grub-mkconfig -o /boot/grub/grub.cfg
}

sudo pacman -Syy
install_paru
install_extra_pkgs
take_post_install_snapshot
