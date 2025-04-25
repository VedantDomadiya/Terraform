#SSH keypair

resource "aws_key_pair" "my_key_new" {
  key_name   = "${var.env}-infra-app-key"
  public_key = file("terra-key-ec2.pub")

  tags = {
    Enviornment = var.env
  }
}

# VPC & SG

resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "mySG" {
  name        = "${var.env}-infra-app-sg"
  description = "this will add a TF generated SG"
  vpc_id      = aws_default_vpc.default.id 

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


  #Outbound Rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "all access open outbound rule"
  }

  tags = {
    Name = "${var.env}-infra-app-sg"
    Enviornment = var.env
  }
}

# EC2 Instance

resource "aws_instance" "my_instance" {
  count = var.instance_count
  
  key_name        = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.mySG.name]
  instance_type   = var.ec2_instance_type
  ami             = var.ec2_ami_id #Ubunutu

  depends_on = [ aws_security_group.mySG, aws_key_pair.my_key ] # Meta argument 

  root_block_device {
    volume_size = var.env == "prod" ? 15 : 10 #Conditional Statement
    volume_type = "gp3"
  }

  tags = {
    Name = "${var.env}-infra-app-instance"
    Enviornment = var.env
  }

}