output "vpc_id" {
  value       = aws_vpc.my-vpc.id
  description = "ID of the vpc"
}

output "cluster_id" {
  value       = aws_eks_cluster.my-cluster.id
  description = "Id of the eks cluster"
}

output "cluster_endpoint" {
  value       = aws_eks_cluster.my-cluster.endpoint
  description = "Endpoint to the the cluster"
}