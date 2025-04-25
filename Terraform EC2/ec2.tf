#SSH keypair

resource "aws_key_pair" "my_key" {
  key_name   = "terra-key-ec2"
  public_key = file("terra-key-ec2.pub")
}

# VPC & SG

resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "mySG" {
  name        = "automate-sg"
  description = "this will add a TF generated SG"
  vpc_id      = aws_default_vpc.default.id # Interpolation = It's a way in which you can inherit/extract values from a terraform block

  #Inbound Rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH open"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP open"
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Flask app"
  }

  #Outbound Rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "all access open outbound rule"
  }

  tags = {
    Name = "automate-sg"
  }
}

# EC2 Instance

resource "aws_instance" "my_instance" {
  # for_each = tomap({
  #   "My Instance 1" = "t2.micro"
  #   "My Instance 2" = "t2.micro"
  # }) # Meta argument

  key_name        = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.mySG.name]
  #instance_type   = each.value
  instance_type   = var.ec2_instance_type
  ami             = var.ec2_ami_id #Ubunutu
  user_data       = file("install_nginx.sh")

  depends_on = [ aws_security_group.mySG, aws_key_pair.my_key ] # Meta argument 

  root_block_device {
    volume_size = var.prod == "prod" ? 15 : var.ec2_root_storage_size #Conditional Statement
    volume_type = "gp3"
  }

  tags = {
    #Name = each.key
    Name = "My EC2 Instance"
  }

}
