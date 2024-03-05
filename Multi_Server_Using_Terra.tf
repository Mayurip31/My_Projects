terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.39.1"
    }
  }
}
provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket         = "terraformconfigdata"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform_locks"
  }
}

resource "aws_instance" "ubuntu_instance" {
  count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = "ubuntu-instance-${count.index + 1}"
  }
}

variable "aws_region" {
  description = "The region where resources will be created."
  default     = "us-east-1"
}

variable "instance_count" {
  description = "Number of Ubuntu instances to create."
  type        = number
  default     = 5
}

variable "ami_id" {
  description = "The AMI ID for Ubuntu in the specified region."
  default     = "ami-07d9b9ddc6cd8dd30" 
}

variable "instance_type" {
  description = "The type of EC2 instance to launch."
  default     = "t2.micro"
}


