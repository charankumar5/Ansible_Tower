#!/bin/bash

# Update package lists
sudo apt update

# Upgrade packages
sudo apt upgrade --yes

# Install pipx
#sudo apt install pipx --yes

# Install ansible using pipx
#pipx install --include-deps ansible 

#add the global path automatically.
#pipx ensurepath
sudo apt install ansible
#check ansible version
ansible --version

# Install ansible-core using pipx
#pipx install ansible-core --yes

# Upgrade ansible using pipx
#pipx upgrade --include-injected ansible --yes

# Inject argcomplete for ansible using pipx
#pipx inject ansible argcomplete --yes

# Create and populate the inventory file
sudo tee /etc/ansible/inventory > /dev/null <<EOF
[servers]
192.168.178.32 ansible_user=pi
34.29.145.143 ansible_user=devops.path123
34.29.139.137 ansible_user=devops.path123
34.31.179.107 ansible_user=devops.path123
EOF

# Generate SSH key
ssh-keygen -t ed25519 -C "rbac_key_local"

# Add SSH key to SSH agent (if needed)
eval "$(ssh-agent -s)"
ssh-add ~/.ssh

# Ping all servers using Ansible
ansible servers -i /etc/ansible/inventory -m ping
