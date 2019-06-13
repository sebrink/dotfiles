#!/bin/bash
# Script to automate install of my dotfiles on a new OSX machine! 
#   - You will need to set the iterm2 font.
#   - Takes about <insert time here>
#   - Must make zsh default shell on your own (this is the next feature to be added)
# TODO: 
#   - Give time estimate
#   - Automatically switch shells (at the end)
#   - Automate iterm2 font selection

# Install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install oh-my-zsh
brew install zsh curl
curl -Lo install.sh https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
sh install.sh --unattended

# Tap some useful things
brew tap caskroom/cask
brew tap caskroom/fonts

# Other useful utilities
brew install wget coreutils findutils tree git ssh-copy-id htop sl

# Useful applications 
brew install docker virtualbox vagrant thefuck
brew cask install iterm2 brave-browser visual-studio-code

# Themes
git clone https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k/
( cd && curl -fsSLO https://raw.githubusercontent.com/romkatv/dotfiles-public/master/.purepower )

# Plugins
git clone https://github.com/amstrad/oh-my-matrix.git $HOME/.oh-my-zsh/custom/plugins/oh-my-matrix/
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/
git clone https://github.com/floor114/zsh-apple-touchbar $HOME/.oh-my-zsh/custom/plugins/zsh-apple-touchbar/
git clone https://github.com/zlsun/solarized-man.git $HOME/.oh-my-zsh/custom/plugins/solarized-man/

# Other dependencies
gem install colorls

# Fonts (Not totally automatic, need to set in iterm2)
brew cask install font-hack-nerd-font

# Setup dotfiles
git clone https://github.com/sebrink/dotfiles.git $HOME/dotfiles 
mv $HOME/dotfiles/.gitconfig $HOME/.gitconfig
rm $HOME/.zshrc
ln -sv $HOME/dotfiles/.zshrc $HOME/.zshrc
rm $HOME/.vimrc
ln -sv $HOME/dotfiles/.vimrc $HOME/.vimrc

# Seriously? Sudo for tetris? Why does it have to be in opt?
sudo git clone https://github.com/uuner/sedtris.git /opt