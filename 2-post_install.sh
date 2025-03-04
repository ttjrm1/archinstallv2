
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

take_snapshot () {
   sudo snapper -v -c root create -t single -d "$1"
}

install_extra_pkgs () {
    yay --noconfirm grub-btrfs-git
    yay --noconfirm  mkinitcpio-numlock
    sudo mkinitcpio -P
    sudo grub-mkconfig -o /boot/grub/grub.cfg
    #yay --noconfirm python-pywalfox
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

install _ml4w () {
    bash <(curl -s https://raw.githubusercontent.com/mylinuxforwork/dotfiles/main/setup-arch.sh)
}

sudo pacman -Syy
install_yay
install_extra_pkgs
additional_wallpapers
take_snapshot "Post Clean Install Snapshot"
install_ml4w
take_snapshot "Post ML4W Install Snapshot"
