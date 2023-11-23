terraform {
  backend "s3" {
    bucket         = "kn2004-terraform-state"
    key            = "kan2004/state/apprunner.state"
    region         = "eu-west-1"
    encrypt        = true
  }
}

provider "aws" {
  region = "eu-west-1"
}