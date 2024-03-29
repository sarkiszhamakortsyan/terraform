resource "aws_cloudwatch_metric_alarm" "cpu_util" {
  alarm_name = "terraform-test-cpu-util"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "80"
  alarm_description = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = []

  // ID of the machine on which you will apply the alarm
  dimensions = {
    "InstanceId" = "i-037514cfe233c6b85"
  }
}