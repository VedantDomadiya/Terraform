# Basically we are using attributes(the one's that are assigned once we create infrastructure) and we are accessing them via interpollation

output "ec2_public_ip" {
  value = aws_instance.my_instance.public_ip
}

output "ec2_public_dns" {
  value = aws_instance.my_instance.public_dns
}

output "ec2_private_ip" {
  value = aws_instance.my_instance.private_ip
}