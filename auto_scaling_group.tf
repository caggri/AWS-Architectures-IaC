resource "aws_autoscaling_group" "ASG_Demo" {
  capacity_rebalance  = true
  desired_capacity    = 2
  max_size            = 4
  min_size            = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  launch_template {
      id = "${aws_launch_template.DemoTemplate.id}"
      version = "${aws_launch_template.DemoTemplate.latest_version}"
    }
  vpc_zone_identifier = ["${aws_subnet.PublicSubnetA.id}", "${aws_subnet.PublicSubnetB.id}"]

  target_group_arns = ["${aws_lb_target_group.TargetGroupDemo.arn}"]
}

resource "aws_autoscaling_policy" "PolicyUp" {
  name = "PolicyUp"
  scaling_adjustment = 1
  adjustment_type = "ChangeInCapacity"
  cooldown = 300
  autoscaling_group_name = "${aws_autoscaling_group.ASG_Demo.name}"
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm_up" {
  alarm_name = "cpu_alarm_up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "60"

  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.ASG_Demo.name}"
  }

  alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions = [ "${aws_autoscaling_policy.PolicyUp.arn}" ]
}


resource "aws_autoscaling_policy" "PolicyDown" {
  name = "PolicyDown"
  scaling_adjustment = -1
  adjustment_type = "ChangeInCapacity"
  cooldown = 300
  autoscaling_group_name = "${aws_autoscaling_group.ASG_Demo.name}"
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm_down" {
  alarm_name = "cpu_alarm_down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "30"

  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.ASG_Demo.name}"
  }

  alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions = [ "${aws_autoscaling_policy.PolicyDown.arn}" ]
}