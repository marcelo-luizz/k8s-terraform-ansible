provider "aws" {
  region = "us-east-1"
  profile = "default"
}

resource "aws_key_pair" "k8s_key" {
  key_name = "k8s_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCzD4tk7eUpuPv2+VxcjXnh0i9m+S8IdMP2jeqfsXV5eRf3egKXEFyBYOldFhyWrTvhP+jUhUKJ9PZ5D2Zn5XOqtCJI3oCHd65Iwfu1H5C65Px7FjdGggRDifjRI/ShIgARo71vF0t91H9oPSyUTTSUVCiX6jY1XS6C8YsCNN0XPrWu3tqMncNjWpn+vLTs5anqx0fgqKSR9BZMGC8nmkijvotE8y0a4LNYPYi/00v5pY2WcswvpRPxDNBAz+WlWZ363sIin8FvdahaW96Z/qAt7zU/YLBC29g9S1nXugpbs8GlizfKsDk15AuQA4Wa3KBhQvUNgKUTOASMLjN909Rf vagrant@localhost.localdomain"
}

resource "aws_security_group" "k8s_security_group" {
  name = "k8s_security_group"
  description = "security groups kubernetes"
  
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self = true
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

} 

resource "aws_instance" "k8s_worker" {
  ami = "ami-08e4e35cccc6189f4"
  instance_type = "t2.micro"
  key_name = "k8s_key"
  count = 1
  tags = {
    "name" = "k8s"
    "type" = "worker"
  }
  security_groups = ["${aws_security_group.k8s_security_group.name}"]
}