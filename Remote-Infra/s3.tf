resource "aws_s3_bucket" "remote_s3" {
  bucket = "my-s3-bucket-for-remote-backend"

  tags = {
    Name = "my-s3-bucket-for-remote-backend"
  }
}