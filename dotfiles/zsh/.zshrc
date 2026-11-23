# Enable vim mode in zsh.
bindkey -v

# Enable line search using up/down arrows.
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# Make Homebrew tools available before loading Sheldon, including in non-login shells.
if [[ $OSTYPE == darwin* ]]; then
    if (( $+commands[brew] )); then
        eval "$(brew shellenv zsh)"
    elif [[ -x /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv zsh)"
    elif [[ -x /usr/local/bin/brew ]]; then
        eval "$(/usr/local/bin/brew shellenv zsh)"
    fi
fi

# Sheldon may have been installed with Cargo.
[[ -r "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# Load plugins via Sheldon.
if (( $+commands[sheldon] )); then
    sheldon_source=$(sheldon source) && eval "$sheldon_source"
    unset sheldon_source
fi

# Load the Mac's developer shell integration if installed.
if [[ $OSTYPE == darwin* && -r "$HOME/.local/share/merge_io/dev_niceties/init.zsh.inc" ]]; then
    source "$HOME/.local/share/merge_io/dev_niceties/init.zsh.inc"
fi
