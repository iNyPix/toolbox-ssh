#!/bin/sh

# Vérifie que 2 arguments sont fournis
if [ $# -ne 2 ]; then
  echo "Usage: $0 <port> <toolbox-name>"
  exit 1
fi

PORT=$1
NAME=$2

# Installer le serveur SSH
sudo dnf install --assumeyes openssh-server

# Générer les clés du serveur SSH si elles n'existent pas
sudo /usr/libexec/openssh/sshd-keygen rsa
sudo /usr/libexec/openssh/sshd-keygen ecdsa
sudo /usr/libexec/openssh/sshd-keygen ed25519

# Modifier le fichier de configuration SSH
echo "
# For VSCodium
Port $PORT
ListenAddress localhost
PermitEmptyPasswords yes
PermitUserEnvironment yes
" | sudo tee -a /etc/ssh/sshd_config

# Ajouter une entrée dans ~/.ssh/config
echo "
Host toolbox-$NAME
    HostName localhost
    Port $PORT
    # LocalForward 8000 localhost:8000 port forwarding symfony server.
" >> ~/.ssh/config

# Démarrer le serveur SSH
sudo /usr/sbin/sshd

echo "✅ SSH setup done. You can now connect with: ssh toolbox-$NAME"
