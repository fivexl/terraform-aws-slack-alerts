locals {
  actual_notifications = { for threshold in var.notification_on_threshold_percentage : "actual_${threshold}" => {
    comparison_operator        = "GREATER_THAN"
    threshold                  = threshold
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = var.subscriber_email_addresses
    subscriber_sns_topic_arns  = var.subscriber_sns_topic_arns

  } }
  forecasted_notifications = { for threshold in var.notification_on_threshold_percentage : "forecasted_${threshold}" => {
    comparison_operator        = "GREATER_THAN"
    threshold                  = threshold
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = var.subscriber_email_addresses
    subscriber_sns_topic_arns  = var.subscriber_sns_topic_arns
  } }
}

resource "aws_budgets_budget" "this" {
  count = var.create ? 1 : 0

  name              = var.name
  budget_type       = "COST"
  limit_amount      = var.limit_amount
  limit_unit        = var.limit_unit
  time_period_start = var.time_period_start
  time_unit         = var.time_unit

  dynamic "auto_adjust_data" {
    for_each = var.auto_adjust ? toset(["auto_adjust"]) : toset([])
    content {
      auto_adjust_type = "HISTORICAL"

      historical_options {
        budget_adjustment_period = var.budget_adjustment_period
      }
    }
  }

  dynamic "notification" {
    for_each = merge(local.actual_notifications, local.forecasted_notifications)
    content {
      comparison_operator        = notification.value.comparison_operator
      threshold                  = notification.value.threshold
      threshold_type             = notification.value.threshold_type
      notification_type          = notification.value.notification_type
      subscriber_email_addresses = notification.value.subscriber_email_addresses
      subscriber_sns_topic_arns  = notification.value.subscriber_sns_topic_arns
    }
  }
}

