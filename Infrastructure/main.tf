locals {
  env = terraform.workspace
}

data "aws_caller_identity" "current" {}        ### checks the current user identity 

# -------------------- VPC --------------------

module "vpc" {
  source = "./modules/vpc"

  project          = var.project
  cidr_block       = var.vpc_cidr
  env = local.env
  azs              = var.azs
  public_subnets   = var.public_subnet_cidrs
  private_subnets  = var.private_subnet_cidrs
  tags             = var.tags
  cluster_name    = var.cluster_name   
}




# -------------------- IAM (Cluster & Node roles) --------------------
module "iam" {
  source       = "./modules/iam"
  project      = var.project
  cluster_name = var.cluster_name
}




# -------------------- EKS --------------------
module "eks" {
  source               = "./modules/eks"
  project              = var.project
  cluster_name         = var.cluster_name
  k8s_version          = var.k8s_version

  vpc_id               = module.vpc.vpc_id
  private_subnet_ids   = module.vpc.private_subnet_ids
  public_subnet_ids    = module.vpc.public_subnet_ids

  cluster_role_arn     = module.iam.cluster_role_arn
  node_role_arn        = module.iam.node_role_arn
 
  nodes_sg_id =         module.sg.eks_nodes_sg_id
  cluster_sg_id      = module.sg.eks_cluster_sg_id
  node_instance_types  = var.node_instance_types
  node_desired         = var.node_desired
  node_min             = var.node_min
  node_max             = var.node_max
  admin_principal_arn = data.aws_caller_identity.current.arn                        ###take the id of the curent user from local machine
}


# -------------------- Security Groups  --------------------
module "sg" {
  source       = "./modules/sg"
  vpc_id       = module.vpc.vpc_id
  project      = var.project
  cluster_sg_id  = module.eks.cluster_security_group_id 
 
}



# -------------------- Kubernetes Provider --------------------
# Data sources to wire kubernetes provider
data "aws_eks_cluster" "this" {
  name = module.eks.cluster_id
  depends_on = [module.eks]
  
}



data "aws_eks_cluster_auth" "this" {
  name = module.eks.cluster_id
  depends_on = [module.eks]
}

