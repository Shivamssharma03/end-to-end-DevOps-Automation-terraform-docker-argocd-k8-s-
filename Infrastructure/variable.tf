variable "project" {
    type = string
     }
variable "region"  { 
    type = string
     }

# VPC
variable "vpc_cidr" {
  type = string
}

variable "azs" {
  type = list(string)
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "tags" {
  type = map(string)
}
# EKS
variable "cluster_name" { type = string }
variable "k8s_version"  { 
  type = string  
  default = "1.30" 
  }
variable "node_desired" { 
  type = number
   default = 2
   }
variable "node_min"     {
   type = number 
   default = 1
    }
variable "node_max"     { 
  type = number
   default = 3
   }
variable "node_instance_types" {
   type = list(string)
    default = ["t3.medium"] 
    }

