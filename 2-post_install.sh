
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

install yay () {
    mkdir AUR && cd AUR
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
}

take_post_install_snapshot () {
   sudo snapper -v -c root create -t single -d "Post Clean Install Snapshot"
}

install_extra_pkgs () {
#   yay --noconfirm grub-btrfs-git
    yay --noconfirm  mkinitcpio-numlock
    sudo mkinitcpio -P
    sudo grub-mkconfig -o /boot/grub/grub.cfg
}

sudo pacman -Syy
install_yay
install_extra_pkgs
take_post_install_snapshot
