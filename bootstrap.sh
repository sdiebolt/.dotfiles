#!/usr/bin/env bash

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print functions
print_info() {
    echo -e "${BLUE}==>${NC} $1"
}

print_success() {
    echo -e "${GREEN}==>${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}==>${NC} $1"
}

print_error() {
    echo -e "${RED}==>${NC} $1"
}

# Detect OS
detect_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$ID
    else
        print_error "Cannot detect OS. /etc/os-release not found."
        exit 1
    fi

    case $OS in
        arch|archlinux)
            OS_TYPE="arch"
            ;;
        *)
            print_error "Unsupported OS: $OS"
            print_error "This script only supports Arch Linux."
            exit 1
            ;;
    esac

    print_success "Detected OS: $OS_TYPE"
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install dependencies
install_dependencies() {
    print_info "Checking dependencies..."

    local need_git=false
    local need_ansible=false

    if ! command_exists git; then
        print_warning "Git not found. Will install."
        need_git=true
    fi

    if ! command_exists ansible; then
        print_warning "Ansible not found. Will install."
        need_ansible=true
    fi

    if [ "$need_git" = false ] && [ "$need_ansible" = false ]; then
        print_success "All dependencies already installed."
        return
    fi

    print_info "Installing dependencies for $OS_TYPE..."

    if [ "$need_git" = true ] || [ "$need_ansible" = true ]; then
        sudo pacman -Sy --noconfirm ${need_git:+git} ${need_ansible:+ansible}
    fi

    print_success "Dependencies installed successfully."
}

# Install Ansible collections
install_ansible_collections() {
    print_info "Installing required Ansible collections..."
    
    if ! ansible-galaxy collection list | grep -q "kewlfft.aur"; then
        print_info "Installing kewlfft.aur collection..."
        ansible-galaxy collection install kewlfft.aur
        print_success "kewlfft.aur collection installed."
    else
        print_success "kewlfft.aur collection already installed."
    fi
}

# Clone or update dotfiles
setup_dotfiles() {
    local dotfiles_dir="$HOME/.dotfiles"
    
    if [ -d "$dotfiles_dir" ]; then
        print_info "Dotfiles directory already exists at $dotfiles_dir"
        read -p "Do you want to update it? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            print_info "Updating dotfiles repository..."
            cd "$dotfiles_dir"
            git pull
            print_success "Dotfiles updated."
        fi
    else
        print_info "Cloning dotfiles repository..."
        git clone https://github.com/sdiebolt/.dotfiles.git "$dotfiles_dir"
        print_success "Dotfiles cloned to $dotfiles_dir"
    fi
}

# List available tags
list_tags() {
    local dotfiles_dir="$HOME/.dotfiles"
    cd "$dotfiles_dir"
    
    print_info "Available tags:"
    echo ""
    echo "  dotfiles      - Deploy dotfiles using GNU Stow"
    echo "  system-configs - Deploy system configuration files"
    echo "  packages      - Install packages (pacman, AUR)"
    echo "  custom-installs - Install tools requiring custom installation"
    echo "  opencode      - Install OpenCode editor"
    echo "  fonts         - Install fonts"
    echo "  ufw           - Install and configure UFW firewall"
    echo ""
    print_info "Example usage:"
    echo "  $0 --tags nvim              # Install only nvim"
    echo "  $0 --tags rust,cli          # Install rust and cli tools"
    echo "  $0 --skip-tags ufw          # Install everything except ufw"
}

# Run Ansible playbook
run_playbook() {
    local dotfiles_dir="$HOME/.dotfiles"
    
    print_info "Running Ansible playbook..."
    cd "$dotfiles_dir"
    
    # Check if we should list tags
    if [ "${1:-}" = "--list-tags" ]; then
        list_tags
        exit 0
    fi
    
    # Check if we should show help
    if [ "${1:-}" = "--help" ] || [ "${1:-}" = "-h" ]; then
        print_info "Available options:"
        echo "  --list-tags       List all available tags"
        echo "  --tags TAGS       Run only tasks with specific tags"
        echo "  --skip-tags TAGS  Skip tasks with specific tags"
        echo "  --check           Run in check mode (dry-run)"
        echo ""
        print_info "Example usage:"
        echo "  $0 --list-tags        # List all available tags"
        echo "  $0 --tags nvim        # Install only nvim"
        echo "  $0 --check            # See what would change"
        exit 0
    fi
    
    # Run playbook with any additional arguments passed to the script
    ansible-playbook -K install.yml "$@"
    
    local playbook_exit_code=$?
    
    if [ $playbook_exit_code -eq 0 ]; then
        print_success "Playbook execution completed!"
    else
        print_error "Playbook execution failed with exit code $playbook_exit_code"
        return $playbook_exit_code
    fi
}

# Main function
main() {
    echo ""
    print_info "Dotfiles Bootstrap Script"
    echo ""
    
    detect_os
    install_dependencies
    install_ansible_collections
    setup_dotfiles
    run_playbook "$@"
    
    echo ""
    print_success "Bootstrap complete! Your system is ready."
    echo ""
    print_info "Post-installation notes:"
    echo "  • If your shell was changed, log out and log back in to see the change"
    echo "  • For Neovim plugins to work, open nvim and run :Lazy sync"
    echo ""
}

# Run main function with all script arguments
main "$@"
