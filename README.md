# Personal dotfiles

> [!NOTE]
> These dotfiles are tested and working on Ubuntu 25.10 and Arch Linux.

## Installing

To install all dependencies and deploy my dotfiles, you will need to install Git and Ansible.

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

Clone this repository and run the Ansible playbook:

```bash
git clone https://github.com/sdiebolt/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
ansible-playbook -K bootstrap.yml
```
