terraform {
  backend "s3" {
    bucket = "my-unique-bucket-6ca5bb82"
     key    = "terraform/state" 
    region = "eu-north-1" 
  }
}
