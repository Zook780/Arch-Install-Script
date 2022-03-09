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
mv Arch-Install-Script/install_part2.sh /mnt/
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt ./install_part2.sh
