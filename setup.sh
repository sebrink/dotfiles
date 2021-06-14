#!/bin/bash
# Script to automate configs on a new OSX or Linux machine! 
# Author: Scott Brink

# If MacOS, install brew and packages
if [ "$(uname)" == "Darwin" ]; then

	# Install brew
	echo " [+] Installing Brew"
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null

	echo " [+] Installing Brewfile contents"
	# This assumes brewfile is in the same directory. If it isn't, you're going to have a bad time.
	brew bundle
	# This is installed separately since I remove it after I set firefox
	brew install defaultbrowser

# ATM this only will work for Ubuntu, that is intentional. I will make this more specific soon^TM
else

	# Setting up for VSCode
	apt update
	apt install software-properties-common apt-transport-https wget -y
	wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
	sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"

	# Setting up for docker
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu disco stable test"

	# Update
	apt-get update -y && apt-get upgrade -y

	PACKAGES=(
		zsh
		tmux
		code
		python
		python-pip
		python3
		python3-pip
		python-dev
		build-essential
		vim
		docker-ce
		docker-ce-cli
		containerd.io
		ruby
		ruby-dev
	)

	apt install ${PACKAGES[@]} -y

fi

echo " [+] Installing the oh-my-zsh " 
curl -Lo install.sh https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
sh install.sh --unattended
rm install.sh

# Themes
echo " [+] Downloading oh-my-zsh themes and plugins"
git clone https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k/
( cd && curl -fsSLO https://raw.githubusercontent.com/romkatv/dotfiles-public/master/.purepower )

# Plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/
plugins=(git zsh-syntax-highlighting)

echo " [+] Setting up dotfiles... "
# Setup dotfiles
git clone https://github.com/sebrink/dotfiles.git $HOME/dotfiles 
touch $HOME/.gitconfig
mv $HOME/dotfiles/.gitconfig $HOME/.gitconfig
touch $HOME/.zshrc
rm $HOME/.zshrc
ln -sv $HOME/dotfiles/.zshrc $HOME/.zshrc
touch $HOME/.vimrc
rm $HOME/.vimrc
ln -sv $HOME/dotfiles/.vimrc $HOME/.vimrc
touch $HOME/.tmux.conf
rm $HOME/.tmux.conf
ln -sv $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf

if [ "$(uname)" == "Darwin" ]; then

	# Set default browser
	defaultbrowser firefox
	brew uninstall defaultbrowser

	# Defaults time!

	# Trackpad: map bottom right corner to right-click
	defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
	defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
	defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
	defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

	# Fix the scroll direction to actually make sense
	defaults write -g com.apple.swipescrolldirection -bool FALSE

	# Save screenshots to the desktop
	defaults write com.apple.screencapture location -string "${HOME}/Desktop"

	# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
	defaults write com.apple.finder QuitMenuItem -bool true

	# Remove all default applications on dock
	defaults write com.apple.dock persistent-apps -array

	# Adding Icons to the Dock
	defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Slack.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
	defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Firefox.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
	defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/iTerm.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
	defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/VMware Fusion.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
	defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Visual Studio Code.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
	defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Spotify.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'

	# Sets autohide on the dock
	defaults write com.apple.dock autohide -int 1

	# Sets dock to the left side of the screen
	defaults write com.apple.dock orientation left

	# Disable the annoying line marks in iterm2
	defaults write com.apple.Terminal ShowLineMarks -int 0

	# Remove iterm2 prompt on quit
	defaults write com.googlecode.iterm2 PromptOnQuit -bool false

	## TODO
	# Programactically import the json profiles to have instant drop down terminal

# This atm is anything that is not darwin, aka any non macOS
else 
	# Set default shell to zsh
	if [[ -z "$SUDO_USER" ]]; then
		usermod -s `which zsh` $USER
	else
		usermod -s `which zsh` $SUDO_USER
	fi
fi

echo "Install complete! For OSX, you will need to install Virtualbox, Vagrant, VMWare Fusion manually because they prompt for a password."
