# Update the system
sudo apt update && sudo apt upgrade -y
sudo apt install curl

# Install OhMyZsh
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# ZSH plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Install git
sudo apt install git

# For terminal multiplying (tmux)
sudo apt install tmux

#IDE / text editor (vscodium, vim)
# Look it up

# Browser of choice (vivaldi)
# Done via different browser

# Movie player (vlc)
sudo apt install vlc

# Install media codecs

# Set up openssh

# Mozilla VPN
sudo add-apt-repository ppa:mozillacorp/mozillavpn
sudo apt-get update
sudo apt-get install mozillavpn

# Work stuff
# Install slack, zoom
# need to look these up too

