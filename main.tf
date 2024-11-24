provider "aws" {
  profile = "terrform"
  region  = "ap-northeast-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0146fc9ad419e2cfd"
  instance_type = "t2.micro"
}
