#!/bin/bash
exec > >(tee /var/log/user-data.log | logger -t user-data -s 2>/dev/console) 2>&1
set -euxo pipefail

echo "[INFO] Iniciando setup..."

cat <<EOF > /etc/apt/sources.list
deb http://deb.debian.org/debian bullseye main contrib non-free
deb http://deb.debian.org/debian bullseye-updates main contrib non-free
deb http://security.debian.org/debian-security bullseye-security main contrib non-free
EOF

apt-get update -y

apt-get install -y sudo curl gnupg lsb-release python3 python3-pip ca-certificates

if ! id -u devops >/dev/null 2>&1; then
    useradd -m -s /bin/bash devops
fi
usermod -aG sudo devops
echo "devops ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/devops
chmod 440 /etc/sudoers.d/devops

mkdir -p /home/devops/.ssh
cat <<EOKEY > /home/devops/.ssh/authorized_keys
${public_key}
EOKEY
chown -R devops:devops /home/devops/.ssh
chmod 700 /home/devops/.ssh
chmod 600 /home/devops/.ssh/authorized_keys

sed -i 's/^PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config || echo "PermitRootLogin no" >> /etc/ssh/sshd_config
systemctl restart ssh || systemctl restart sshd || true

install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
| tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin || echo "[ERRO] Falha ao instalar Docker"

usermod -aG docker devops

curl -L "https://github.com/docker/compose/releases/download/v2.24.6/docker-compose-$(uname -s)-$(uname -m)" \
-o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

python3 -m pip install --upgrade pip
python3 -m pip install ansible

apt-get install -y \
  git make build-essential wget unzip nano vim tmux \
  lsof net-tools htop rsync jq tree zsh \
  dnsutils traceroute netcat nmap telnet \
  fail2ban logrotate sysstat ncdu iotop \
  default-jdk silversearcher-ag ufw || true

# ufw default deny incoming
# ufw default allow outgoing
# ufw allow OpenSSH
# ufw --force enable

mkdir -p /home/devops/monitoring /home/devops/apis /home/devops/cronjobs
chown -R devops:devops /home/devops

echo "[INFO] Setup finalizado!"
