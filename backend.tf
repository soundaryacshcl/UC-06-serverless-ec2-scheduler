 terraform {
  backend "s3" {
    bucket       = "usecase6-17thjuly"
    key          = "terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
} 
