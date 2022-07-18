provider "aws" {
  region = "us-east-1"
  profile = "default"
}

resource "aws_key_pair" "k8s_key" {
  key_name = "k8s_key"
  public_key = ""
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
