variable "eks_cluster_name" {
  description = "The name of the EKS cluster"
  type = string
}

variable "vpc_tag_name" {
  type        = string
  description = "Name tag for the VPC"
}

variable "route_table_tag_name" {
  type        = string
  default     = "main"
  description = "Route table description"
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block range for vpc"
}

variable "private_subnet_cidr_blocks" {
  type        = list(string)
  description = "CIDR block range for the private subnet"
}

variable "public_subnet_cidr_blocks" {
  type = list(string)
  description = "CIDR block range for the public subnet"
}

variable "private_subnet_tag_name" {
  type        = string
  default = "Custom Kubernetes cluster private subnet"
  description = "Name tag for the private subnet"
}

variable "public_subnet_tag_name" {
  type        = string
  default = "Custom Kubernetes cluster public subnet"
  description = "Name tag for the public subnet"
}

variable "availability_zones" {
  type  = list(string)
  description = "List of availability zones for the selected region"
}

variable "region" {
  description = "aws region to deploy to"
  type        = string
}
