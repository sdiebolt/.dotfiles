# Setup fzf
# ---------
if [[ ! "$PATH" == */home/sdiebolt/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/sdiebolt/.fzf/bin"
fi

# Auto-completion
# ---------------
source "/home/sdiebolt/.fzf/shell/completion.zsh"

# Key bindings
# ------------
source "/home/sdiebolt/.fzf/shell/key-bindings.zsh"
