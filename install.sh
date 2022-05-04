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

# some bullshit
echo "Hi you want to install arch linux with my dotfiles :flush_emoji:"
echo ""
echo "Make sure you have network :)"
echo ""
echo "Using US keyboard layout and Indian timezone"
echo ""
echo "Do you want to continue ? press enter"  
read hmm
timedatectl set-ntp true
printf '\033c'

# partition your disk
lsblk
cfdisk /dev/sda  

# format the boot partition
echo "type your boot/efi partition"
read efi
mkfs.fat -F32 $efi
echo ""
echo ""

# format swap partition
echo "type your swap partition"
read swap
echo ""
mkswap $swap
swapon $swap

# format root partition
echo ""
echo "type your root partition"
read root
mkfs.ext4 $root
mount $root /mnt

# install the basic system (kernel, firmware, etc..) to /mnt
pacstrap /mnt linux base linux-firmware

# generate file system table
genfstab -U /mnt >> /mnt/etc/fstab

# run the 2nd script
chmod +x ./install_part2.sh
cp install_part2.sh /mnt/
arch-chroot /mnt ./install_part2.sh ; rm /mnt/install_part2.sh
