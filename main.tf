provider "aws" {
  profile = "terrform"
  region  = "ap-northeast-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0037237888be2fe22"
  instance_type = "t2.micro"
}
