ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc
echo "installing vim"
pacman --noconfirm -S vim
vim /etc/locale.gen
locale-gen
echo "Hostname: "
read hostname
echo $hostname > /etc/hostname
echo "127.0.0.1       localhost" >> /etc/hosts
echo "::1             localhost" >> /etc/hosts
echo "127.0.1.1       $hostname.localdomain $hostname" >> /etc/hosts
vim /etc/locale.gen
locale-gen
echo "Hostname: "
read hostname
echo $hostname > /etc/hostname
echo "127.0.0.1       localhost" >> /etc/hosts
echo "::1             localhost" >> /etc/hosts
echo "127.0.1.1       $hostname.localdomain $hostname" >> /etc/hosts
echo "Set root password"
passwd
echo ""
echo "Adding user"
echo ""
echo "Enter username"
read username
useradd -m $username
usermod -aG wheel,audio,network,video $username
pacman --noconfirm -S grub efibootmgr os-prober
echo "Enter EFI partition: " 
read efipartition
mkdir /boot/EFI
mount $efipartition /boot/EFI
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Arch
grub-mkconfig -o /boot/grub/grub.cfg
pacman -S --noconfirm xorg git xorg-server xorg-xinit sxiv mpv \
       zathura zathura-pdf-poppler nitrogen ffmpeg python-pywal \
       arc-gtk-theme unzip zip maim imagemagick fzf youtube-dl \
       firefox networkmanager zsh pamixer pulseaudio pavucontrol \
       alsa-utils vim sudo emacs git zsh dosfstools libnotify \
       notify-osd picom rofi sudo bluez-utils xf86-video-fbdev \
       xf86-video-intel xf86-video-nouveau xf86-video-openchrome
git clone https://aur.archlinux.org/yay-git.git
(cd yay-git/ && makepkg -si PKGBUILD)
yay --noconfirm -S tela-icon-theme ttf-mononoki ttf-jetbrains-mono
systemctl enable NetworkManager
vim /etc/sudoers
chsh -s /usr/bin/zsh
exit
printf '\033c'
cd $HOME
wal -i pix/wall/abstract-face.png
git clone https://github.com/Zook780/dotfiles
sudo make -C ~/.dwm clean install
sudo make -C ~/.dwmblocks clean install
sudo make -C ~/.st clean install
rm -rf img/
exit
printf '\033c'
echo "Installation complete rebooting !"
