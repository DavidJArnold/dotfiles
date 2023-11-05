PATH=$PATH:$HOME/.local/bin

eval "$(zoxide init zsh)"

eval "$(starship init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f ~/.config/aliases.sh ] && source ~/.config/aliases.sh

[ -f ~/.config/local_zshrc.sh ] && source ~/.config/local_zshrc.sh

setopt histignoredups

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f "/home/david/.ghcup/env" ] && source "/home/david/.ghcup/env" # ghcup-env
