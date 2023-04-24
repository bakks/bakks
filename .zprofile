export GOPATH=~/.go
export GOBIN=$GOPATH/bin
export PATH=$HOME/bin:$HOME/.rvm/bin:$GOBIN:$PATH
export HISTCONTROL=ignoredups
#export CLICOLOR=1
export GREP_OPTIONS='--color=auto'
export LSCOLORS=exgxcxdxbxegedabagacad
export LS_COLORS="di=34;40:ln=36;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:"

#stty -ixon

alias ls='gls -hl --color=auto'
alias vim="nvim"
alias bf="butterfish"

setopt share_history


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/google-cloud-sdk/path.zsh.inc' ]; then source '/opt/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/opt/google-cloud-sdk/completion.zsh.inc' ]; then source '/opt/google-cloud-sdk/completion.zsh.inc'; fi

PS1="%F{magenta}%~ %(?.%F{green}.%F{red})ᐅ%F{white} "
export PROFILE="%F{magenta}%~ %(?.%F{green}.%F{red})ᐅ%F{white} "

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

