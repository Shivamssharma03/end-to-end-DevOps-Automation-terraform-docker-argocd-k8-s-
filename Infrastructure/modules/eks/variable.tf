variable "project"            { type = string }
variable "cluster_name"       { type = string }
variable "k8s_version"        { type = string }
variable "vpc_id"             { type = string }
variable "private_subnet_ids" { type = list(string) }
variable "public_subnet_ids"  { type = list(string) }
variable "cluster_role_arn"   { type = string }
variable "node_role_arn"      { type = string }

variable "node_instance_types" { type = list(string) }
variable "node_desired"        { type = number }
variable "node_min"            { type = number }
variable "node_max"            { type = number }
variable "admin_principal_arn" {
  description = "IAM user/role ARN to grant cluster-admin via EKS Access API"
  type        = string
  
}


variable "nodes_sg_id" {
  type =string
  description = "Security group for the EKS node"
  
}


variable "cluster_sg_id" {
  type = string
  description = "Security group for the EKS control plane"
}
