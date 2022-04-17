printf '\033c'
echo "Part 2"
echo ""

# timezone
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc

# vim install
echo "installing vim"
pacman --noconfirm -S vim

# generate locale
vim /etc/locale.gen
locale-gen

# set hostname
echo "enter your hostname"
read hostname
echo $hostname > /etc/hostname
echo "127.0.0.1       localhost" >> /etc/hosts
echo "::1             localhost" >> /etc/hosts
echo "127.0.1.1       $hostname.localdomain $hostname" >> /etc/hosts

# set root password
echo "root password"
passwd
echo ""

# set username and add user
echo "set username"
read username
useradd -m $username

# add the user to various groups
usermod -aG wheel,audio,network,video,optical,storage $username
echo "set user password"

# set user password 
passwd $username
echo "installing packages"

# for network
pacman --noconfirm -S NetworkManager
systemctl enable NetworkManager

# edit sudo config
EDITOR=vim visudo
printf '\033c'

# change shell to zsh
pacman --noconfirm -S zsh
chsh $username -s /bin/zsh

# boot (GRUB)
pacman --noconfirm -S grub mtools efibootmgr os-prober dosfstools
echo "enter EFI partition" 
read efipartition
mkdir /boot/EFI
mount $efipartition /boot/EFI
grub-install --target=x86_64-efi --bootloader-id=Arch --recheck
grub-mkconfig -o /boot/grub/grub.cfg
echo "Installation complete reboot ! (use exit and then umount -l /mnt then reboot)"
