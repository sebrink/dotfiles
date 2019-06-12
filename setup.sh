#!/bin/bash
# Script to automate install of my dotfiles on a new OSX machine! 
#   - You will need to set the iterm2 font.
#   - Takes about <insert time here>
# TODO: 
#   - Give time estimate
#   - Automate iterm2 font selection

# Make sure everything is run as root
if [[ $EUID -ne 0 ]]; then
   echo "Please run this script as root (this code will 100% hack you, so read it!)"
   exit 1
fi

# Install brew
/usr/bin/ruby -e "(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install oh-my-zsh
brew install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Tap some useful things
brew tap caskroom/cask
brew tap caskroom/fonts

# Other useful utilities
brew install wget coreutils findutils curl tree git ssh-copy-id htop sl

# Useful applications 
brew install java visual-studio-code docker virtualbox vagrant thefuck
brew cask install iterm2 brave

# Themes
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
( cd && curl -fsSLO https://raw.githubusercontent.com/romkatv/dotfiles-public/master/.purepower )

# Plugins
git clone https://github.com/amstrad/oh-my-matrix $ZSH_CUSTOM/plugins/oh-my-matrix
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/floor114/zsh-apple-touchbar $ZSH_CUSTOM/plugins/zsh-apple-touchbar
git clone https://github.com/zlsun/solarized-man.git $ZSH_CUSTOM/plguins/solarized-man

# Other dependencies
git clone https://github.com/uuner/sedtris.git /opt
gem install colorls

# Fonts (Not totally automatic, need to set in iterm2)
brew install font-hack-nerd-font

# Setup dotfiles
git clone https://github.com/sebrink/dotfiles $HOME 
mv $HOME/dotfiles/.gitconfig $HOME/.gitconfig
ln -sv $HOME/dotfiles/.zshrc $HOME/.zshrc
ln -sv $HOME/dotfiles/.vimrc $HOME/.vimrc
