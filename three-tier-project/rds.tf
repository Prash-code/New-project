resource "aws_db_subnet_group" "databse-subnet-group" {
  name = "database-subnet"
  subnet_ids = [aws_subnet.private-db-subnet-1.id, aws_subnet.private-db-subnet-2.id]
  description = "subnet group for databse instance"

  tags = {
    Name = "Database-subnets"
  }
}

## Database instance ##

resource "aws_db_instance" "database-instance" {
 allocated_storage = 10
 engine = "mysql"
 engine_version = "8.0.32"
 instance_class = var.database-instance-class
 db_name = "mydb"
 username = var.rds_username
 password = var.rds_password
 skip_final_snapshot = true
 availability_zone = "ap-south-1a"
 db_subnet_group_name = aws_db_subnet_group.databse-subnet-group.name
 multi_az = false
 vpc_security_group_ids = [aws_security_group.database-security-group.id]
}