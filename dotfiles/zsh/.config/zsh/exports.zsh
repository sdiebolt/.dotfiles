export ZSHRC="$HOME/.zshrc"
export TERMINAL="ghostty"
export EDITOR="nvim"
export PATH="$HOME/.local/bin":$PATH

if [[ $OSTYPE == linux* ]]; then
    export LC_ALL=en_US.UTF-8
    export LANG=en_US.UTF-8
    export LANGUAGE=en_US.UTF-8
    export TERM=xterm-256color
fi

# Fix pip SSL cert validation.
export NODE_TLS_REJECT_UNAUTHORIZED=1

# Starship prompt
if (( $+commands[starship] )); then
    eval "$(starship init zsh)"
fi

# zoxide
if (( $+commands[zoxide] )); then
    eval "$(zoxide init zsh)"
fi

# fzf
if (( $+commands[fzf] )); then
    source <(fzf --zsh)
fi
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# Python virtual environments
export VIRTUALENVS="$HOME/.virtualenvs"

# mise
if (( $+commands[mise] )); then
    eval "$(mise activate zsh)"
fi

# opencode
export PATH="$HOME/.opencode/bin:$PATH"

# Zellij completions
if (( $+commands[zellij] )); then
    . <( zellij setup --generate-completion zsh | sed -Ee 's/^(_(zellij) ).*/compdef \1\2/' )
fi

# Sheldon completions
. <( sheldon completions --shell zsh )

# Pixi
export PATH="$HOME/.pixi/bin:$PATH"

if [[ $OSTYPE == linux* ]]; then
    # GNOME Keyring SSH agent
    export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gcr/ssh"

    # CUDA
    export PATH="/opt/cuda/bin:$PATH"
    export CUDA_HOME="/opt/cuda"

    # Vcpkg
    export VCPKG_ROOT="$HOME/.local/vcpkg"
    export VCPKG_DEFAULT_TRIPLET=x64-linux
fi
