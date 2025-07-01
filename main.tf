provider "aws" {
  region  = "us-east-2"
  profile = "default"
}

resource "aws_key_pair" "chave_ssh" {
  key_name   = "key_aws"
  public_key = file("C:/Users/Giovanne/.ssh/id_rsa.pub") # Ou caminho para sua chave pública
}

resource "aws_security_group" "acesso_ssh" {
  name_prefix = "ssh-"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Pode restringir à sua rede depois
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "local" {
  ami           = "ami-04308cf1267e3183c"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.chave_ssh.key_name
  vpc_security_group_ids = [aws_security_group.acesso_ssh.id]

  tags = {
    Name = "HomeLab-Debian"
  }
}