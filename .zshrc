## Terminal Settings
export TERM="xterm-256color"
export ZSH="$HOME/.oh-my-zsh"

## ZSH Settings
ZSH_THEME="powerlevel10k/powerlevel10k"
CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

## Plugins
plugins=( git oh-my-matrix pip python osx zsh-syntax-highlighting )
source $ZSH/oh-my-zsh.sh

## If purepower theme      
source ~/.purepower

## If no purepower theme
## Powerline settings
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(root_indicator time)

## Path Additions and OS specific settings
case "$OSTYPE" in
	darwin*)
		
		export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin:/usr/local/sbin/"
		export PATH="$HOME/.gem/ruby/2.5.0/bin:$PATH"
		# export PATH="/usr/local/opt/inetutils/libexec/gnubin:$PATH"
		export JAVA_HOME=/Library/Internet\ Plug-Ins/JavaAppletPlugin.plugin/Contents/Home


		# Go Dev
		export GOPATH="$HOME/go"
		export GOROOT="$(brew --prefix golang)/libexec"
		export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

		# Fuck settings
		eval $(thefuck --alias)
		unalias mysql
	;;
	linux*)
		# Eventually I may put something here
	;;
esac

export SSH_KEY_PATH="~/.ssh/rsa_id"

## Aliases
alias vimrc="vim ~/.vimrc"
alias zshrc="vim ~/.zshrc && source ~/.zshrc"
alias vi="vim"
alias l="ls -la"
alias c="clear"
alias down="prompt_powerlevel9k_teardown"
alias up="prompt_powerlevel9k_setup"
alias yeet="curl parrot.live"
alias ls="colorls"
alias tetris="bash /opt/sedtris/sedtris.sh"
alias p="ping 1.1.1.1"

# Git
alias gs="git status"
alias gc="git commit -m $1"
alias ga="git add $@"
alias gp="git push"

# Tmux
alias tn="tmux new -s"
alias ta="tmux attach -t"
alias tl="tmux ls"
alias td="tmux detach"

## Disable annoying settings
unsetopt correct_all
