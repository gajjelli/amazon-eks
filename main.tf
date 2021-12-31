# VPC for EKS
module "vpc_for_eks" {
  source = "./vpc"
  eks_cluster_name = var.cluster_name
  vpc_tag_name = "${var.cluster_name}-vpc"
  vpc_cidr_block= "10.0.0.0/16"
  private_subnet_cidr_blocks= ["10.0.0.0/24", "10.0.1.0/24", "10.0.3.0/24"]
  public_subnet_cidr_blocks= ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  availability_zones= ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  region = var.region
}

# EKS Cluster

module "eks_cluster_and_worker_nodes" {
  source = "./eks"
  # Cluster
  vpc_id = module.vpc_for_eks.vpc_id
  cluster_sg_name = "${var.cluster_name}-cluster-sg"
  nodes_sg_name = "${var.cluster_name}-node-sg"
  eks_cluster_name = var.cluster_name
  eks_cluster_subnet_ids = flatten([module.vpc_for_eks.public_subnet_ids])
  # Node group configuration (including autoscaling configurations)
  pvt_desired_size = 3
  pvt_max_size = 8
  pvt_min_size = 2
  pblc_desired_size = 1
  pblc_max_size = 2
  pblc_min_size = 1
  endpoint_private_access = true
  endpoint_public_access = true
  node_group_name = "${var.cluster_name}-node-group"
  private_subnet_ids = module.vpc_for_eks.private_subnet_ids
  public_subnet_ids = module.vpc_for_eks.public_subnet_ids
}
