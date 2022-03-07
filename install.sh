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

echo "Hi you want to install arch linux with my dorfile :flush_emoji:"
echo ""
echo "Make sure you have created your partitions and have network :)"
echo ""
echo "Using us as keyboard layout and Indian timezone"
echo ""
echo "Do you want to continue ?"
read hmm
if $hmm == y
   continue
else
    echo "Incorrect option"   
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
pacstrap /mnt linux base linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab
mount $root /mnt
arch-chroot /mnt
ln -sf /usr/share/zoneinfo/Asia/Calcutta /etc/localtime
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
mkinitcpio -P
passwd
pacman --noconfirm -S grub efibootmgr os-prober
echo "Enter EFI partition: " 
read efipartition
mkdir /boot/efi
mount $efipartition /boot/efi 
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Arch
grub-mkconfig -o /boot/grub/grub.cfg
pacman -S --no-confirm xorg xorg-server xorg-xinit tff-jetbrains-mono sxiv mpv zathura zathura-pdf-poppler nitrogen ffmpeg python-pywal arc-gtk-theme unzip zip maim imagemagick fzf youtube-dl firefox networkmanager zsh pamixer pulseaudio pavucontrol alsa-utils vim emacs git zsh dosfstools libnotify notify-osd picom rofi sudo bluez-utils xf86-video-fbdev xf86-video-intel xf86-video-nouveau xf86-video-openchrome
git clone https://aur.archlinux.org/yay-git.git
(cd yay-git/ && makepkg -si PKGBUILD)
yay --noconfirm -S xava tela-icon-theme
systemctl enable NetworkManager
vim /etc/sudoers
echo "Set username: "
read username
useradd -m $username
usermod -aG wheel,audio,network,video $username
chsh -s ($which zsh)
exit
printf '\033c'
cd $HOME
git clone https://github.com/Zook780/dotfiles
sudo make -C ~/.dwm clean install
sudo make -C ~/.dwmblocks clean install
sudo make -C ~/.st clean install
rm -rf img/
exit
printf '\033c'
echo "Installation complete rebooting !"
