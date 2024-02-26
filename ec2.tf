# resource "aws_instance" "my_instance" {
#   ami                    = "ami-0449c34f967dbf18a"
#   instance_type          = "t2.micro"

#   subnet_id = aws_subnet.my_public_subnet_1.id
#   vpc_security_group_ids = [aws_security_group.my_security_group.id]

#   user_data = <<-EOF
#                 #!/bin/bash
#                 yum update -y
#                 yum install -y httpd
#                 systemctl start httpd
#                 systemctl enable httpd
#                 echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
#             EOF

#   tags = {
#     Name = "My ec2 instance"
#   }
# }
