variable "aws_region" {
  description = "AWS region where resources will be provisioned"
  default     = "ap-south-1"
}

variable "ec2_ami_id" {
  description = "Ubuntu AMI ID for the EC2 instance"
  default     = "ami-0e35ddab05955cf57"
  type        = string
}

variable "ec2_instance_type" {
  description = "Instance type for the EC2 instance"
  default     = "t2.micro"
  type        = string
}

variable "ec2_root_storage_size" {
  description = "Volume size for the EC2 instance"
  default     = 8
  type        = number
}

variable "prod" {
  description = "Instance type for the EC2 instance"
  default     = "prod"
  type = string
}