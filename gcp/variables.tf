variable "project_id" {
  type        = string
  description = "Project ID in GCP"
}

variable "region" {
  type        = string
  description = "Region of the project in GCP"
  default = "us-east1"
}

variable "cluster_name" {
  type        = string
  description = "Name of the Cluster in GCP"
  default = "poc"
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block of our VPC"
  default = "10.0.0.0/16"
}

variable "vpc_subnet_cidrs" {
  type        = list(string)
  description = "Array of CIDRs for each VPC by environment"
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "api_key" {
  type        = string
  description = "nullplatform API key"
}

variable "nrn" {
  type        = string
  description = "The null platform nrn"
}

variable "domain_name" {
  type        = string
  description = "The domain to be used for applications"
}
