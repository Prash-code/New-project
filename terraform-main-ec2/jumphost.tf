#create EC2
resource "aws_instance" "prash" {
  ami = var.ami_id
  instance_type = var.instance_type
  key_name = var.key_name
  subnet_id = aws_subnet.prash.id
  tags = {
  Name = "server-1"
  }
   user_data = templatefile("./install-tool.sh", {})

}