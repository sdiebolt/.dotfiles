# Justfile for dotfiles management

# Show available recipes
default:
    @just --list

# Run playbook in check mode (dry-run)
test:
    @./test-playbook.sh

# Run full playbook in container (interactive)
test-full:
    @echo "🚀 Starting interactive test..."
    @docker run -it --rm \
        -v "{{justfile_directory()}}:/dotfiles" \
        -w /dotfiles \
        archlinux:latest \
        bash -c " \
            pacman -Syu --noconfirm && \
            pacman -S --noconfirm python ansible git && \
            ansible-galaxy collection install kewlfft.aur && \
            ansible-playbook -i localhost, -c local install.yml \
        "

# Get a shell in a fresh Arch Linux container
shell:
    @docker run -it --rm \
        -v "{{justfile_directory()}}:/dotfiles" \
        -w /dotfiles \
        archlinux:latest \
        bash

# Remove any leftover test containers
clean:
    @docker ps -a | grep dotfiles-test | awk '{print $$1}' | xargs -r docker rm -f || true
    @echo "✨ Cleaned up test containers"

# Run the playbook locally (requires Arch Linux)
install:
    ansible-playbook -i inventory install.yml

# Run syntax check only
syntax-check:
    ansible-playbook --syntax-check install.yml
