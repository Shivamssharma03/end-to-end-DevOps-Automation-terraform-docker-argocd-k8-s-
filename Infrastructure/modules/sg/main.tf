
#  CONTROL PLANE SECURITY GROUP

resource "aws_security_group" "eks_cluster" {
  name_prefix = "${var.project}-eks-cluster-sg-"
  description = "Security group for EKS control plane"
  vpc_id      = var.vpc_id

  # Control plane must reach nodes (outbound)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-eks-cluster-sg"
  }
}


#  WORKER NODE SECURITY GROUP

resource "aws_security_group" "eks_nodes" {
  name_prefix = "${var.project}-eks-nodes-sg-"
  description = "Security group for EKS worker nodes"
  vpc_id      = var.vpc_id

  # Allow node-to-node communication
  ingress {
    description = "Allow node-to-node & pod-to-pod communication"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  # Allow inbound traffic from NGINX Ingress LoadBalancer
  ingress {
    description = "Traffic from NGINX LoadBalancer to worker nodes"
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound to internet
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-eks-nodes-sg"
  }
}


#  CONTROL PLANE → NODES RULE (required)

resource "aws_security_group_rule" "control_plane_to_nodes" {
  type                     = "ingress"
  description              = "EKS control plane to node kubelet"
  from_port                = 1025
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_nodes.id
  source_security_group_id = aws_security_group.eks_cluster.id
}

resource "aws_security_group_rule" "control_plane_to_nodes_443" {
  type                     = "ingress"
  description              = "Control plane to workers on port 443"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_nodes.id
  source_security_group_id = aws_security_group.eks_cluster.id
}
