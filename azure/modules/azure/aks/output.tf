output "cluster_name" {
  description = "The name of the AKS cluster."
  value       = module.aks.aks_name
}

output "cluster_id" {
  description = "The ID of the AKS cluster."
  value       = module.aks.aks_id
}

output "host" {
  description = "The Kubernetes API server host."
  value       = module.aks.host
}

output "client_certificate" {
  description = "The Kubernetes API server client certificate."
  value       = module.aks.client_certificate
}

output "client_key" {
  description = "The Kubernetes API server client key."
  value       = module.aks.client_key
}

output "cluster_ca_certificate" {
  description = "The Kubernetes API server cluster CA certificate."
  value       = module.aks.cluster_ca_certificate
}
