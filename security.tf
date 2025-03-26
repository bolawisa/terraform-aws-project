# Security Group for Public Instance (Web-SG)
resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.main.id
  name   = "Web-SG"

  tags = {
    Name = "Web-SG"
  }
}

# Allow HTTP from anywhere
resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.web_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

# Allow SSH from anywhere (For public instance)
resource "aws_vpc_security_group_ingress_rule" "allow_ssh_public" {
  security_group_id = aws_security_group.web_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}

# Allow all outbound traffic (for Web-SG)
resource "aws_vpc_security_group_egress_rule" "allow_all_out_web" {
  security_group_id = aws_security_group.web_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # All protocols
}

# Security Group for Private Instance (Private-SG)
resource "aws_security_group" "private_sg" {
  vpc_id = aws_vpc.main.id
  name   = "Private-SG"

  tags = {
    Name = "Private-SG"
  }
}

# Allow SSH only from the Public Subnet (Public Instance)
resource "aws_vpc_security_group_ingress_rule" "allow_ssh_private" {
  security_group_id = aws_security_group.private_sg.id
  referenced_security_group_id = aws_security_group.web_sg.id
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}

# Allow all outbound traffic (for Private-SG)
resource "aws_vpc_security_group_egress_rule" "allow_all_out_private" {
  security_group_id = aws_security_group.private_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # All protocols
}
