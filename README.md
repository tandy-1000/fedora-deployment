# An Ansible playbook to setup a Fedora install

```
ansible-galaxy collection install ansible.posix community.general community.crypto

ansible-playbook roles.yml -i inventory.yml --ask-vault-pass -e "device={name}"
```

Currently takes care of:
- [x] DNF configuration
- [x] Installing useful packages
- [x] Snapper configuration
- [x] /etc/hosts configuration
- [x] Setting up SSH keys for home server
- [x] Setting up a WireGuard configuration
- [x] Setting up NFS mounts
- [x] Loading dotfiles with Chezmoi
- [x] Btrbk configuration
