locals {
  budget = {
    workspace_id = "ASDFGHJKL"
    channel = {
      "budget-alerts" = "QWERTYUIOPP"
    }
  }
  security = {
    workspace_id = "LKJHGFDSA"
    channel = {
      "security-alerts" = "PPOIUYTREWQ"
    }
  }

  # Both SNS topic ARN and email addresses can be used as subscribers, but at least one of them is required
  budget_subscriber_email_addresses = [
    "prod_alerts@gmail.com",
  ]
  budget_sns_topic_arn = [aws_sns_topic.budget_chatbot.arn]

  security_sns_topic_arn = [aws_sns_topic.security_chatbot.arn]

}

# Optional Automatic creation Chatbot IAM role
module "chatbot_role" {
  source = "./modules/iam"
}


# Configuration of Slack workspace and topics to channels mapping
module "chatbot_budget_slack_workspace" {
  source = "./modules/slack_workspace"

  workspace_id = local.budget.workspace_id

  # Here can be placed default_iam_role_arn for Chatbot instead of automatic creation
  default_iam_role_arn = module.chatbot_role.iam_role_arn

  # Mapping of topics to channels
  channels_config = {
    test = {
      slack_channel_id = local.budget.channel["budget-alerts"]
      sns_topic_arns   = local.budget_sns_topic_arn
    }
  }
}

module "chatbot_prod_slack_workspace" {
  source = "./modules/slack_workspace"

  workspace_id = local.security.workspace_id

  # Here can be placed default_iam_role_arn for Chatbot instead of automatic creation
  default_iam_role_arn = module.chatbot_role.iam_role_arn

  # Mapping of topics to channels
  channels_config = {
    test = {
      slack_channel_id = local.security.channel["security-alerts"]
      sns_topic_arns   = local.security_sns_topic_arn
    }
  }
}

# It will automatically create budget, with notifications for 100%, 150% and 200% of limit amount for forecasted and actual costs
module "budget_alerts" {
  source = "./modules/budget_alerts"

  limit_amount = "10000"

  subscriber_sns_topic_arns  = local.budget_sns_topic_arn
  subscriber_email_addresses = local.budget_subscriber_email_addresses
}

module "cost_anomaly_detection" {
  source = "./modules/cost_anomaly_detection"

  # https://docs.aws.amazon.com/cost-management/latest/userguide/cad-alert-chime.html

  anomaly_monitor_name      = "monitor"
  anomaly_subscription_name = "xxxxxx"
  frequency                 = "DAILY"
  threshold                 = "100.0"

  # TODO: % change, specific amount change

  subscriber_sns_topic_arns  = local.budget_sns_topic_arn
  subscriber_email_addresses = local.budget_subscriber_email_addresses
}

module "eventbridge_alerts" {
  source = "./modules/eventbridge"

  # create_guardduty_findings_rule will create eventbridge rule and send all GuardDuty findings to Slack
  create_guardduty_findings_rule = true

  # create_aws_health_rule will create eventbridge rule and send all AWS Health events to Slack
  create_aws_health_rule = true

  sns_topic_arn = local.security_sns_topic_arn[0]
}


# SNS topic for Chatbot
resource "aws_sns_topic" "budget_chatbot" {
  name = "test_chatbot_topic"
}
# SNS topic policy for Chatbot
resource "aws_sns_topic_policy" "budget_chatbot" {
  arn = aws_sns_topic.budget_chatbot.arn
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "chatbot_topic_policy"
    Statement = [
      {
        Sid       = "AllowSNSPublish"
        Effect    = "Allow"
        Principal = "*"
        Action    = "sns:Publish"
        Resource  = aws_sns_topic.budget_chatbot.arn
      },
      {
        Sid       = "AllowSNSSubscriptions"
        Effect    = "Allow"
        Principal = "*"
        Action    = "sns:Subscribe"
        Resource  = aws_sns_topic.budget_chatbot.arn
      },
      {
        Sid    = "AllowChatbotSubscriptions"
        Effect = "Allow"
        Principal = {
          "Service" : "chatbot.amazonaws.com"
        },
        Action   = "sns:Subscribe"
        Resource = aws_sns_topic.budget_chatbot.arn
      },
      {
        Sid    = "AllowBudgetsPublish",
        Effect = "Allow",
        Principal = {
          Service = "budgets.amazonaws.com"
        },
        Action   = "SNS:Publish",
        Resource = aws_sns_topic.budget_chatbot.arn
      },
      {
        Sid    = "AllowEventsPublish",
        Effect = "Allow",
        Principal = {
          Service = "events.amazonaws.com"
        },
        Action   = "SNS:Publish",
        Resource = aws_sns_topic.budget_chatbot.arn
      }
    ]
  })
}

# Security topic
resource "aws_sns_topic" "security_chatbot" {
  name = "security"
}

resource "aws_sns_topic_policy" "security_chatbot" {
  arn = aws_sns_topic.security_chatbot.arn
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "chatbot_topic_policy"
    Statement = [
      {
        Sid       = "AllowSNSPublish"
        Effect    = "Allow"
        Principal = "*"
        Action    = "sns:Publish"
        Resource  = aws_sns_topic.security_chatbot.arn
      },
      {
        Sid       = "AllowSNSSubscriptions"
        Effect    = "Allow"
        Principal = "*"
        Action    = "sns:Subscribe"
        Resource  = aws_sns_topic.security_chatbot.arn
      },
      {
        Sid    = "AllowChatbotSubscriptions"
        Effect = "Allow"
        Principal = {
          "Service" : "chatbot.amazonaws.com"
        },
        Action   = "sns:Subscribe"
        Resource = aws_sns_topic.security_chatbot.arn
      },
      {
        Sid    = "AllowEventsPublish",
        Effect = "Allow",
        Principal = {
          Service = "events.amazonaws.com"
        },
        Action   = "SNS:Publish",
        Resource = aws_sns_topic.security_chatbot.arn
      }
    ]
  })
}


