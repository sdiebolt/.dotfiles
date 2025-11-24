# Enable vim mode in zsh.
bindkey -v

# Enable line search using up/down arrows.
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# Source cargo env before calling sheldon, otherwise it won't be in PATH.
. "$HOME/.cargo/env"

# Load plugins via Sheldon.
eval "$(sheldon source)"
