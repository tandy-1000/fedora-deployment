# An Ansible playbook to setup a Fedora install

```
ansible-playbook roles.yml -i inventory.yml --ask-vault-pass -e "device={name}"
```