project                   = "eks-modular-dev"
region                    = "eu-north-1"
env = dev 
vpc_cidr                = "10.0.0.0/16"
azs                       = ["eu-north-1a", "eu-north-1b"]
public_subnet_cidrs       = ["10.0.0.0/24", "10.0.1.0/24"]
private_subnet_cidrs   = ["10.0.10.0/24", "10.0.11.0/24"]

cluster_name              = "eks-pvt-cluster"
node_instance_types       = ["t3.medium"]
node_desired              = 2
node_min                  = 1
node_max                  = 3


tags = {
  Environment = "dev"
  Owner       = "shivam"
}