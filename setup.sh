#!/bin/bash
# Script to automate configs on a new OSX or Linux machine! 
# Author: Scott Brink

# If MacOS, install brew and packages
if [ "$(uname)" == "Darwin" ]; then

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
		mtmr
		slack
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
		vagrant-manager
	)

	echo " [+] Installing Casks... "
	brew cask install ${CASKS[@]}

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
sudo git clone https://github.com/uuner/sedtris.git /opt/sedtris

if [ "$(uname)" == "Darwin" ]; then
	# This line sets ZSH as the curr user's shell. Catalina, come fast so I can remove this.
	sudo dscl . -create /Users/$USER UserShell /usr/local/bin/zsh

	# Defaults time!

	# Trackpad: map bottom right corner to right-click
	defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
	defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
	defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
	defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

	# Save screenshots to the desktop
	defaults write com.apple.screencapture location -string "${HOME}/Desktop"

	# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
	defaults write com.apple.finder QuitMenuItem -bool true

	# Remove all default applications on dock
	defaults write com.apple.dock persistent-apps -array

	# Adding Icons to the Dock
	defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Slack.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
	defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Brave Browser.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
	defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/iTerm.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
	defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/VMware Fusion.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
	defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Visual Studio Code.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
	defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Spotify.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
	defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Messages.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
	defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Notes.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
	defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/System Preferences.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'

	# Sets autohide on the dock
	defaults write com.apple.dock autohide -int 1

	# Sets dock to the left side of the screen
	defaults write com.apple.dock orientation left

	# Disable the annoying line marks in iterm2
	defaults write com.apple.Terminal ShowLineMarks -int 0

	# Remove iterm2 prompt on quit
	defaults write com.googlecode.iterm2 PromptOnQuit -bool false

else
	# Set default shell to zsh
	if [[ -z "$SUDO_USER" ]]; then
		usermod -s /bin/zsh $USER
	else
		usermod -s /bin/zsh $SUDO_USER
	fi
fi

echo "Install complete! For OSX, check on the installs of MTMR, Vagrant, and Virtualbox. These may need to be done by hand. Also, remember to change the font on iterm2 and set your default browser! For linux, things are barely tested, most stuff will work though! Probably :)."
