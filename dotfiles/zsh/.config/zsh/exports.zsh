export ZSHRC="$HOME/.zshrc"
export EDITOR="nvim"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export PATH="$HOME/.local/bin":$PATH
export PATH="$HOME/.local/share/zap":$PATH
export PATH="$HOME/.cargo/bin":$PATH
export TERMINAL="wezterm"
export TERM=xterm-256color

# Fix pip SSL cert validation.
export NODE_TLS_REJECT_UNAUTHORIZED=1

# Starship prompt
eval "$(starship init zsh)"

# zoxide
eval "$(zoxide init zsh)"

# fzf
export PATH="$HOME/.fzf/bin:$PATH"
source <(fzf --zsh)
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# Python virtual environments
export VIRTUALENVS="$HOME/.virtualenvs"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# opencode
export PATH=/home/sdiebolt/.opencode/bin:$PATH

# Setup rustup shell
. "$HOME/.cargo/env"

# Zellij completions
. <( zellij setup --generate-completion zsh | sed -Ee 's/^(_(zellij) ).*/compdef \1\2/' )

# Sheldon completions
. <( sheldon completions --shell zsh )
