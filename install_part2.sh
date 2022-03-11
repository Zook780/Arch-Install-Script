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
echo "installing packages"
pacman -S --noconfirm xorg git xorg-server xorg-xinit sxiv mpv \
       zathura zathura-pdf-poppler nitrogen ffmpeg ncmpcpp python-pywal \
       mutt qt5ct ranger unzip zip maim imagemagick fzf youtube-dl \
       firefox base-devel networkmanager zsh pamixer noto-fonts pulseaudio pavucontrol \
       alsa-utils vim sudo emacs zip unzip git libnotify noto-fonts-emoji noto-fonts-cjk\
       notify-osd picom vim sudo bluez-utils xdg-user-dirs xf86-video-fbdev \
       xf86-video-intel xf86-video-nouveau xf86-video-openchrome
systemctl enable NetworkManager
vim /etc/sudoers
printf '\033c'
chsh -s /usr/bin/zsh
pacman --noconfirm -S grub mtools efibootmgr os-prober dosfstools
echo "enter EFI partition" 
read efipartition
mkdir /boot/EFI
mount $efipartition /boot/EFI
grub-install --target=x86_64-efi --bootloader-id=Arch --recheck
grub-mkconfig -o /boot/grub/grub.cfg
echo "Installation complete reboot ! (use exit and then umount -l /mnt then reboot)"
