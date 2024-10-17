terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.20.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.64"
    }
  }
}

provider "docker" {}

provider "aws" {
  region = local.aws_region
  // shared_config_files = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
}