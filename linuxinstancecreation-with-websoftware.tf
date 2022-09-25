# provider information

provider "aws" {
  profile    = "terraform_user"
  access_key = "*********"
  secret_key = "*************"
  region     = "us-east-2"
}

# terraform code to spin up EC2 instance 

resource "aws_instance" "linux" {
  ami             = "ami-0568773882d492fc8"
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.allow_ssh_http.name}"]
  tags = {
    Name = "linux-computer"
  }
  key_name = "terraform-linux"

  # userdata shell script in aws Ec2 by using terraform

  user_data = file("script.sh")
}

# creating a security group

resource "aws_security_group" "allow_ssh_http" {
  tags = {
    Name = "ALLOW_SSH_HTTP"
  }
  name        = "allow_ssh_http"
  description = "allow shh & http traffic"
  vpc_id      = "vpc-***************"

  ingress {
    description      = "allow ssh from vpc"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "allow http from vpc"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
