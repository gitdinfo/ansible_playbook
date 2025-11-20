#!/bin/bash

# Mettez à jour les dépôts et installez sudo
apt update && apt install -y sudo

# Créer l'utilisateur 'useransible' sans mot de passe
echo "Création de l'utilisateur 'useransible' sans mot de passe..."
sudo useradd -m -s /bin/bash useransible 
sudo passwd -d  useransible


# Ajout de l'utilisateur au groupe sudo
sudo usermod -aG sudo useransible

# Configurer sudoers (fichier dédié propre et valide)
cat <<EOF > /etc/sudoers.d/useransible
useransible ALL=(ALL) NOPASSWD: /usr/bin/apt, /usr/bin/apt-get, /usr/bin/systemctl, /usr/bin/journalctl
EOF

chmod 440 /etc/sudoers.d/useransible


# Crée le dossier .ssh pour l'utilisateur useransible
mkdir -p /home/useransible/.ssh
chmod 700 /home/useransible/.ssh

# Ajouter une clé publique dans authorized_keys
echo "Ajout de la clé publique SSH pour useransible..."
public_key="ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBAE8+/WbEU4k4XOjibonO/cNAi56RdfocYbWAQHumYqaHlU00HKSKo/6ypr0Qyv9ab9cK2p0DhfmkxA9Lnf3sdqpqQGOkNHOIInTOh6HNbZ3MbS78+u+UfIzzU4CFmhd28cOzR63EAnGyNXlB6/2GyPvqEPtrAQKXPQ/kyms6Xyvn3Lv6g== root@linux"
echo "${public_key}" > /home/useransible/.ssh/authorized_keys
chmod 600 /home/useransible/.ssh/authorized_keys
chown -R useransible:useransible /home/useransible/.ssh
