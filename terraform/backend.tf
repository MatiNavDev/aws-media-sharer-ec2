terraform {
  backend "s3" {
    bucket = "terraform-state-dev.matinav"
    region = "us-east-1"
    key = "test-tfstate"
  }
}