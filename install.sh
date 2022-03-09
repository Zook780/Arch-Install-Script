# !/bin/sh
#  _____           _    _          _             _
# |__  /___   ___ | | _( )___     / \   _ __ ___| |__"
#   / // _ \ / _ \| |/ /// __|   / _ \ | '__/ __| '_ \"
#  / /| (_) | (_) |   <  \__ \  / ___ \| | | (__| | | |
# /____\___/ \___/|_|\_\ |___/ /_/   \_\_|  \___|_| |_|

#  ___           _        _ _   ____            _       _
# |_ _|_ __  ___| |_ __ _| | | / ___|  ___ _ __(_)_ __ | |_
#  | || '_ \/ __| __/ _` | | | \___ \ / __| '__| | '_ \| __|
#  | || | | \__ \ || (_| | | |  ___) | (__| |  | | |_) | |_
# |___|_| |_|___/\__\__,_|_|_| |____/ \___|_|  |_| .__/ \__|
#                                              |_|

printf '\033c'

echo "Hi you want to install arch linux with my dotfiles :flush_emoji:"
echo ""
echo "Make sure you have created your partitions and have network :)"
echo ""
echo "Using US keyboard layout and Indian timezone"
echo ""
echo "Do you want to continue ? answer with continue"  
read hmm
if $hmm == continue
then
continue
else 
echo "Incorrect option"   
fi
timedatectl set-ntp true
printf '\033c'
lsblk
echo "Enter your boot/efi partition: "
read efi
mkfs.fat -F32 $efi
echo ""
echo "Enter your root/linux partition: "
read root
mkfs.ext4 $root
echo ""
echo "Enter swap partition: "
read swap
echo ""
mkswap $swap
swapon $swap
mount $root /mnt
pacstrap /mnt linux base linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc
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
pacman -S --no-confirm xorg git xorg-server xorg-xinit tff-jetbrains-mono sxiv mpv zathura zathura-pdf-poppler nitrogen ffmpeg python-pywal arc-gtk-theme unzip zip maim imagemagick fzf youtube-dl firefox networkmanager zsh pamixer pulseaudio pavucontrol alsa-utils vim emacs git zsh dosfstools libnotify notify-osd
picom rofi sudo bluez-utils xf86-video-fbdev xf86-video-intel xf86-video-nouveau xf86-video-openchrome
git clone https://aur.archlinux.org/yay-git.git
(cd yay-git/ && makepkg -si PKGBUILD)
yay --noconfirm -S tela-icon-theme
systemctl enable NetworkManager
vim /etc/sudoers
chsh -s ($which zsh)
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
