terraform {
  backend "s3" {
    bucket = "your-s3-bucket"
    key    = "terraform/state"
    region = "eu-north-1"
  }
}
