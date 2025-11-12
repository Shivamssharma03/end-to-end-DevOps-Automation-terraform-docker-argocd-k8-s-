



#  EKS CONTROL PLANE

resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn
  version  = var.k8s_version

  vpc_config {
    subnet_ids = concat(
      var.private_subnet_ids,
      var.public_subnet_ids
    )

    endpoint_private_access = true
    endpoint_public_access  = true
    public_access_cidrs     = ["0.0.0.0/0"]
    security_group_ids      = [var.cluster_sg_id]       # EKS control plane SG
  }

  # compute_config {
  #   enabled = true
  #   elastic_load_balancing {
  #     enabled = true
  #   }
  # }

  access_config {
    authentication_mode = "API"
  }

  tags = {
    Project = var.project
    Name    = "${var.project}-eks-control-plane"
  }
}

# 
#  MANAGED NODE GROUP (no Launch Template)
# 
resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${var.project}-ng"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.private_subnet_ids

 



  scaling_config {
    desired_size = var.node_desired
    min_size     = var.node_min
    max_size     = var.node_max
  }

  #  Worker EC2 instances custom names & tags
    tags = {
    Project = var.project
    Name    = "${var.project}-worker-node"
  }
  capacity_type  = "ON_DEMAND"
  instance_types = var.node_instance_types

  update_config {
    max_unavailable = 1
  }



  depends_on = [
    aws_eks_cluster.this
  ]
}


# ✅ IAM Access

resource "aws_eks_access_entry" "admin" {
  cluster_name  = aws_eks_cluster.this.name
  principal_arn = var.admin_principal_arn
  type          = "STANDARD"
}

resource "aws_eks_access_policy_association" "admin_cluster" {
  cluster_name  = aws_eks_cluster.this.name
  principal_arn = aws_eks_access_entry.admin.principal_arn
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}

///////////////////////////////////eeeeeeeeeeddddddddddddd/edde/////////////////////

data "aws_eks_cluster" "this" {
  name = aws_eks_cluster.this.name
}
///////////// required for configmap  access //////
# resource "aws_iam_openid_connect_provider" "this" {
#   url             = data.aws_eks_cluster.this.identity[0].oidc[0].issuer
#   client_id_list  = ["sts.amazonaws.com"]
#   thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da0afd10df6"]
# }
