# Terraform lab06 for cloud security
# Submitted by: Mahima Shastri
# Student id: N01588261

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.39.1"
    }
  }
}

provider "aws" {
  region = var.region
}

// IAM Role
resource "aws_iam_role" "ec2_role" {
  name               = "ec2_role_lab"
  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [{
      Action   = "sts:AssumeRole",
      Effect   = "Allow",
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

// IAM Policy
resource "aws_iam_policy" "ec2_policy" {
  name        = "ec2_policy_lab"
  description = "Allow EC2 to access S3"
  policy      = jsonencode({
    Version   = "2012-10-17",
    Statement = [{
      Action    = ["s3:GetObject", "s3:ListBucket", "s3:PutObject"],
      Effect    = "Allow",
      Resource  = ["arn:aws:s3:::${var.bucket_name}", "arn:aws:s3:::${var.bucket_name}/*"]
    }]
  })
}


// IAM Instance Profile
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2_instance_profile"
  role = aws_iam_role.ec2_role.name
}

// S3 Bucket
resource "aws_s3_bucket" "lab_bucket" {
  bucket = var.bucket_name
  tags   = { Env = "labtest" }
}

// VPC and Subnet
resource "aws_vpc" "lab_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "lab_subnet" {
  vpc_id     = aws_vpc.lab_vpc.id
  cidr_block = var.subnet_cidr
}

// Security Group
resource "aws_security_group" "lab_sg" {
  name        = "lab-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.lab_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

// Ubuntu EC2 Instance
resource "aws_instance" "lab_test" {
  ami                  = var.ubuntu_ami
  instance_type        = "t2.micro"
  subnet_id            = aws_subnet.lab_subnet.id
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  tags = {
    Name = "lab-test"
  }
}

// Disassociate IAM Policy from Role
resource "aws_iam_role_policy_attachment" "ec2_policy_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.ec2_policy.arn

  # Set the lifecycle block to prevent changes to the policy attachment
  lifecycle {
    ignore_changes = [policy_arn]
  }
}
