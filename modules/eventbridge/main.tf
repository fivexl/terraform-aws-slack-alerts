resource "aws_cloudwatch_event_rule" "guardduty_findings" {
  count = var.create && var.create_guardduty_findings_rule ? 1 : 0

  name_prefix = "guardduty-findings"
  description = "Rule for GuardDuty findings"

  event_pattern = jsonencode(
    {
      "source" : ["aws.guardduty"],
      "detail-type" : ["GuardDuty Finding"],
    }
  )
}

resource "aws_cloudwatch_event_rule" "aws_health" {
  count = var.create && var.create_aws_health_rule ? 1 : 0

  name_prefix = "aws-health"
  description = "AWS Health events"

  event_pattern = jsonencode(
    {
      "source" : ["aws.health"],
    }
  )
}

resource "aws_cloudwatch_event_target" "guardduty_findings" {
  count = var.create && var.create_guardduty_findings_rule ? 1 : 0

  rule      = aws_cloudwatch_event_rule.guardduty_findings[0].name
  target_id = "SendToSNS"
  arn       = var.sns_topic_arn
}

resource "aws_cloudwatch_event_target" "aws_health" {
  count = var.create && var.create_aws_health_rule ? 1 : 0

  rule      = aws_cloudwatch_event_rule.aws_health[0].name
  target_id = "SendToSNS"
  arn       = var.sns_topic_arn
}

