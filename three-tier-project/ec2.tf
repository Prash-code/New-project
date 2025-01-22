## EC2 instace Web-tier ##

resource "aws_instance" "public-web-template" {
  ami = "ami-0d2614eafc1b0e4d2"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public-web-subnet-1.id
  vpc_security_group_ids = [aws_security_group.webserver-security-group.id]
  key_name = var.key_name
  user_data = file("install-apache.sh")

  tags = {
    Name = "web-asg"
  }
}

## EC2 instace App-tier ##

resource "aws_instance" "private-app-template" {
  ami = "ami-0d2614eafc1b0e4d2"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.private-app-subnet-1.id
  security_groups = [aws_security_group.ssh-security-group.id]
  key_name = "thor123"

  tags = {
    Name = "app-asg"
  }
}