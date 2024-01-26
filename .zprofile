export GOPATH=~/.go
export GOBIN=$GOPATH/bin
export PATH=$HOME/bin:$HOME/.rvm/bin:$GOBIN:$PATH
export HISTCONTROL=ignoredups
#export CLICOLOR=1
export GREP_OPTIONS='--color=auto'
export LSCOLORS=exgxcxdxbxegedabagacad
export LS_COLORS="di=34;40:ln=36;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:"

#stty -ixon

alias ls='ls -Ghl'
alias vim="nvim"
alias bf="~/butterfish/bin/butterfish"
alias bfsh="butterfish shell -m gpt-4-turbo-preview -vA"

setopt share_history


PROMPT=$'%F{magenta}%~ %(?.%F{green}.%F{red})ᐅ%F{white} '

export FZF_CTRL_R_OPTS="--bind=ctrl-t:down,ctrl-n:up"

bindkey "^t" up-line-or-history
bindkey "^n" down-line-or-history
bindkey "^h" backward-char
bindkey "^s" forward-char
bindkey "»" forward-char

# Color some common commands
alias colorify="grc -es --colour=auto"
alias configure='colorify ./configure'
alias diff='colorify diff'
alias make='colorify make'

eval $(brew shellenv)


export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


