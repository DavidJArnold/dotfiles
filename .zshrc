PATH=$PATH:$HOME/.local/bin

eval "$(zoxide init zsh)"

eval "$(starship init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f ~/.config/aliases.sh ] && source ~/.config/aliases.sh

[ -f ~/.config/local_zshrc.sh ] && source ~/.config/local_zshrc.sh

setopt histignoredups

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"

[ -f "/home/david/.ghcup/env" ] && source "/home/david/.ghcup/env" # ghcup-env
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

