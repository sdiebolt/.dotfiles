# Enable vim mode in zsh
bindkey -v

# Enable line search using up/down arrows
bindkey "$terminfo[kcuu1]" up-line-or-beginning-search # Up
bindkey "$terminfo[kcud1]" down-line-or-beginning-search # Down

# Load plugins via Sheldon
eval "$(sheldon source)"
