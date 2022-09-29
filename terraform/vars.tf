variable "project_name" {
  type        = string
  description = "GCP Project name"
}

variable "region" {
  type        = string
  description = "Default compute region"
  default     = "europe-west1"
}

variable "organization_id" {
  type = string
}

variable "billing_account" {
  type = string
}

variable "network_name" {
  type = string
}
