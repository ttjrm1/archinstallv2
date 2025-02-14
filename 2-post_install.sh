
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

take_post_install_snaphot () {
   sudo snapper -v -c root create -t single -d "Post Clean Install Snapshot"
}

sudo pacman -Syy
install_paru
take_post_install_snapshot
