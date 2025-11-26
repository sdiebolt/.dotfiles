# Justfile for dotfiles management

# Show available recipes
default:
    @just --list

# Run full playbook in container
test:
    @./test-playbook.sh

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

# Run syntax check only
syntax-check:
    ansible-playbook --syntax-check install.yml
