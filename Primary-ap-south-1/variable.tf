variable "rds-password" {
    description = "rds password"
    type = string
    default = "prashnth"
  
}
variable "rds-username" {
    description = "rds username"
    type = string
    default = "admin"
  
}
variable "ami" {
    description = "ami"
    type = string
    default = "ami-0df8c184d5f6ae949"
  
}
variable "instance-type" {
    description = "instance-type"
    type = string
    default = "t2.micro"
  
}
variable "key-name" {
    description = "keyname"
    type = string
    default = "project-key"
  
}
variable "backupr-retention" {
    type = number
    default = "7"
  
}