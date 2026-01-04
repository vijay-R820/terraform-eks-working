variable "aws_region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "deafult cidr range for vpc"
}

variable "private_subnets" {
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
  description = "default cidr range for private subnet"
}

variable "public_subnets" {
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
  description = "default cidr range for public subnet"
}
variable "kubernets_version" {
  default     = 1.33
  description = "kubernets version"
}

variable "instance_types" {
  type        = list(string)
  default     = ["t3.micro"]
  description = "instance type for eks cluster"
}
variable "all_outbound_cidr" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}
