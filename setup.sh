#!/bin/bash
# Script to automate the install of my dotfiles on a new OSX machine! 
#   - You will need to set the iterm2 font.
# TODO: 
#   - Automate iterm2 font selection (using defaults command?)
#   - Automate iterm2 profile
#   - Set installed browser as default browser
#   - Remove enter click on brew installation
#   - Add slack, spotify, spectacle, vmware-fusion, signal, vlc, vivaldi, google chrome, firefox, virtualbox, postman, android studio
#	- Add colors to the install messages
#	- See if applescript will do anything better?

# Install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Tap some useful things
brew tap caskroom/cask
brew tap caskroom/fonts

# Other useful utilities
PACKAGES=(
	wget
	zsh
	coreutils
	findutils
	tree
	git
	ssh-copy-id
	htop
	sl
	thefuck
	python
	python3
	vim
)    

echo " [+] Installing Packages... "
brew install ${PACKAGES[@]}

# Useful applications 
CASKS=(
	brave-browser
	iterm2
	visual-studio-code
	vagrant
	docker
	font-hack-nerd-font
)

echo " [+] Installing Casks... "
brew install ${CASKS[@]}

echo " [+] Installing the oh-my-zsh... " 
curl -Lo install.sh https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
sh install.sh --unattended
rm install.sh

# Themes
echo " [+] Downloading themes and plugins... "
git clone https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k/
( cd && curl -fsSLO https://raw.githubusercontent.com/romkatv/dotfiles-public/master/.purepower )

# Plugins
git clone https://github.com/amstrad/oh-my-matrix.git $HOME/.oh-my-zsh/custom/plugins/oh-my-matrix/
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/
git clone https://github.com/floor114/zsh-apple-touchbar $HOME/.oh-my-zsh/custom/plugins/zsh-apple-touchbar/

echo " [+] Setting up dotfiles... "
# Setup dotfiles
git clone https://github.com/sebrink/dotfiles.git $HOME/dotfiles 
mv $HOME/dotfiles/.gitconfig $HOME/.gitconfig
rm $HOME/.zshrc
ln -sv $HOME/dotfiles/.zshrc $HOME/.zshrc
rm $HOME/.vimrc
ln -sv $HOME/dotfiles/.vimrc $HOME/.vimrc

# Colorls, make tetirs, set zsh
echo " [+] Installing colorls, sedtris, and your new shell... "
sudo gem install colorls
sudo git clone https://github.com/uuner/sedtris.git /opt
sudo dscl . -create /Users/$USER UserShell /usr/local/bin/zsh
