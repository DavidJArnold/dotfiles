PATH=$PATH:$HOME/.local/bin

[ -f ~/.config/aliases.sh ] && source ~/.config/aliases.sh

[ -f ~/.config/local_zshrc.sh ] && source ~/.config/local_zshrc.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

eval "$(zoxide init bash)"

eval "$(starship init bash)"

. "$HOME/.cargo/env"
. "$HOME/.atuin/bin/env"

[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
eval "$(atuin init bash)"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
