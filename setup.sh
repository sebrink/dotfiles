#!/bin/bash
# Script to automate the install of my dotfiles on a new OSX machine! 
#   - You will need to set the iterm2 font.
# TODO: 
#   - Automate iterm2 font selection (using defaults command?)
#   - Automate iterm2 profile
#   - Set installed browser as default browser

# Install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install oh-my-zsh
brew install zsh curl
curl -Lo install.sh https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
sh install.sh --unattended
rm install.sh

# Tap some useful things
brew tap caskroom/cask
brew tap caskroom/fonts

# Other useful utilities
brew install wget coreutils findutils tree git ssh-copy-id htop sl thefuck

# Install web browser (brave, vivaldi, chrome, firefox, etc.)
brew cask install brave-browser 

# Useful applications 
brew cask install iterm2 visual-studio-code vagrant docker virtualbox

# Virtualbox error workaround for now
read -p "Press enter to continue (Fix virtualbox error)"

# Themes
git clone https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k/
( cd && curl -fsSLO https://raw.githubusercontent.com/romkatv/dotfiles-public/master/.purepower )

# Plugins
git clone https://github.com/amstrad/oh-my-matrix.git $HOME/.oh-my-zsh/custom/plugins/oh-my-matrix/
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/
git clone https://github.com/floor114/zsh-apple-touchbar $HOME/.oh-my-zsh/custom/plugins/zsh-apple-touchbar/

# Fonts (Not totally automatic, need to set in iterm2)
brew cask install font-hack-nerd-font

# Setup dotfiles
git clone https://github.com/sebrink/dotfiles.git $HOME/dotfiles 
mv $HOME/dotfiles/.gitconfig $HOME/.gitconfig
rm $HOME/.zshrc
ln -sv $HOME/dotfiles/.zshrc $HOME/.zshrc
rm $HOME/.vimrc
ln -sv $HOME/dotfiles/.vimrc $HOME/.vimrc

# Sudo to fix colorls, make tetirs, set zsh
sudo gem install colorls
sudo git clone https://github.com/uuner/sedtris.git /opt
sudo dscl . -create /Users/$USER UserShell /usr/local/bin/zsh