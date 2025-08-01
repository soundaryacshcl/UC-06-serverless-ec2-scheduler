 terraform {
  backend "s3" {
    bucket       = "terraform-usecases-hcl-us-east"
    key          = "terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
} 
