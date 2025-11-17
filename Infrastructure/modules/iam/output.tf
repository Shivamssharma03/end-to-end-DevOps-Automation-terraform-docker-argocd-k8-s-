output "cluster_role_arn" {
  value = aws_iam_role.cluster.arn
}

output "node_role_arn" {
  value = aws_iam_role.node.arn
}




output "alb_controller_role_arn" {
  value = aws_iam_role.alb_controller_role.arn
}



 
# output "cluster_autoscaler_policy_arn" {
#   description = "IAM Policy ARN for Cluster Autoscaler (to attach to node role)"
#   value       = aws_iam_policy.eks_cluster_autoscaler.arn
# }