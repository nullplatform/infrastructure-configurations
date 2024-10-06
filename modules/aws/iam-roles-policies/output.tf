output "nullplatform_application_role_arn" {
  description = "The ARN of the null-application-role"
  value       = aws_iam_role.nullplatform_application_role.arn
}

output "nullplatform_scope_workflow_role_arn" {
  description = "The ARN of the null-scope-workflow-role"
  value       = aws_iam_role.nullplatform_scope_workflow_role.arn
}

output "nullplatform_telemetry_manager_role_arn" {
  description = "The ARN of the null-telemetry-manager-role"
  value       = aws_iam_role.nullplatform_telemetry_manager_role.arn
}

output "nullplatform_ecr_manager_policy_arn" {
  description = "The ARN of the np-ecr-manager-policy"
  value       = aws_iam_policy.nullplatform_ecr_manager_policy.arn
}

output "nullplatform_ecr_write_policy_arn" {
  description = "The ARN of the np-ecr-write-policy"
  value       = aws_iam_policy.nullplatform_ecr_write_policy.arn
}

output "nullplatform_eks_manager_policy_arn" {
  description = "The ARN of the np-eks-manager-policy"
  value       = aws_iam_policy.nullplatform_eks_manager_policy.arn
}

output "nullplatform_route53_manager_policy_arn" {
  description = "The ARN of the np-route53-manager-policy"
  value       = aws_iam_policy.nullplatform_route53_manager_policy.arn
}

output "nullplatform_metrics_api_policy_arn" {
  description = "The ARN of the np-metrics-api-policy"
  value       = aws_iam_policy.nullplatform_metrics_api_policy.arn
}

output "nullplatform_build_workflow_user_name" {
  description = "The name of the null-build-workflow-user"
  value       = aws_iam_user.nullplatform_build_workflow_user.name
}

output "nullplatform_build_workflow_user_access_key_id" {
  description = "The access key ID for the null-build-workflow-user"
  value       = aws_iam_access_key.nullplatform_build_workflow_user_key.id
  sensitive   = true
}

output "nullplatform_build_workflow_user_secret_access_key" {
  description = "The secret access key for the null-build-workflow-user"
  value       = aws_iam_access_key.nullplatform_build_workflow_user_key.secret
  sensitive   = true
}
