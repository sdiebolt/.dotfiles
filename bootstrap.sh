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
        ubuntu)
            OS_TYPE="ubuntu"
            ;;
        *)
            print_error "Unsupported OS: $OS"
            print_error "This script only supports Arch Linux and Ubuntu."
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

    case $OS_TYPE in
        arch)
            if [ "$need_git" = true ] || [ "$need_ansible" = true ]; then
                sudo pacman -Sy --noconfirm ${need_git:+git} ${need_ansible:+ansible}
            fi
            ;;
        ubuntu)
            sudo apt update
            if [ "$need_git" = true ]; then
                sudo apt install -y git
            fi
            if [ "$need_ansible" = true ]; then
                sudo apt install -y ansible
            fi
            ;;
    esac

    print_success "Dependencies installed successfully."
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

# Run Ansible playbook
run_playbook() {
    local dotfiles_dir="$HOME/.dotfiles"
    
    print_info "Running Ansible playbook..."
    cd "$dotfiles_dir"
    
    # Check if we should show help
    if [ "${1:-}" = "--help" ] || [ "${1:-}" = "-h" ]; then
        print_info "Available options:"
        echo "  --tags TAGS       Run only tasks with specific tags"
        echo "  --skip-tags TAGS  Skip tasks with specific tags"
        echo "  --check           Run in check mode (dry-run)"
        echo ""
        print_info "Example usage:"
        echo "  $0 --tags nvim        # Install only nvim"
        echo "  $0 --check            # See what would change"
        exit 0
    fi
    
    # Run playbook with any additional arguments passed to the script
    ansible-playbook -K install.yml "$@"
    
    print_success "Playbook execution completed!"
}

# Main function
main() {
    echo ""
    print_info "Dotfiles Bootstrap Script"
    echo ""
    
    detect_os
    install_dependencies
    setup_dotfiles
    run_playbook "$@"
    
    echo ""
    print_success "Bootstrap complete! Your system is ready."
    echo ""
}

# Run main function with all script arguments
main "$@"
