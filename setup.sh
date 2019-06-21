#!/bin/bash
# Script to automate the install of my dotfiles on a new OSX machine! 
#   - You will need to set the iterm2 font.
#   - VMWare fusion needs password
#   - Vagrant needs password
# TODO: 
#   - Automate iterm2 font selection (using defaults command?)
#   - Automate iterm2 profile
#   - Set preferred browser as default browser
#	- Add colors to the install messages
#	- See if applescript will do anything better than what is being done now
#       - Deleting applications
#           - https://discussions.apple.com/thread/3909964
#           - https://apple.stackexchange.com/questions/103621/run-applescript-from-bash-script
#   - Set trackpad to right click on bottom right
#   - Remove password from vagrant and vmware-fusion install (not sure of how to do this yet)
#	- Problem children:
#		- Virtualbox
#		- Vagrant
#		- MTMR

# Install brew
echo " [+] Installing brew and tapping useful casks... "
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null

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
	iterm2
	visual-studio-code
	docker
	postman
	spotify
	spectacle
	signal
	android-studio
	vmware-fusion
	brave-browser
	vivaldi
	google-chrome
	firefox
	font-hack-nerd-font
	sloth
	vagrant
	mtmr
	vagrant-manager
)

echo " [+] Installing Casks... "
brew cask install ${CASKS[@]}

echo " [+] Installing the oh-my-zsh... " 
curl -Lo install.sh https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
sh install.sh --unattended
rm install.sh

# Themes
echo " [+] Downloading oh-my-zsh themes and plugins... "
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
rm $HOME/Library/Applications\ Support/MTMR/items.json
ln -sv $HOME/dotfiles/items.json $HOME/Library/Application\ Support/MTMR/items.json

# Colorls, make tetirs, set zsh
echo " [+] Installing colorls, sedtris, and your new shell... "
sudo gem install colorls
sudo git clone https://github.com/uuner/sedtris.git /opt/sedtris

# This line sets ZSH as the curr user's shell. Catalina, come fast so I can remove this.
sudo dscl . -create /Users/$USER UserShell /usr/local/bin/zsh

# Testing zone

# Adding Icons to the Dock
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Google Chrome.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'

# Sets autohide on the dock
defaults write com.apple.dock autohide -int 1

# Sets dock to the left side of the screen
defaults write com.appl.dock orientation left
