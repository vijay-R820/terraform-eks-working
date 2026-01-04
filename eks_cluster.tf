# Get your AWS account ID
data "aws_caller_identity" "current" {}

resource "aws_iam_role" "eks_admin" {
  name = "eks-admin"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      }
      Action = "sts:AssumeRole"
    }]
  })
}


module "eks" {
  source       = "terraform-aws-modules/eks/aws"
  version      = "~> 20.24"
  cluster_name = local.cluster_name
  cluster_version = "1.32"
  subnet_ids   = module.vpc.private_subnets
  enable_irsa  = true
  # Optional
  # endpoint_public_access = true

  # compute_config = {
  #   enabled    = true
  #   node_pools = ["general-purpose"]
  # }

  vpc_id = module.vpc.vpc_id

  eks_managed_node_group_defaults = {
    instance_types         = var.instance_types
    vpc_security_group_ids = [aws_security_group.all_worker_mgmt.id]
  }

  eks_managed_node_groups = {
    general = {
      min_size     = 2
      max_size     = 6
      desired_size = 2
      ami_type     = "AL2_x86_64"
    }
  }
  tags = {
    Environment = "prod"
    Terraform   = "true"
  }
}
