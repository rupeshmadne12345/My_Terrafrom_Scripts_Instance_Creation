provider "aws" {
  profile    = "terraform_user"
  access_key = "**********"
  secret_key = "************"
  region     = "us-east-2"
}

resource "aws_instance" "linux" {
  ami = "ami-0568773882d492fc8"
  tags = {
    Name = "linux-computer"
  }
  instance_type   = "t2.micro"
  key_name        = "terraform-linux"
  security_groups = ["${aws_security_group.allow_ssh.name}"]
}

resource "aws_security_group" "allow_ssh" {
  tags = {
    Name = "ALLOW_SSH"
  }
  name        = "allow_ssh"
  description = "allow ssh traffic"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

