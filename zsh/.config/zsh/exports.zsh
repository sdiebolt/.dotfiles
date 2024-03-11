export EDITOR="vim"
export TERMINAL="alacritty"
export PATH="$HOME/.local/bin":$PATH
export PATH="$HOME/.local/share/zap":$PATH
export PATH="$HOME/.cargo/bin":$PATH
export PATH="/opt/zotero":$PATH
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
# Fix pip SSL cert validation.
export NODE_TLS_REJECT_UNAUTHORIZED='0'

# Rye
source "$HOME/.rye/env"

# Starship prompt
eval "$(starship init zsh)"

# zoxide
eval "$(zoxide init zsh)"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
