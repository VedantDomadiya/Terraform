module "dev-infra" {
  source = "./infra-app"
  env = "dev"
  bucket_name = "My-infra-app-bucket"
  instance_count = 1
  ec2_instance_type = "t2.micro"
  ec2_ami_id = "ami-0e35ddab05955cf57"
  hash_key = "studentID"

}