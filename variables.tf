variable "region" {
  description = "The AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "The CIDR block for the subnet"
  type        = string
  default     = "10.0.0.0/24"
}

variable "ubuntu_ami" {
  description = "The ID of the Ubuntu AMI"
  type        = string
  default     = "ami-0b0ea68c435eb488d"
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "labtest-bucket"
}
