resource "aws_iam_role" "nullplatform_scope_workflow_role" {
  provider = aws
  name     = "nullplatform-scope-workflow-role"
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
    policy = aws_iam_policy.nullplatform_route53_manager_policy.policy
  }
  inline_policy {
    name   = "eks-manager-policy"
    policy = aws_iam_policy.nullplatform_eks_manager_policy.policy
  }
  inline_policy {
    name   = "asg-manager-policy"
    policy = aws_iam_policy.nullplatform_asg_manager_policy.policy
  }

  inline_policy {
    name   = "alb-manager-policy"
    policy = aws_iam_policy.nullplatform_alb_manager_policy.policy
  }

  inline_policy {
    name   = "lambda-manager-policy"
    policy = aws_iam_policy.nullplatform_lambda_manager_policy.policy
  }

  inline_policy {
    name   = "params-manager-policy"
    policy = aws_iam_policy.nullplatform_params_manager_policy.policy
  }
  tags = {
    organization = var.organization
    account      = var.account
  }
}

resource "aws_iam_policy" "nullplatform_route53_manager_policy" {
  provider    = aws
  name        = "nullplatform-route53-manager-policy"
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
  tags = {
    organization = var.organization
    account      = var.account
  }
}

resource "aws_iam_policy" "nullplatform_eks_manager_policy" {
  provider    = aws
  name        = "nullplatform-eks-manager-policy"
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
        "Effect" : "Allow",
        "Action" : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"
        ],
        "Resource" : [
          "arn:aws:logs:*:*:*"
        ]
      }
    ]
  })
  tags = {
    organization = var.organization
    account      = var.account
  }
}

resource "aws_iam_policy" "nullplatform_asg_manager_policy" {
  provider    = aws
  name        = "nullplatform-asg-manager-policy"
  description = "Policy for managing ASG"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "autoscaling:*",
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "cloudwatch:*",
          "logs:*",

        ],
        Resource = "*"
      },
      {
        Effect   = "Allow",
        Action   = "iam:CreateServiceLinkedRole",
        Resource = "arn:aws:iam::*:role/aws-service-role/events.amazonaws.com/AWSServiceRoleForCloudWatchEvents*",
        Condition = {
          StringLike = {
            "iam:AWSServiceName" : "events.amazonaws.com"
          }
        }
      },
      {
        Effect = "Allow",
        Action = [
          "oam:ListAttachedLinks"
        ],
        Resource = "arn:aws:oam:*:*:sink/*"
      },
      {
        Effect = "Allow",
        Action = [
          "ec2:DescribeAccountAttributes",
          "ec2:DescribeAvailabilityZones",
          "ec2:DescribeImages",
          "ec2:DescribeInstanceAttribute",
          "ec2:DescribeInstances",
          "ec2:DescribeKeyPairs",
          "ec2:DescribeLaunchTemplateVersions",
          "ec2:DescribePlacementGroups",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSpotInstanceRequests",
          "ec2:DescribeSubnets",
          "ec2:DescribeVpcClassicLink",
          "ec2:RunInstances",
          "ec2:CreateTags",
          "ec2:CreateLaunchTemplate",
          "ec2:CreateLaunchTemplateVersion",
          "ec2:DeleteLaunchTemplate",
          "ec2:DeleteLaunchTemplateVersions",
          "ec2:DeleteTags"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "elasticloadbalancing:DescribeLoadBalancers",
          "elasticloadbalancing:DescribeTargetGroups"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "iam:GetRole",
          "iam:PassRole",
          "iam:GetPolicy",
          "iam:GetPolicyVersion",
          "iam:GetRole",
          "oam:ListSinks"
        ],
        Resource = "*"
      },
      {
        Effect   = "Allow",
        Action   = "iam:CreateServiceLinkedRole",
        Resource = "*",
        Condition = {
          StringEquals = {
            "iam:AWSServiceName" = "autoscaling.amazonaws.com"
          }
        }
      }
    ]
  })
  tags = {
    organization = var.organization
    account      = var.account
  }
}

resource "aws_iam_policy" "nullplatform_alb_manager_policy" {
  provider    = aws
  name        = "nullplatform-alb-manager-policy"
  description = "Policy for managing ALB"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "elasticloadbalancing:*",
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "ec2:DescribeAccountAttributes",
          "ec2:DescribeAddresses",
          "ec2:DescribeInternetGateways",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSubnets",
          "ec2:DescribeVpcs",
          "ec2:DescribeVpcClassicLink",
          "ec2:DescribeInstances",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DescribeClassicLinkInstances",
          "ec2:DescribeRouteTables",
          "ec2:DescribeCoipPools",
          "ec2:GetCoipPoolUsage",
          "ec2:DescribeVpcPeeringConnections",
          "cognito-idp:DescribeUserPoolClient"
        ],
        Resource = "*"
      },
      {
        Effect   = "Allow",
        Action   = "iam:CreateServiceLinkedRole",
        Resource = "*",
        Condition = {
          StringEquals = {
            "iam:AWSServiceName" = "elasticloadbalancing.amazonaws.com"
          }
        }
      },
      {
        Effect   = "Allow",
        Action   = "iam:CreateServiceLinkedRole",
        Resource = "*",
        Condition = {
          StringEquals = {
            "iam:AWSServiceName" = "execute-api.amazonaws.com"
          }
        }
      },
      {
        Effect   = "Allow",
        Action   = "iam:CreateServiceLinkedRole",
        Resource = "*",
        Condition = {
          StringEquals = {
            "iam:AWSServiceName" = "apigateway.amazonaws.com"
          }
        }
      },
      {
        Effect   = "Allow",
        Action   = "iam:CreateServiceLinkedRole",
        Resource = "*",
        Condition = {
          StringEquals = {
            "iam:AWSServiceName" = "ops.apigateway.amazonaws.com"
          }
        }
      },

      {
        Effect   = "Allow",
        Action   = "arc-zonal-shift:*",
        Resource = "arn:aws:elasticloadbalancing:*:*:loadbalancer/*"
      },
      {
        Effect = "Allow",
        Action = [
          "arc-zonal-shift:ListManagedResources",
          "arc-zonal-shift:ListZonalShifts"
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

resource "aws_iam_policy" "nullplatform_lambda_manager_policy" {
  provider    = aws
  name        = "nullplatform-lambda-manager-policy"
  description = "Policy for managing Lambda"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject"
        ],
        Resource = [for bucket in var.assets_bucket_arns : "${bucket}/*"]

      },
      {
        Effect = "Allow",
        Action = [
          "ec2:CreateNetworkInterface",
          "lambda:CreateFunction",
          "lambda:DeleteProvisionedConcurrencyConfig",
          "lambda:GetFunctionConfiguration",
          "lambda:ListProvisionedConcurrencyConfigs",
          "lambda:GetProvisionedConcurrencyConfig",
          "lambda:ListLayers",
          "lambda:ListLayerVersions",
          "lambda:DeleteFunction",
          "lambda:GetAlias",
          "lambda:ListCodeSigningConfigs",
          "lambda:UpdateFunctionUrlConfig",
          "lambda:CreateFunctionUrlConfig",
          "lambda:UpdateFunctionEventInvokeConfig",
          "lambda:DeleteFunctionCodeSigningConfig",
          "lambda:InvokeFunctionUrl",
          "lambda:ListFunctions",
          "lambda:GetEventSourceMapping",
          "apigateway:*",
          "lambda:ListAliases",
          "lambda:GetFunctionUrlConfig",
          "lambda:GetFunctionCodeSigningConfig",
          "lambda:UpdateAlias",
          "lambda:UpdateFunctionCode",
          "lambda:ListFunctionEventInvokeConfigs",
          "lambda:PutRuntimeManagementConfig",
          "lambda:ListFunctionsByCodeSigningConfig",
          "lambda:GetFunctionConcurrency",
          "lambda:PutProvisionedConcurrencyConfig",
          "lambda:ListEventSourceMappings",
          "lambda:PublishVersion",
          "lambda:DeleteEventSourceMapping",
          "lambda:CreateAlias",
          "lambda:ListVersionsByFunction",
          "lambda:GetLayerVersion",
          "lambda:PublishLayerVersion",
          "lambda:GetAccountSettings",
          "lambda:CreateEventSourceMapping",
          "lambda:GetLayerVersionPolicy",
          "lambda:PutFunctionConcurrency",
          "lambda:DeleteCodeSigningConfig",
          "lambda:ListTags",
          "lambda:AddPermission",
          "lambda:TagResource",
          "lambda:GetRuntimeManagementConfig",
          "lambda:DeleteLayerVersion",
          "lambda:PutFunctionEventInvokeConfig",
          "lambda:DeleteFunctionEventInvokeConfig",
          "lambda:CreateCodeSigningConfig",
          "lambda:PutFunctionCodeSigningConfig",
          "lambda:UpdateEventSourceMapping",
          "lambda:UpdateFunctionCodeSigningConfig",
          "lambda:GetFunction",
          "lambda:UpdateFunctionConfiguration",
          "lambda:ListFunctionUrlConfigs",
          "lambda:UpdateCodeSigningConfig",
          "lambda:GetFunctionEventInvokeConfig",
          "lambda:DeleteAlias",
          "lambda:DeleteFunctionConcurrency",
          "lambda:GetCodeSigningConfig",
          "lambda:DeleteFunctionUrlConfig",
          "lambda:GetPolicy"
        ],
        "Resource" : "*"
      }
    ]
  })
  tags = {
    organization = var.organization
    account      = var.account
  }
}

resource "aws_iam_policy" "nullplatform_params_manager_policy" {
  provider    = aws
  name        = "nullplatform-params-manager-policy"
  description = "Policy for managing params"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:PutObject",
          "s3:PutObjectAcl",
          "s3:PutObjectVersionAcl"
        ]
        Effect   = "Allow"
        Resource = [for bucket in var.parameters_bucket_arns : "${bucket}/*"]
      },
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
      , {
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Effect   = "Allow"
        Resource = [for param in var.parameters_encryption_arns : param]
      }
    ]
  })
  tags = {
    organization = var.organization
    account      = var.account
  }
}
