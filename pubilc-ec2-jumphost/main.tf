resource "aws_instance" "prash" {
  ami = "ami-0d2614eafc1b0e4d2"
  instance_type = "t2.micro"
  key_name = "thor123"
}