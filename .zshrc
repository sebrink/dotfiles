## Terminal Settings
export TERM="xterm-256color"
export ZSH="/Users/scott/.oh-my-zsh"

## ZSH Settings
ZSH_THEME="powerlevel10k/powerlevel10k"
CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

## Plugins
plugins=( git oh-my-matrix pip python osx zsh-syntax-highlighting zsh-apple-touchbar solarized-man )
source $ZSH/oh-my-zsh.sh

## If purepower theme      
source ~/.purepower

## If no purepower theme
## Powerline settings
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(root_indicator time)

## Path Additions
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH="$HOME/.gem/ruby/2.5.0/bin:$PATH"
export SSH_KEY_PATH="~/.ssh/rsa_id"
export JAVA_HOME=/Library/Internet\ Plug-Ins/JavaAppletPlugin.plugin/Contents/Home

## Aliases
alias vimrc="vim ~/.vimrc"
alias zshrc="vim ~/.zshrc && source ~/.zshrc"
alias vi="vim"
alias l="ls -la"
alias c="clear"
alias down="prompt_powerlevel9k_teardown"
alias up="prompt_powerlevel9k_setup"
alias yeet="curl parrot.live"
alias python="python3"
alias tree="tree | lolcat"
alias ls="colorls"
alias tetris="bash /opt/sedtris/sedtris.sh"
alias con="ping -c 2 1.1.1.1"

## Fuck and Colorls settings
eval $(thefuck --alias)
eval "$(rbenv init -)"

## Disable annoying settings
unsetopt correct_all
