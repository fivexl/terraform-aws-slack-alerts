resource "aws_budgets_budget" "savings_plan_utilization" {
  count             = var.create_utilization_alert ? 1 : 0
  name              = var.budget_name
  budget_type       = "SAVINGS_PLANS_UTILIZATION"
  time_unit         = "DAILY"
  time_period_start = var.budget_time_period_start

  cost_types {
    include_credit             = false
    include_discount           = false
    include_other_subscription = false
    include_recurring          = false
    include_refund             = false
    include_subscription       = true
    include_support            = false
    include_tax                = false
    include_upfront            = false
    use_amortized              = false
    use_blended                = false
  }

  notification {
    comparison_operator        = "LESS_THAN"
    threshold                  = var.threshold
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = var.subscriber_email_addresses
    subscriber_sns_topic_arns  = var.subscriber_sns_topic_arns
  }
}
