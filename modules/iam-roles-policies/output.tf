################################################################################
# Outputs
################################################################################

# Output the ARN of the IAM roles created
output "null_application_role_arn" {
  description = "The ARN of the null-application-role"
  value       = aws_iam_role.null_application_role.arn
}

output "null_scope_workflow_role_arn" {
  description = "The ARN of the null-scope-workflow-role"
  value       = aws_iam_role.null_scope_workflow_role.arn
}

output "null_telemetry_manager_role_arn" {
  description = "The ARN of the null-telemetry-manager-role"
  value       = aws_iam_role.null_telemetry_manager_role.arn
}

# Output the policy ARNs
output "np_ecr_manager_policy_arn" {
  description = "The ARN of the np-ecr-manager-policy"
  value       = aws_iam_policy.np_ecr_manager_policy.arn
}

output "np_ecr_write_policy_arn" {
  description = "The ARN of the np-ecr-write-policy"
  value       = aws_iam_policy.np_ecr_write_policy.arn
}

output "np_eks_manager_policy_arn" {
  description = "The ARN of the np-eks-manager-policy"
  value       = aws_iam_policy.np_eks_manager_policy.arn
}

output "np_route53_manager_policy_arn" {
  description = "The ARN of the np-route53-manager-policy"
  value       = aws_iam_policy.np_route53_manager_policy.arn
}

output "np_metrics_api_policy_arn" {
  description = "The ARN of the np-metrics-api-policy"
  value       = aws_iam_policy.np_metrics_api_policy.arn
}

# Output IAM User and Access Key Details
output "null_build_workflow_user_name" {
  description = "The name of the null-build-workflow-user"
  value       = aws_iam_user.null_build_workflow_user.name
}

output "null_build_workflow_user_access_key_id" {
  description = "The access key ID for the null-build-workflow-user"
  value       = aws_iam_access_key.null_build_workflow_user_key.id
  sensitive   = true
}

output "null_build_workflow_user_secret_access_key" {
  description = "The secret access key for the null-build-workflow-user"
  value       = aws_iam_access_key.null_build_workflow_user_key.secret
  sensitive   = true
}
