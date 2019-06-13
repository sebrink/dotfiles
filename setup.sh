#!/bin/bash
# Script to automate install of my dotfiles on a new OSX machine! 
#   - You will need to set the iterm2 font.
#   - Takes about <insert time here>
# TODO: 
#   - Install brew
#   - Give time estimate
#   - Automatically switch shells (at the end)
#   - Automate iterm2 font selection

# Make sure everything is run as root
if [[ $EUID -ne 0 ]]; then
   echo "Please run this script as root (this code will 100% hack you, so read it!)"
   exit 1
fi

# Install oh-my-zsh
brew install zsh
brew install curl
sh -c "$(curl -Lo install.sh https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh) --unattended"

# Tap some useful things
brew tap caskroom/cask
brew tap caskroom/fonts

# Other useful utilities
brew install wget coreutils findutils curl tree git ssh-copy-id htop sl

# Useful applications 
brew install java visual-studio-code docker virtualbox vagrant thefuck
brew cask install iterm2 brave

# Themes
git clone https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k/
( cd && curl -fsSLO https://raw.githubusercontent.com/romkatv/dotfiles-public/master/.purepower )

# Plugins
git clone https://github.com/amstrad/oh-my-matrix.git $HOME/.oh-my-zsh/custom/plugins/oh-my-matrix/
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/
git clone https://github.com/floor114/zsh-apple-touchbar $HOME/.oh-my-zsh/custom/plugins/zsh-apple-touchbar/
git clone https://github.com/zlsun/solarized-man.git $HOME/.oh-my-zsh/custom/plugins/solarized-man/

# Other dependencies
git clone https://github.com/uuner/sedtris.git /opt
gem install colorls

# Fonts (Not totally automatic, need to set in iterm2)
brew install font-hack-nerd-font

# Setup dotfiles
git clone https://github.com/sebrink/dotfiles.git $HOME/dotfiles 
mv $HOME/dotfiles/.gitconfig $HOME/.gitconfig
rm $HOME/.zshrc
ln -sv $HOME/dotfiles/.zshrc $HOME/.zshrc
rm $HOME/.vimrc
ln -sv $HOME/dotfiles/.vimrc $HOME/.vimrc
