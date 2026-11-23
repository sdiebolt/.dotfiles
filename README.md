# Personal dotfiles

> [!NOTE]
> The full workstation setup targets Arch Linux. macOS has a separate installer for the shared developer tools.

## Quick Start

### macOS

Install [Homebrew](https://brew.sh/) first. From a checkout of this repository, use the macOS installer.

```bash
./macos/install.sh
```

The installer checks for Stow conflicts before installing the Brewfile packages or
linking configs. If Stow reports a conflict, review and back up the existing file before
moving it aside or merging its contents.

### Arch Linux

The easiest way to install is using the bootstrap script, which will automatically:
- Detect your OS (Arch Linux)
- Install Git and Ansible if needed
- Clone this repository
- Run the Ansible playbook

#### One-line install

```bash
curl -fsSL https://raw.githubusercontent.com/sdiebolt/.dotfiles/master/bootstrap.sh | bash
```

#### Or clone and run locally

```bash
git clone https://github.com/sdiebolt/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./bootstrap.sh
```

## Manual Installation

If you prefer to install manually, you can install Git and Ansible yourself and run the playbook directly.

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

On Arch, the bootstrap passes `--check` to Ansible.

```bash
./bootstrap.sh --check
```

If you already have the bootstrap dependencies, you can run the playbook directly.

```bash
ansible-playbook -K install.yml --check
```

On macOS, `--check` lists missing Homebrew packages and previews links when Stow
is available. It exits nonzero for missing dependencies or link conflicts.

```bash
./macos/install.sh --check
```
