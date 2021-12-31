variable "profile" {
  description = "AWS profile"
  type        = string
  default = "default"
}

variable "region" {
  description = "AWS region to deploy to"
  default = "eu-west-1"
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name"
  type = string
  default = "aws-eks"
}

variable "env" {
  description = "AWS region to deploy to"
  default = "dev"
  type        = string
}

variable "username" {
  type = list
  default = ["pdb","reader"]
}

variable "user" {
  type = string
  default = "pdb"
}
