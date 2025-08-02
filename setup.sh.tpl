#!/bin/bash

# Atualizando sistema
apt update && apt upgrade -y

# Criando usuário devops
useradd -m -s /bin/bash devops

# Adicionando ao grupo sudo e liberando sudo sem senha
usermod -aG sudo devops
echo 'devops ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/devops
chmod 440 /etc/sudoers.d/devops

# Criando diretório .ssh e adicionando chave pública
mkdir -p /home/devops/.ssh
echo "${public_key}" > /home/devops/.ssh/authorized_keys
chown -R devops:devops /home/devops/.ssh
chmod 700 /home/devops/.ssh
chmod 600 /home/devops/.ssh/authorized_keys

# Desabilitando login root via SSH
sed -i 's/^PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
systemctl restart ssh

# Instalando dependências essenciais
apt install -y ca-certificates curl gnupg lsb-release software-properties-common \
  git make build-essential wget unzip nano vim tmux lsof net-tools htop rsync jq tree \
  zsh dnsutils traceroute netcat nmap telnet fail2ban logrotate sysstat ncdu iotop \
  python3 python3-pip default-jdk silversearcher-ag ufw

# Configurando firewall UFW
ufw default deny incoming
ufw default allow outgoing
ufw allow OpenSSH
ufw --force enable

# Instalando Docker (repositório para Debian)
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt update
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Adicionando devops ao grupo docker
usermod -aG docker devops

# Instalando Docker Compose manualmente (opcional)
curl -L "https://github.com/docker/compose/releases/download/v2.24.6/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Criando diretórios padrão para projetos
mkdir -p /home/devops/monitoring /home/devops/apis /home/devops/cronjobs
chown -R devops:devops /home/devops
