#!/bin/bash

set -euo pipefail

usage() {
    echo "Usage: $0 [--check]"
    echo "Install Homebrew dependencies and link the shared macOS dotfiles."
    echo "Use --check to preview links and list missing packages."
}

case "${1:-}" in
    --help|-h) usage; exit 0 ;;
    --check|"") ;;
    *) usage >&2; exit 2 ;;
esac
if [[ $# -gt 1 ]]; then
    usage >&2
    exit 2
fi

if [[ $(uname -s) != Darwin ]]; then
    echo "Run this installer on macOS. On Arch, use ./bootstrap.sh." >&2
    exit 1
fi

if command -v brew >/dev/null; then
    brew_bin=$(command -v brew)
elif [[ -x /opt/homebrew/bin/brew ]]; then
    brew_bin=/opt/homebrew/bin/brew
elif [[ -x /usr/local/bin/brew ]]; then
    brew_bin=/usr/local/bin/brew
else
    echo "Install Homebrew first using https://brew.sh/." >&2
    exit 1
fi
brew_env=$("$brew_bin" shellenv bash)
eval "$brew_env"

macos_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
bundle_args=(--file="$macos_dir/Brewfile" --no-upgrade)
shared_stow=(--dir="$macos_dir/../dotfiles" --target="$HOME"
    zsh sheldon starship nvim zellij bat btop lsd mise uv)
macos_stow=(--dir="$macos_dir/dotfiles" --target="$HOME" git ghostty)

preview_links() {
    local status=0
    stow --simulate --verbose "${shared_stow[@]}" || status=1
    stow --simulate --verbose "${macos_stow[@]}" || status=1
    return "$status"
}

if [[ ${1:-} == --check ]]; then
    status=0
    if command -v stow >/dev/null; then
        preview_links || status=1
    else
        echo "Install GNU Stow to preview dotfile links." >&2
        status=1
    fi
    "$brew_bin" bundle check --verbose "${bundle_args[@]}" || status=1
    exit "$status"
fi

if ! command -v stow >/dev/null; then
    "$brew_bin" install stow
fi
preview_links
"$brew_bin" bundle install "${bundle_args[@]}"
stow "${shared_stow[@]}"
stow "${macos_stow[@]}"
echo "Dotfiles linked. Open a new Zsh session to load them."
