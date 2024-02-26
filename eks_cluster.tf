resource "aws_eks_cluster" "my-cluster" {
  name     = var.eks_cluster_name
  role_arn = aws_iam_role.cluster-role.arn

  vpc_config {
    endpoint_public_access = true

    subnet_ids = [
      aws_subnet.my_public_subnet_1.id,
      aws_subnet.my_public_subnet_2.id
    ]

    security_group_ids = [aws_security_group.my_security_group.id]
  }

  depends_on = [aws_iam_role_policy_attachment.eks_AmazonEKSClusterPolicy_attachment]
}

resource "aws_iam_role" "cluster-role" {
  name = "cluster-role"
  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "eks.amazonaws.com"
          },
          "Action" : "sts:AssumeRole"
        }
      ]
    }
  )
}

resource "aws_iam_role_policy_attachment" "eks_AmazonEKSClusterPolicy_attachment" {
  role       = aws_iam_role.cluster-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}
