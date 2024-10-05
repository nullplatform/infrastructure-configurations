################################################################################
# IAM Policies
################################################################################

resource "aws_iam_policy" "np_ecr_manager_policy" {
  name        = "np-ecr-manager-policy"
  description = "Policy for managing ECR"
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:CompleteLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:InitiateLayerUpload",
          "ecr:BatchCheckLayerAvailability",
          "ecr:PutImage",
          "ecr:CreateRepository",
          "ecr:DeleteRepository",
          "ecr:DescribeRepositories",
          "ecr:TagResource"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "sts:GetServiceBearerToken",
          "ecr:GetAuthorizationToken"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "np_ecr_write_policy" {
  name        = "np-ecr-write-policy"
  description = "Policy for build workflow user to write to ECR"
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid = "NpEcrWritePolicy",
        Effect = "Allow",
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:GetAuthorizationToken"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "np_eks_manager_policy" {
  name        = "np-eks-manager-policy"
  description = "Policy for managing EKS"
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "eks:DescribeCluster",
          "elasticloadbalancing:DescribeLoadBalancers"
        ],
        Resource = "*"
      },
      {
        "Effect": "Allow",
        "Action": [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents",
            "logs:DescribeLogStreams"
        ],
        "Resource": [
            "arn:aws:logs:*:*:*"
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "np_route53_manager_policy" {
  name        = "np-route53-manager-policy"
  description = "Policy for managing Route53"
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "route53:ChangeResourceRecordSets",
          "route53:GetHostedZone",
          "route53:ListResourceRecordSets"
        ],
        Resource = "arn:aws:route53:::hostedzone/*"
      }
    ]
  })
}

resource "aws_iam_policy" "np_metrics_api_policy" {
  name        = "np-metrics-api-policy"
  description = "Policy for managing CloudWatch metrics and logs"
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ec2:DescribeInstances",
          "cloudwatch:GetMetricData",
          "cloudwatch:ListMetrics",
          "logs:Describe*",
          "logs:Get*",
          "logs:List*",
          "logs:StartQuery",
          "logs:StopQuery",
          "logs:TestMetricFilter",
          "logs:FilterLogEvents"
        ],
        Resource = "*"
      }
    ]
  })
}

################################################################################
# IAM Roles
################################################################################

resource "aws_iam_role" "null_application_role" {
  name               = "null-application-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          AWS = var.application_manager_assume_role
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
  
  inline_policy {
    name   = "ecr-manager-policy"
    policy = aws_iam_policy.np_ecr_manager_policy.policy
  }
}

resource "aws_iam_role" "null_scope_workflow_role" {
  name               = "null-scope-workflow-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          AWS = var.scope_manager_assume_role
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
  
  inline_policy {
    name   = "route53-manager-policy"
    policy = aws_iam_policy.np_route53_manager_policy.policy
  }
  
  inline_policy {
    name   = "eks-manager-policy"
    policy = aws_iam_policy.np_eks_manager_policy.policy
  }
}

resource "aws_iam_role" "null_telemetry_manager_role" {
  name               = "null-telemetry-manager-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          AWS = var.telemetry_manager_assume_role
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
  
  inline_policy {
    name   = "metrics-api-policy"
    policy = aws_iam_policy.np_metrics_api_policy.policy
  }
  
  inline_policy {
    name   = "eks-manager-policy"
    policy = aws_iam_policy.np_eks_manager_policy.policy
  }
}

################################################################################
# IAM Users and Attachments
################################################################################

resource "aws_iam_user" "null_build_workflow_user" {
  name = "null-build-workflow-user"
}

resource "aws_iam_user_policy" "null_build_workflow_user_policy" {
  name   = "ecr-write-policy"
  user   = aws_iam_user.null_build_workflow_user.name
  policy = aws_iam_policy.np_ecr_write_policy.policy
}

resource "aws_iam_access_key" "null_build_workflow_user_key" {
  user = aws_iam_user.null_build_workflow_user.name
}
