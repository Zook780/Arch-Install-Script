printf '\033c'
echo "Part 2"
echo ""
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc
echo "installing vim"
pacman --noconfirm -S vim
vim /etc/locale.gen
locale-gen
echo "enter your hostname"
read hostname
echo $hostname > /etc/hostname
echo "127.0.0.1       localhost" >> /etc/hosts
echo "::1             localhost" >> /etc/hosts
echo "127.0.1.1       $hostname.localdomain $hostname" >> /etc/hosts
echo "root password"
passwd
echo ""
echo "set username"
read username
useradd -m $username
usermod -aG wheel,audio,network,video,optical,storage $username
echo "set user password"
passwd $username
echo ""
echo "Installing packages"
ech0 ""
pacman -S --noconfirm xorg git xorg-server xorg-xinit sxiv mpv \
       zathura zathura-pdf-poppler nitrogen ffmpeg python-pywal \
       mutt qt5ct ranger unzip zip maim imagemagick fzf youtube-dl \
       firefox base-devel networkmanager zsh pamixer noto-fonts noto-fonts-emoji noto-fonts-cjk pulseaudio pavucontrol \
       alsa-utils vim sudo emacs zip unzip git zsh libnotify \
       notify-osd picom rofi sudo bluez-utils xdg-user-dirs xf86-video-fbdev \
       xf86-video-intel xf86-video-nouveau xf86-video-openchrome
git clone https://aur.archlinux.org/yay-git.git
cd yay-git/
makepkg -si
yay --noconfirm -S tela-icon-theme ttf-mononoki ttf-jetbrains-mono
systemctl enable NetworkManager
vim /etc/sudoers
printf '\033c'
git clone https://github.com/Zook780/dotfiles /home/$username/
cp -r /home/$username/dotfiles/* /home/$username/
rm -rf /home/$username/dotfiles
wal -i /home/$username/pix/wall/abstract-face.png
sudo make -C /home/$username/.dwm clean install
sudo make -C /home/$ussername/.dwmblocks clean install
sudo make -C /home/$username/.st clean install
rm -rf /home/$username/img/
chsh -s /usr/bin/zsh
pacman --noconfirm -S grub mtools efibootmgr os-prober dosfstools
echo "enter EFI partition" 
read efipartition
mkdir /boot/EFI
mount $efipartition /boot/EFI
grub-install --target=x86_64-efi --bootloader-id=Arch --recheck
grub-mkconfig -o /boot/grub/grub.cfg
exit
printf '\033c'
echo "Installation complete rebooting !"
