resource "aws_security_group" "instance" {
  vpc_id      = aws_vpc.main.id
  name        = "${var.application["name"]}-${var.application["environment"]}-instance"
  description = "security group for my instance"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.elb.id]
  }

  tags = {
    Name = var.application["name"]
  }
}

resource "aws_security_group" "elb" {
  vpc_id      = aws_vpc.main.id
  name        = "${var.application["name"]}-${var.application["environment"]}-elb"
  description = "security group for load balancer"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.application["name"]
    environment = var.application["environment"]
  }
}

