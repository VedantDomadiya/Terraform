resource "aws_dynamodb_table" "my_dynamodb_table" {
  name           = "my_dynamodb_for_remote_backend"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID" #IMP for RemoteBackend

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "my_dynamodb_for_remote_backend"
  }
}
