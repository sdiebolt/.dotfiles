# Personal dotfiles

> [!CAUTION]
> I am currently using these dotfiles on Ubuntu 24.04 only. Use at your own risk.

## Installing

To install all dependencies and deploy my dotfiles, you will need to install Git and
Ansible. You can install them using the following commands:

```bash
sudo apt update
sudo apt install -y git ansible
```

Then, clone this repository and run the Ansible playbook:

```bash
git clone https://github.com/sdiebolt/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
ansible-playbook -K bootstrap.yml
```
