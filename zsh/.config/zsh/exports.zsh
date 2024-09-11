export EDITOR="nvim"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export PATH="$HOME/.local/bin":$PATH
export PATH="$HOME/.local/share/zap":$PATH
export PATH="$HOME/.cargo/bin":$PATH
export PATH="/opt/zotero":$PATH
export TERMINAL="kitty"

# Fix pip SSL cert validation.
export NODE_TLS_REJECT_UNAUTHORIZED='0'

# Rye
source "$HOME/.rye/env"

# Starship prompt
eval "$(starship init zsh)"

# zoxide
eval "$(zoxide init zsh)"

# fzf
export PATH="$HOME/.fzf/bin:$PATH"
source <(fzf --zsh)
export FZF_DEFAULT_COMMAND='fdfind --type f --strip-cwd-prefix --hidden --follow --exclude .git'

# Python virtual environments
export VIRTUALENVS="$HOME/.virtualenvs"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
