resource "aws_launch_configuration" "main" {
  name_prefix = "lc-${var.app}"
  image_id = data.aws_ami.docker.id
  instance_type = var.ec2_instance_type
  key_name = var.aws_key_pair
  security_groups = [aws_security_group.asg.id]
  user_data = data.template_file.docker.rendered
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "main" {
  name_prefix = "asg-${var.app}"
  min_size = 2
  max_size = 4
  desired_capacity = 2
  health_check_grace_period = 300
  health_check_type = "ELB"
  vpc_zone_identifier = var.subnet_ids
  launch_configuration      = aws_launch_configuration.main.name

  target_group_arns = [var.lb_target_group]

  lifecycle {
    create_before_destroy = true
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      instance_warmup = 300
      min_healthy_percentage = 100
    }
    triggers = ["tag"]
  }

  tags = concat(
    [
      {
        "key"                 = "Name"
        "value"               = var.app
        "propagate_at_launch" = true
      }
    ]
  )
}

resource "aws_autoscaling_policy" "web_policy_up" {
  name = "${var.app}-up"
  scaling_adjustment = 1
  adjustment_type = "ChangeInCapacity"
  cooldown = 300
  autoscaling_group_name = aws_autoscaling_group.main.name
}
resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_up" {
  alarm_name = "${var.app}_cpu_alarm_up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "70"
  dimensions = {
      AutoScalingGroupName = aws_autoscaling_group.main.name
    }
  alarm_description = "add ec2"
    alarm_actions = [aws_autoscaling_policy.web_policy_up.arn]
}


resource "aws_autoscaling_policy" "web_policy_down" {
  name = "${var.app}-down"
  scaling_adjustment = -1
  adjustment_type = "ChangeInCapacity"
  cooldown = 300
  autoscaling_group_name = aws_autoscaling_group.main.name
}
resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_down" {
  alarm_name = "${var.app}_cpu_alarm_down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "30"
  dimensions = {
      AutoScalingGroupName = aws_autoscaling_group.main.name
    }
  alarm_description = "remove ec2"
    alarm_actions = [aws_autoscaling_policy.web_policy_down.arn]
}