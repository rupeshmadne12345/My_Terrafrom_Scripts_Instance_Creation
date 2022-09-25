provider "aws" {
  profile    = "terraform_user"
  access_key = "*********"
  secret_key = "***********"
  region     = "us-east-2"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "my-tf-test-bucket-rups"
  tags = {
    Name        = "My bucket"
    Environment = "Test"
  }
}
