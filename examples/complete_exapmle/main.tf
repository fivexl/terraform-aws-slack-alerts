locals {
  slack = {
    workspace_id = "ASDFGHJKL"
    channel = {
      "prod-alerts" = "PPOIUYTREWQ"
    }
  }
  budget_subscriber_email_addresses = [
    "prod_alerts@gmail.com",
  ]
  prod_sns_topic_arn = [aws_sns_topic.prod_chatbot.arn]
}

# Creation of IAM resources for Chatbot
module "chatbot_role" {
  source = "../../modules/iam"
}


# Configuration of Slack workspace and topics to channels mapping
module "chatbot_slack_workspace" {
  source = "../../modules/slack_workspace"

  workspace_id = local.slack.workspace_id

  default_iam_role_arn = module.chatbot_role.iam_role_arn

  # Mapping of topics to channels
  channels_config = {
    prod = {
      slack_channel_id = local.slack.channel["prod-alerts"]
      sns_topic_arns   = local.prod_sns_topic_arn
    }
  }
}

# Reservations utilization alert
module "reservations_alerts" {
  source = "../../modules/reservations"

  # Threshold, if utilization is less than 90% - alert will be triggered
  threshold                 = "90"
  subscriber_sns_topic_arns = local.prod_sns_topic_arn
}

# Savings plans utilization alert
module "savings_plans_alerts" {
  source = "../../modules/savings_plans"

  # Threshold, if utilization is less than 40% - alert will be triggered
  threshold                 = "40"
  subscriber_sns_topic_arns = local.prod_sns_topic_arn
}


# It will automatically create budget, with notifications for 100%, 150% and 200% of limit amount for forecasted and actual costs
module "budget_alerts" {
  source = "../../modules/budget_alerts"

  limit_amount = "10000"

  subscriber_sns_topic_arns  = local.prod_sns_topic_arn
  subscriber_email_addresses = local.budget_subscriber_email_addresses
}

module "eventbridge_alerts" {
  source = "../../modules/eventbridge"

  # It will create eventbridge rule and send all GuardDuty findings to Slack
  create_guardduty_findings_rule = true

  # Same for AWS Health events
  create_aws_health_rule = true

  sns_topic_arn = local.prod_sns_topic_arn[0]
}


module "cost_anomaly_detection" {
  source = "../../modules/cost_anomaly_detection"

  # https://docs.aws.amazon.com/cost-management/latest/userguide/cad-alert-chime.html

  anomaly_monitor_name      = "monitor"
  anomaly_subscription_name = "xxxxxx"
  frequency                 = "DAILY"
  threshold                 = "100.0"

  # TODO: % change, specific amount change

  subscriber_sns_topic_arns  = local.prod_sns_topic_arn
  subscriber_email_addresses = ["xxxxxx"]
}

# SNS topic for Chatbot
resource "aws_sns_topic" "prod_chatbot" {
  name = "test_chatbot_topic"
}

# SNS topic policy for Chatbot
resource "aws_sns_topic_policy" "prod_chatbot" {
  arn = aws_sns_topic.prod_chatbot.arn
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "chatbot_topic_policy"
    Statement = [
      {
        Sid       = "AllowSNSPublish"
        Effect    = "Allow"
        Principal = "*"
        Action    = "sns:Publish"
        Resource  = aws_sns_topic.prod_chatbot.arn
      },
      {
        Sid       = "AllowSNSSubscriptions"
        Effect    = "Allow"
        Principal = "*"
        Action    = "sns:Subscribe"
        Resource  = aws_sns_topic.prod_chatbot.arn
      },
      {
        Sid    = "AllowChatbotSubscriptions"
        Effect = "Allow"
        Principal = {
          "Service" : "chatbot.amazonaws.com"
        },
        Action   = "sns:Subscribe"
        Resource = aws_sns_topic.prod_chatbot.arn
      },
      {
        Sid    = "AllowBudgetsPublish",
        Effect = "Allow",
        Principal = {
          Service = "budgets.amazonaws.com"
        },
        Action   = "SNS:Publish",
        Resource = aws_sns_topic.prod_chatbot.arn
      },
      {
        Sid    = "AllowEventsPublish",
        Effect = "Allow",
        Principal = {
          Service = "events.amazonaws.com"
        },
        Action   = "SNS:Publish",
        Resource = aws_sns_topic.prod_chatbot.arn
      }
    ]
  })
}
