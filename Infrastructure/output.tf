output "vpc_id"            { value = module.vpc.vpc_id }
output "public_subnet_ids" { value = module.vpc.public_subnet_ids }
output "private_subnet_ids"{ value = module.vpc.private_subnet_ids }

output "cluster_name"      { value = module.eks.cluster_id }
output "cluster_endpoint"  { value = module.eks.cluster_endpoint }
output "oidc_provider_arn" { value = module.eks.oidc_provider_arn }



output "alb_controller_role_arn" {
  value = module.iam.alb_controller_role_arn
}


output "cluster_certificate_authority_data" {
  value = module.eks.cluster_certificate_authority_data
}
