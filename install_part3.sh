echo "change #include path in .dwm .dwmblocks .st .dwmblocks"
read yes
git clone https://aur.archlinux.org/yay-git.git
cd yay-git/
makepkg -si
yay --noconfirm -S pfetch tela-icon-theme ttf-mononoki ttf-jetbrains-mono
git clone https://github.com/Zook780/dotfiles
# for some reasons i was not able to get all the files by copying from dotfiles to ./
cp -r dotfiles/.config ./
cp -r dotfiles/.dmenu ./
cp -r dotfiles/.dwm ./
cp -r dotfiles/.dwmblocks ./
cp -r dotfiles/.emacs.d ./
cp -r dotfiles/.git ./
cp -r dotfiles/.oh-my-zsh ./
cp -r dotfiles/.st ./
cp -r dotfiles/.vim ./
rm dotfiles/LICENSE
rm dotfiles/README.md
cp -r dotfiles/.Xresources ./
cp -r dotfiles/.gitignore ./
cp -r dotfiles/.xinitrc ./
cp -r dotfiles/.zlogin ./
cp -r dotfiles/.zshrc ./
rm -rf dotfiles/img
cp -r dotfiles/pix ./
rm -rf dotfiles/
rm -rf img/
wal -i pix/wall/abstract-face.png
sudo make -C ~/.dwm/ clean install
sudo make -C ~/.dwmblocks/ clean install
sudo make -C ~/.st/ clean install
