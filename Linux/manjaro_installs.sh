# Install OhMyZsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install git
sudo pacman -S git 
sudo pacman -Syu base-devel --needed

# Install yay (Yet Another Yaourt. The evoluation of Yaourt)
cd /opt
sudo git clone https://aur.archlinux.org/yay-git.git
sudo chown -R $USER:$USER ./yay-git
makepkg -si

# Install slack
git clone https://aur.archlinux.org/slack-desktop.git
cd slack-desktop
makepkg -sri
yay -S slack-desktop

# For terminal multiplying
sudo pacman -S tmux

#IDE / text editor
sudo pacman -S code vim

# Browser of choice
sudo pacman -S vivaldi

# Move player
sudo pacman -S vlc

# Install media codecs
sudo pacman -S jasper lame libdca libdv gst-libav libtheora libvorbis libxv wavpack x264 \
    xvidcore dvd+rw-tools dvdauthor dvgrab libmad libmpeg2 libdvdcss libdvdread libdvdnav \
    a52dec faac faad2 flac


