#!/bin/bash
# Test the Ansible playbook locally using Docker

set -e

CONTAINER_NAME="dotfiles-test"
IMAGE="archlinux:latest"
TEST_USER="testuser"

echo "🚀 Starting Arch Linux container..."
docker run -d \
  --name "$CONTAINER_NAME" \
  --rm \
  -v "$(pwd):/dotfiles" \
  -w /dotfiles \
  "$IMAGE" \
  sleep infinity

# Cleanup function
cleanup() {
  echo "🧹 Cleaning up..."
  docker stop "$CONTAINER_NAME" 2>/dev/null || true
}
trap cleanup EXIT

echo "📦 Installing dependencies in container..."
docker exec "$CONTAINER_NAME" bash -c "
  pacman -Syu --noconfirm
  pacman -S --noconfirm python ansible git sudo
"

echo "👤 Creating test user with sudo privileges..."
docker exec "$CONTAINER_NAME" bash -c "
  useradd -m -G wheel -s /bin/bash $TEST_USER
  echo '%wheel ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/wheel
"

echo "🎯 Installing Ansible collections..."
docker exec -u "$TEST_USER" "$CONTAINER_NAME" bash -c "
  ansible-galaxy collection install kewlfft.aur
"

echo "✅ Running syntax check..."
docker exec -u "$TEST_USER" "$CONTAINER_NAME" bash -c "
  ansible-playbook --syntax-check install.yml
"

echo "🚀 Running full playbook installation..."
docker exec -u "$TEST_USER" "$CONTAINER_NAME" bash -c "
  ansible-playbook -i localhost, -c local install.yml
"

echo ""
echo "✨ Installation completed successfully!"
echo ""
echo "🐚 To get a shell in the container as $TEST_USER, use:"
echo "   docker exec -it -u $TEST_USER $CONTAINER_NAME bash"
echo ""
echo "Press Ctrl+C to stop the container..."
wait
