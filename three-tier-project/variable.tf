## VPC CIDR Block ##

variable "vpc_cidr" {
  default = "192.168.0.0./16"
  description = "VPC_cidr_block"
  type = string
}

## Presentation Tier CIDR block-1 ##

variable "public-web-subnet-1-cidr" {
  default = "192.168.1.0/24"
  description = "public_web_subnet-1"
  type = string
}

## presentation tier CIDR blocl -2 ##

variable "public-web-subnet-2-cidr" {
  default = "192.168.2.0/24"
  description = "public_web_subnet-2"
  type = string
}

## App tier CIDR Block-1 ##

variable "private-app-subnet-1-cidr" {
  default = "192.168.3.0/24"
  description = "private_app_subnet-1"
  type = string
}

## App tier CIDR Block-2 ##

variable "private-app-subnet-2-cidr" {
  default = "192.168.4.0/24"
  description = "private_app_subnet-2"
  type = string 
}

## DB CIDR block-1 ##

variable "private-db-subnet-1-cidr" {
  default = "192.168.5.0/24"
  description = "private_db_subnet-1"
  type = string
}

## DB CIDR block-2 ##
variable "private-db-subnet-2-cidr" {
  default = "192.168.6.0/24"
  description = "private_db_subnet-2"
  type = string
}

## App tier security group ##
variable "ssh-locate" {
  default = "your_ip_address"
  description = "ip address"
  type = string
}

## DB instance ##

variable "database-instance-class" {
  default = "db.t3.micro"
  description = "the databse instance type"
  type = string
}

## Multi-AZ ##

variable "multi-az-deployment" {
  default = true                            # if you want multi-az then make as "true"
  description = "create standby DB instance"
  type = bool
}
## RDS username & password ##
variable "rds_username" {
  default = "admin"
  description = "username of rds"
  type = string
}

variable "rds_password" {
  default = "prashanth"
  description = "password of my rds"
  type = string
}
variable "key_name" {
  default = "thor123"
  description = "key name of my instance"
  type = string
}
