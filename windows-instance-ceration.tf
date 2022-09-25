provider "aws" {
  profile    = "terraform_user"
  access_key = "***********"
  secret_key = "*************"
  region     = "us-east-2"
}

resource "aws_instance" "windows" {
  ami = "ami-02bddcf6b9473bd61"
  tags = {
    Name = "windows-computer"
  }
  instance_type = "t2.micro"
  key_name      = "terraform-windows"
}

resource "aws_security_group" "allow_rdp" {
  name        = "allow_rdp"
  description = "allow_rdp traffic"
  ingress {
    from_port = 3389 # by default, the windows server listens to tcp port 3389 for rdp
    to_port   = 3389
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }
}
