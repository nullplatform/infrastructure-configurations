resource "aws_iam_policy" "nullplatform_ecr_manager_policy" {
  provider    = aws
  name        = "nullplatform-ecr-manager-policy"
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
  tags = {
    organization = var.organization
    account      = var.account
  }
}

resource "aws_iam_policy" "nullplatform_ecr_write_policy" {
  provider    = aws
  name        = "nullplatform-ecr-write-policy"
  description = "Policy for build workflow user to write to ECR"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "NullplatformEcrWritePolicy",
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
  tags = {
    organization = var.organization
    account      = var.account
  }
}

resource "aws_iam_policy" "nullplatform_metrics_api_policy" {
  provider    = aws
  name        = "nullplatform-metrics-api-policy"
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
  tags = {
    organization = var.organization
    account      = var.account
  }
}

resource "aws_iam_policy" "nullplatform-assets-write" {
  name = "nullplatform-assets-write"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:PutObject",
          "s3:PutObjectAcl",
          "s3:PutObjectVersionAcl",
          "s3:GetObject"
        ]
        Effect   = "Allow"
        Resource = [for bucket in var.assets_bucket_arns : "${bucket}/*"]
      }
    ]
  })
}

resource "aws_iam_role" "nullplatform_application_role" {
  provider = aws
  name     = "nullplatform-application-role"
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
    policy = aws_iam_policy.nullplatform_ecr_manager_policy.policy
  }
  tags = {
    organization = var.organization
    account      = var.account
  }
}

resource "aws_iam_role" "nullplatform_telemetry_manager_role" {
  provider = aws
  name     = "nullplatform-telemetry-manager-role"
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
    policy = aws_iam_policy.nullplatform_metrics_api_policy.policy
  }
  inline_policy {
    name   = "eks-manager-policy"
    policy = aws_iam_policy.nullplatform_eks_manager_policy.policy
  }
  tags = {
    organization = var.organization
    account      = var.account
  }
}

resource "aws_iam_user" "nullplatform_build_workflow_user" {
  provider = aws
  name     = "nullplatform-build-workflow-user"
  tags = {
    organization = var.organization
    account      = var.account
  }
}

resource "aws_iam_user_policy" "nullplatform_build_workflow_user_policy" {
  provider = aws
  name     = "ecr-write-policy"
  user     = aws_iam_user.nullplatform_build_workflow_user.name
  policy   = aws_iam_policy.nullplatform_ecr_write_policy.policy
}

resource "aws_iam_user_policy" "nullplatform_build_workflow_user_policy_s3" {
  provider = aws
  name     = "s3-write-policy"
  user     = aws_iam_user.nullplatform_build_workflow_user.name
  policy   = aws_iam_policy.nullplatform-assets-write.policy
}

resource "aws_iam_access_key" "nullplatform_build_workflow_user_key" {
  provider = aws
  user     = aws_iam_user.nullplatform_build_workflow_user.name
}
