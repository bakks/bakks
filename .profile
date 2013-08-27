export GOPATH=$HOME/.go
export PATH=$HOME/bin:$PATH:$GOPATH/bin

PS1='[\[\e[0;36m\]\h\[\e[m\] \[\e[0;35m\]\w\[\e[m\]] \[\e[0;32m\]\$\[\e[m\] \[\e[0m\]'

complete -W "$(echo `cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | grep -v "\["`;)" ssh

export HISTCONTROL=ignoredups

