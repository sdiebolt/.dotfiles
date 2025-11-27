export ZSHRC="$HOME/.zshrc"
export TERMINAL="ghostty"
export EDITOR="nvim"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export PATH="$HOME/.local/bin":$PATH
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
source /usr/share/nvm/init-nvm.sh

# opencode
export PATH=/home/sdiebolt/.opencode/bin:$PATH

# Setup rustup shell
. "$HOME/.cargo/env"

# Zellij completions
. <( zellij setup --generate-completion zsh | sed -Ee 's/^(_(zellij) ).*/compdef \1\2/' )

# Sheldon completions
. <( sheldon completions --shell zsh )
