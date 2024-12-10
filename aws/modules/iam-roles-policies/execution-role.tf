resource "aws_iam_role" "null-instance-role" {
  name               = "null-instance-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": ["ec2.amazonaws.com","lambda.amazonaws.com"]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "null-instance-lambda-execution-attach" {
  name       = "null-instance-role-lambda-execution"
  roles      = [aws_iam_role.null-instance-role.id]
  policy_arn = aws_iam_policy.lambda-execution.arn
}

resource "aws_iam_policy_attachment" "null-instance-role-ecr-attach" {
  name       = "null-instance-role-ecr-attach"
  roles      = [aws_iam_role.null-instance-role.id]
  policy_arn = aws_iam_policy.ecr-nullimages-read.arn
}

resource "aws_iam_policy_attachment" "null-instance-role-s3-parameters-read-attach" {
  name       = "null-instance-role-s3-parameters-read-attach"
  roles      = [aws_iam_role.null-instance-role.id]
  policy_arn = aws_iam_policy.null-params-read.arn
}

resource "aws_iam_policy_attachment" "null-instance-role-aws-logs-enablement" {
  name       = "null-instance-role-s3-parameters-attach"
  roles      = [aws_iam_role.null-instance-role.id]
  policy_arn = aws_iam_policy.null-aws-logs-enablement.arn
}

resource "aws_iam_instance_profile" "null-instance-profile" {
  name = "null-instance-profile"
  role = aws_iam_role.null-instance-role.name
}

resource "aws_iam_policy" "lambda-execution" {
  name = "lambda-execution"
  policy = jsonencode(
    {
      Version = "2012-10-17",
      Statement = [
        {
          Effect = "Allow",
          Action = [
            "lambda:InvokeFunction"
          ],
          Resource = [
            "*"
          ]
          }, {
          Effect = "Allow",
          Action = [
            "ec2:AssignPrivateIpAddresses",
            "ec2:AttachNetworkInterface",
            "ec2:CreateNetworkInterface",
            "ec2:DeleteNetworkInterface",
            "ec2:DescribeInstances",
            "ec2:DescribeTags",
            "ec2:DescribeNetworkInterfaces",
            "ec2:DescribeInstanceTypes",
            "ec2:DetachNetworkInterface",
            "ec2:ModifyNetworkInterfaceAttribute",
            "ec2:UnassignPrivateIpAddresses"
          ],
          Resource = "*"
        },
        {
          Effect = "Allow",
          Action = [
            "ec2:CreateTags"
          ],
          Resource = [
            "arn:aws:ec2:*:*:network-interface/*"
          ]
        }
      ]
    }
  )
}

resource "aws_iam_policy" "ecr-nullimages-read" {
  name = "ecr-nullimages-read"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ecr:DescribeImages",
          "ecr:DescribeRegistry",
          "ecr:DescribeRepositories",
          "ecr:GetDownloadUrlForLayer",
          "ecr:ListImages",
          "ecr:GetAuthorizationToken",
          "ecr:BatchGetImage"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_policy" "null-params-read" {
  name = "null-params-read"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:GetObjectVersion"
        ]
        Effect   = "Allow"
        Resource = [for bucket in var.parameters_bucket_arns : "${bucket}/*"]
        }, {
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Effect   = "Allow"
        Resource = [for param in var.parameters_encryption_arns : param]
      },
    ]
  })
}

resource "aws_iam_policy" "null-aws-logs-enablement" {
  name        = "null-aws-logs-enablement"
  path        = "/"
  description = "Policy to allow push cloudwatch logs"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams",
          "logs:PutRetentionPolicy"
        ],
        Resource = [
          "arn:aws:logs:*:*:*"
        ]
      }
    ]
  })
}


