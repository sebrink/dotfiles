## Terminal Settings
export TERM="xterm-256color"
export ZSH="$HOME/.oh-my-zsh"

## ZSH Settings
ZSH_THEME="risto"
CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

## Plugins
plugins=( git pip python osx zsh-syntax-highlighting zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

## Path Additions and OS specific settings
case "$OSTYPE" in
	darwin*)
		
		export JAVA_HOME=/Library/Internet\ Plug-Ins/JavaAppletPlugin.plugin/Contents/Home
		export JAVA_HOME=/usr/local/opt/openjdk@11

		# Go Dev
		export GOPATH="$HOME/go"
		export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

		# x11
		export PATH="$PATH:/opt/X11/bin/"
	;;
	linux*)
		# Eventually I may put something here
	;;
esac

export SSH_KEY_PATH="~/.ssh/ed_25519"

## Aliases
alias vimrc="vim ~/.vimrc"
alias zshrc="vim ~/.zshrc && source ~/.zshrc"
alias vi="vim"
alias l="ls -la"
alias c="clear"
alias ls="exa"
alias p="ping 1.1.1.1"
alias yeet="curl parrot.live"

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

# Why isn't this just a one liner? Who knows.
# TIL there is a theme you can set called RANDOM which does this
# Woops.
function rt () {
	a=$(grep -v alias ~/.zshrc | grep THEME | cut -d'"' -f2);
	b=$(shuf -n 1 ~/dotfiles/.zsh-themes);
	sed -i '' "s/$a/$b/g" ~/.zshrc;
	unset a
	unset b
	source ~/.zshrc
}

jdk() {
        version=$1
        export JAVA_HOME=$(/usr/libexec/java_home -v"$version");
        java -version
 }
