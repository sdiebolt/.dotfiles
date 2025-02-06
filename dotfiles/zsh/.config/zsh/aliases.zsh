# bat
alias cat="bat --theme "Dracula" --color always"

# ncdu
alias du="ncdu --color dark -rr -x"

# fzf 
alias pfzf="fzf --preview 'bat -n --color=always {}'"

# lsd
alias ls="lsd"
alias ll="ls -l"
alias la="ls -a"
alias lt="ls --tree"
alias lla="ls -la"
alias lat="la --tree"
alias llt="ll --tree"
alias llat="lla --tree"

# git
alias g="git"
alias glg="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"
alias ga="git add"
alias gaa="git add --all"
alias gap="git add --patch"
alias gau="git add --update"
alias gb="git branch"
alias gba="git branch -a"
alias gbd="git branch -d"
alias gbD="git branch -D"
alias gbl="git blame -b -w"
alias gbs="git bisect"
alias gbsb="git bisect bad"
alias gbsg="git bisect good"
alias gbsr="git bisect reset"
alias gbss="git bisect start"
alias gc="git commit -v"
alias gc!="git commit -v --amend"
alias gcn!="git commit -v --no-edit --amend"
alias gca="git commit -v -a"
alias gca!="git commit -v -a --amend"
alias gcan!="git commit -v -a --no-edit --amend"
alias gcb="git checkout -b"
alias gcf="git config --list"
alias gcl="git clone --recursive"
alias gco="git checkout"
alias gcp="git cherry-pick"
alias gcpa="git cherry-pick --abort"
alias gcpc="git cherry-pick --continue"
alias gd="git diff"
alias gds="git diff --staged"
alias grv="git remote -v"
alias gsh="git show"
alias gss="git status -s"
alias gst="git status"
alias gl="git pull"
alias gp="git push"

# ping
alias ping="prettyping --nolegend"

# top
alias top="btop"

# neovim
alias vim="nvim"
alias vi="nvim"
