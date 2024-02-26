variable "region" {
  type        = string
  description = "AWS deployment region"
}

variable "profile" {
  type        = string
  description = "AWS profile to authenticate"
}

variable "eks_cluster_name" {
  type = string
  description = "EKS cluster name"
}
