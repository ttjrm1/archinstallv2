
#!/bin/bash

##
## Post Install reboot configure
##

install_paru () {
    mkdir PKG
    cd PKG
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si
}

install_yay () {
    mkdir PKG && cd PKG
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
    yay --noconfirm python-pywalfox
}

additional_wallpapers () {   
    cd ~/Pictures
    git clone https://github.com/JaKooLit/Wallpaper-Bank.git Wallpaper-1
    git clone --depth=1 https://github.com/mylinuxforwork/wallpaper.git Wallpaper-2
}

install_sddm_theme () {
    cd ~/PKG
    git clone https://codeberg.org/minMelody/sddm-sequoia.git ~/sequoia && rm -rf ~/sequoia/.git
    sudo mv ~/sequoia /usr/share/sddm/themes/
    sudo sed 's/Current=/Current=sequoia/g' /etc/sddm.confd/sddm.conf
}
    

sudo pacman -Syy
install_yay
install_extra_pkgs
additional_wallpapers
take_post_install_snapshot
