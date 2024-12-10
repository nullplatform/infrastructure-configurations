output "ids" {
  description = "The Ids of the dimensions created"
  value       = [for env in nullplatform_dimension_value.environment_value : env.id]
}
