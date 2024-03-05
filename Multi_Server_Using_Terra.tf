terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.38.0"
    }
  }
}


terraform {
  backend "s3" {
    bucket = "terraformconfigdata"
    key    = "terraformconfigdata/TerraData/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}

provider "aws" {
  region = var.region
}


resource "aws_instance" "ubuntu_servers" {
  count = var.count

  ami           = "ami-07d9b9ddc6cd8dd30"  
  
  key_name = var.key_name

  tags = {
    Name = "My-server-${count.index + 1}"
  }
}


variable "region" {
  description = "The region for the instances"
  default     = "us-east-1"
}

variable "instance_type" {
  description = "The type of instances to launch"
  default     = "t2.micro"
}

variable "key_name" {
  description = "The name of the key pair to use for the instances"
  default     = "new"
}

variable "count" {
  description = "The number of Ubuntu servers to create"
  default     = 5
}

