resource "aws_cloudwatch_metric_alarm" "threshold" {
  alarm_name  = "${var.prefix}-not-enough-head-ppe"

  comparison_operator = "GreaterThanThreshold"
  threshold           = var.threshold
  evaluation_periods  = 2

  alarm_description = "This alarm goes off as soon as it registers that the precentage of people without head ppe is above the threshold (default 25%)"
  alarm_actions     = [aws_sns_topic.user_updates.arn]
  
  metric_query {
      id = "e1"
      expression = "(m2/m1) * 100"
      label = "Precentage of people without head ppe"
      return_data = "true"
  }
  
  metric_query {
      id = "m1"
      metric {
          metric_name = "people_scanned.count"
          namespace = "${var.cloudwatch_namespace}"
          period = 300
          stat = "Sum"
          unit = "Count"
      }
  }
  
  metric_query {
      id = "m2"
      metric {
          metric_name = "head_violations.count"
          namespace = "${var.cloudwatch_namespace}"
          period = 300
          stat = "Sum"
          unit = "Count"
      }
  }
}

resource "aws_sns_topic" "user_updates" {
  name = "${var.prefix}-alarm-topic"
}

resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
  topic_arn = aws_sns_topic.user_updates.arn
  protocol  = "email"
  endpoint  = var.alarm_email
}