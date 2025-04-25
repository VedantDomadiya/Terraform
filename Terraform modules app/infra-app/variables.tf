variable "env" {
    description = "This is the envoirnment for my infra"
    type = string
}

variable "bucket_name" {
    description = "This is the bucket name for my infra"
    type = string
}
variable "instance_count" {
    description = "This is the no. of ec2 Instance count for my infra"
    type = number
}

variable "ec2_instance_type" {
    description = "This is the instance type for my infra"
    type = string
}

variable "ec2_ami_id" {
    description = "This is the AMI ID of instance for my infra"
    type = string
}

variable "hash_key" {
    description = "This is the Hash Key of DynamoDB for my infra"
    type = string
}