variable "ami_id" {
  description = "passing AMI value"
  type = string
  default = "ami-0aebec83a182ea7ea"
}
variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "key_name" {
  type = string
  default = "thor123"
}