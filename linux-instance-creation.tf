provider "aws" {
  profile    = "terraform_user"
  access_key = "********"
  secret_key = "************"
  region     = "us-east-2"
}

resource "aws_instance" "linux" {
  ami = "ami-0535d9b70179f9734"
  tags = {
    Name = "linux-computer"
  }
  instance_type = "t2.micro"
  key_name      = "terrafrom-linux"
}

resource "aws_security_group" "allow_ssh" {
  tags = {
    Name = "Allow_SSH"
  }
  name        = "allow_ssh"
  description = "allow ssh traffic"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }
}
