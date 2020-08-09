resource "aws_launch_configuration" "media" {
  name_prefix     = "${var.application["name"]}-${var.application["environment"]}-asg_launch_configuration"
  image_id        = var.AMIS[var.AWS_REGION]
  instance_type   = "t2.micro"
  key_name        = var.asg_key_name
  security_groups = [aws_security_group.instance.id]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "default" {
  name                      = "example-autoscaling"
  vpc_zone_identifier       = [aws_subnet.main-public-1.id]
  launch_configuration      = aws_launch_configuration.media.name
  min_size                  = 1
  max_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  load_balancers            = [aws_elb.media.name]
  force_delete              = true
  depends_on = [aws_launch_configuration.media]

  tag {
    key = "environment"
    value = var.application["environment"]
    propagate_at_launch = true
  }

  tag {
    key = "application"
    value = var.application["name"]
    propagate_at_launch = true
  }
}

