data "aws_ami" "amzlinux" {
  most_recent = true
  owners = [ "amazon" ]
  filter {
    name = "name"
    values = [ "amzn2-ami-hvm-*-gp2" ]
  }
  filter {
    name = "root-device-type"
    values = [ "ebs" ]
  }
  filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }
  filter {
    name = "architecture"
    values = [ "x86_64" ]
  }
}


# Launch Template Resource
resource "aws_launch_template" "frontend" {
  name = "frontend-terraform"
  description = "frontend-terraform"
  image_id = data.aws_ami.amzlinux.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.frontend-server-sg.id]
  key_name = "project-key" #chnage the key 
  user_data = base64encode(file("${path.module}/install-frontend.sh"))
  #default_version = 1
  update_default_version = true
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "frontend-terraform"
    }
  }
}

###################################################################################
data "aws_ami" "amzlinux1" {
  most_recent = true
  owners = [ "amazon" ]
  filter {
    name = "name"
    values = [ "amzn2-ami-hvm-*-gp2" ]
  }
  filter {
    name = "root-device-type"
    values = [ "ebs" ]
  }
  filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }
  filter {
    name = "architecture"
    values = [ "x86_64" ]
  }
}



# Launch Template Resource
resource "aws_launch_template" "backend" {
  name = "backend-terraform"
  description = "backend-terraform"
  image_id = data.aws_ami.amzlinux1.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.backend-server-sg.id]
  key_name = "project-key" 
  user_data = filebase64("${path.module}/install-backend.sh")
  #default_version = 1
  update_default_version = true
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "backend-terraform"
    }
  }
}