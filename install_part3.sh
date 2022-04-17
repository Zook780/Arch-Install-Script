echo "change #include path in .dwm .dwmblocks .st .dwmblocks"
read yes

# install yay 
git clone https://aur.archlinux.org/yay-git.git
cd yay-git/
makepkg -si

# install some fonts and pfetch(minimal neofetch)
yay --noconfirm -S pfetch tela-icon-theme ttf-font-awesome ttf-mononoki ttf-jetbrains-mono

# cloudflare and google dns 
sudo echo "nameserver 1.1.1.1" >> /etc/resolv.conf 
sudo echo "nameserver 8.8.8.8" >> /etc/resolv.conf 
sudo echo "nameserver 8.8.4.4" >> /etc/resolv.conf
# make the file write protected so that network manager doesn't override it
sudo chattr +i /etc/resolv.conf

# for some reason packages were not able to install when aligned with indentation and /
pacman -S --noconfirm xorg git xorg-server xorg-xinit sxiv mpv mpd zathura zathura-pdf-poppler nitrogen ffmpeg ncmpcpp python-pywal redshift ranger unzip zip maim imagemagick fzf youtube-dl newsboat pulseaudio firefox neomutt base-devel networkmanager zsh pamixer noto-fonts pavucontrol alsa-utils emacs qt5ct git libnotify blueberry noto-fonts-emoji noto-fonts-cjk vim dunst picom sudo bluez-utils xdg-user-dirs xf86-video-fbdev ueberzug lxappearance xf86-video-intel xf86-video-nouveau xf86-video-openchrome

# clone the dotfiles
git clone https://github.com/Zook780/dotfiles
cd dotfiles
mv * ../
cd
rm -rf dotfiles/

# compile dwm, st, dmenu and dwmblocks
wal -i pix/wall/abstract-face.png
sudo make -C ~/.dwm/ clean install
sudo make -C ~/.dmenu/ clean install
sudo make -C ~/.dwmblocks/ clean install
sudo make -C ~/.st/ clean install
