export GOPATH=~/.go
export GOBIN=$GOPATH/bin
export PATH=$HOME/bin:$HOME/.rvm/bin:$GOBIN:$PATH
export HISTCONTROL=ignoredups
export CLICOLOR=1
export GREP_OPTIONS='--color=auto'
export LSCOLORS=exgxcxdxbxegedabagacad
export LS_COLORS="di=34;40:ln=36;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:"

if hash git 2>/dev/null; then  # make sure git exists
  git config --global --add color.ui true
fi

PS1='[\[\e[0;36m\]\h\[\e[m\] \[\e[0;35m\]\w\[\e[m\]] \[\e[0;32m\]\$\[\e[m\] \[\e[0m\]'

# bash only
complete -W "$(echo `cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | grep -v "\["`;)" ssh

