resource "aws_eks_node_group" "my_node_group" {
  cluster_name    = aws_eks_cluster.my-cluster.name
  node_group_name = "my-node-group"
  node_role_arn   = aws_iam_role.my_node_group_role.arn
  ami_type        = "AL2_x86_64"
  capacity_type   = "ON_DEMAND"
  instance_types  = ["t3.medium"]

  subnet_ids = [
    aws_subnet.my_public_subnet_1.id,
    aws_subnet.my_public_subnet_2.id
  ]
  
  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 2
  }

  tags = {
    Name = "My node group"
  }
}

resource "aws_iam_role" "my_node_group_role" {
  name = "my_node_group_role"
  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "ec2.amazonaws.com"
          },
          "Action" : "sts:AssumeRole"
        }
      ]
    }
  )
}

resource "aws_iam_role_policy_attachment" "eks_AmazonEKSWorkerNodePolicy_attachment" {
  role       = aws_iam_role.my_node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "eks_AmazonEKS_CNI_Policy_attachment" {
  role       = aws_iam_role.my_node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "eks_AmazonEC2ContainerRegistryReadOnlyPolicy_attachment" {
  role       = aws_iam_role.my_node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}
