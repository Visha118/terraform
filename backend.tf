terraform {
  backend "s3" {
    bucket         = "tf-s3-state-bucket-1"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}