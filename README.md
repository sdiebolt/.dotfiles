# Personal dotfiles

> [!NOTE]
> These dotfiles are tested and working on Ubuntu 25.10 and Arch Linux.

## Quick Start

The easiest way to install is using the bootstrap script, which will automatically:
- Detect your OS (Arch Linux or Ubuntu)
- Install Git and Ansible if needed
- Clone this repository
- Run the Ansible playbook

### One-line install

```bash
curl -fsSL https://raw.githubusercontent.com/sdiebolt/.dotfiles/main/bootstrap.sh | bash
```

### Or clone and run locally

```bash
git clone https://github.com/sdiebolt/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./bootstrap.sh
```

## Manual Installation

If you prefer to install manually, you can install Git and Ansible yourself and run the playbook directly.

### On Ubuntu 25.10

```bash
sudo apt update
sudo apt install -y git ansible
```

### On Arch Linux

```bash
sudo pacman -S git ansible
```

### Deploy dotfiles

```bash
git clone https://github.com/sdiebolt/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
ansible-playbook -K install.yml
```

## Advanced Usage

### Run specific roles only

```bash
ansible-playbook -K install.yml --tags nvim
```

### Skip specific roles

```bash
ansible-playbook -K install.yml --skip-tags fonts
```

### Check what would change (dry-run)

```bash
ansible-playbook -K install.yml --check
```
