# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
if [ "$(uname)" = 'Darwin' ]; then
	plugins=(git brew mvn osx sbt scala sublime node vagrant cap cp npm zsh-syntax-highlighting)
else
	plugins=(git mvn node npm screen yum cp zsh-syntax-highlighting)
fi

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
alias su="su -m "

# grep colours 
alias ls='ls -G'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# ls aliases
alias ll='ls -l -h'
alias la='ls -A'
alias l='ls -CF'

# cd aliases
alias ..='cd ..'

alias unsafe-ssh='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'

ALL_COLOURS=(31 35 37)
function highlight()
{
       GREP_COLOR="1;${ALL_COLOURS[$(($RANDOM % 3))]}" egrep --color=always "$1|$" $2
}

function hl() { local R=''; while [ $# -gt 0 ]; do R="$R|$1"; shift; done; GREP_COLOR="1;$(($RANDOM % 6 + 31))" egrep -i --color=always "\$$R"; }

function psgrep()
{
	#The echo | sed removes the grep line from being detected
	ps aux | GREP_COLOR="1;37" egrep -i --color=always $(echo "$1" | sed 's/^\(.\)\(.*\)$/[\1]\2/')
}

DEFAULT_USER="dom"

# Setup Path
SYSTEM_TYPE=$(uname)
if [ "$(uname)" = 'Darwin' ]; then
	export PATH=/usr/local/sbin:/usr/local/bin:$PATH
	export PATH="$(brew --prefix josegonzalez/php/php53)/bin:$PATH"
	export PATH="/usr/local/opt/ruby/bin:$PATH"
	export PATH="$PATH:/usr/local/share/npm/bin"
	export RBENV_ROOT=/usr/local/var/rbenv
	export PATH="/usr/local/var/rbenv/shims:${PATH}"
	export PATH="/usr/local/llvm32/bin:$PATH"
	export PATH="/usr/local/cov-analysis/bin:$PATH"
	export PATH="/Users/dom/.composer/vendor/bin:$PATH"
	export GOPATH=$HOME/go
	export PATH=$PATH:/usr/local/opt/go/libexec/bin:$GOPATH/bin
	rbenv rehash 2>/dev/null
rbenv() {
  typeset command
  command="$1"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  rehash|shell)
    eval `rbenv "sh-$command" "$@"`;;
  *)
    command rbenv "$command" "$@";;
  esac
}

	export VAGRANT_HOME="/Volumes/External Data/VagrantHome"
	#export VAGRANT_HOME="/Users/dom/VMs/VagrantHome"
	export CLOSURE_PATH="$(brew --prefix closure-compiler)/libexec/"
	export JAVA_HOME=$(/usr/libexec/java_home -v 1.7.0)
	export SCALA_HOME=/usr/local/opt/scala/idea
	#export DOCKER_HOST="localhost"
	#export DOCKER_HOST=tcp://172.16.42.43:4243
	export DOCKER_HOST=tcp://192.168.59.104:2375
fi
