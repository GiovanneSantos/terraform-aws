# 🏠 HomeLab Provisionamento de Infraestrutura

Este projeto consiste no provisionamento automatizado de infraestrutura para um ambiente **HomeLab**. O objetivo principal é criar uma estrutura de máquinas voltada para:

- Desenvolvimento pessoal
- Ganho de experiência prática em infraestrutura e DevOps
- Simulação de ambientes corporativos

## ✨ Objetivos

- Criar e configurar uma instância na AWS automaticamente com Terraform
- Automatizar o setup inicial com um script em Bash (`setup.sh`)
- Criar usuário padrão de acesso (ex: `devops`)
- Instalar ferramentas essenciais para administração e desenvolvimento
- Aumentar a segurança desabilitando acesso SSH ao root e configurando firewall (UFW)
- Instalar Docker, Docker Compose e dependências básicas para futuros projetos

## 📦 Estrutura

📁 infra/
├── main.tf
├── variables.tf
├── setup.sh.tpl
├── terraform.tfvars
└── .env


## 🚀 Tecnologias e Ferramentas

- Terraform
- AWS EC2
- Bash Script
- UFW Firewall
- Docker e Docker Compose

## 🔐 Acesso

A conexão SSH é configurada para o usuário `devops`, criado automaticamente via script. O acesso root via SSH é desabilitado por padrão.

```bash
ssh devops@<ip_da_instancia>
