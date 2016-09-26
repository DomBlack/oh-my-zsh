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

function nextfreeport()
{
	for port in $(seq $1 65000); do; (netstat -ant | grep ".$port ") > /dev/null; if [ $? -eq 1 ]; then; echo "$port" && break; fi; done
}

function tssh() { /usr/bin/ssh -t $@ "tmux attach || tmux new";}

# 0 -- vanilla completion (abc => abc)
# 1 -- smart case completion (abc => Abc)
# 2 -- word flex completion (abc => A-big-Car)
# 3 -- full flex completion (abc => ABraCadabra)
zstyle ':completion:*' matcher-list '' \
  'm:{a-z\-}={A-Z\_}' \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
  'r:|?=** m:{a-z\-}={A-Z\_}'

function prj()
{
  CDPATH=.:~/workspace:~/projects:~/workspace/github && cd $1 > /dev/null;
}
compctl -M 'm:{a-z\-}={A-Z\_} r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_} r:|?=** m:{a-z\-}={A-Z\_}'  -W "(/Users/dom/workspace/ /Users/dom/projects/ /Users/dom/workspace/github/)" -/ prj

# Search for files and page it
function search() { find . -iname "*$@*" | less; }

#  -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=$(nextfreeport 9010) -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.local.only=true -Djava.rmi.server.hostname=127.0.0.1
alias sbt7='export NO_FORK=true && JAVA_HOME=$(/usr/libexec/java_home -v 1.7.0) && sbt -jvm-debug $(nextfreeport 5005)'
alias sbt8='export NO_FORK=true && JAVA_HOME=$(/usr/libexec/java_home -v 1.8.0) && sbt -jvm-debug $(nextfreeport 5005)'

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
	export PATH=$PATH:/usr/local/var/rbenv/versions/1.9.3-p125/bin
	export PATH="$PATH:$(brew --prefix icu4c)/bin"
	rbenv rehash 2>/dev/null

  # PERL_MM_OPT="INSTALL_BASE=$HOME/perl5" cpan local::lib
  # echo 'eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"' >> ~/.bash_profile
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

#	export VAGRANT_HOME="/Volumes/External Data/VagrantHome"
export VAGRANT_HOME="/Users/dom/VMs/VagrantHome"
	export CLOSURE_PATH="$(brew --prefix closure-compiler)/libexec/"
	export JAVA_HOME=$(/usr/libexec/java_home -v 1.8.0)
	export SCALA_HOME=/usr/local/opt/scala/idea
fi

[ -f /Users/dom/.oh-my-zsh/.private ] && source /Users/dom/.oh-my-zsh/.private

# added by travis gem
[ -f /Users/dom/.travis/travis.sh ] && source /Users/dom/.travis/travis.sh
