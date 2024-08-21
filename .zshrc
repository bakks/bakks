autoload -U compinit; compinit -i -C
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.openairc ] && source ~/.openairc
[ -f ~/.zprofile ] && source ~/.zprofile
[ -f ~/.secret ] && source ~/.secret


# Secretive Config
export SSH_AUTH_SOCK=/Users/pbakkum/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh

eval "$(am shell)"
