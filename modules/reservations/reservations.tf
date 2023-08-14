resource "aws_budgets_budget" "reservations_utilization" {
  for_each = var.create ? toset(var.services) : toset([])

  name              = "${var.name} - ${each.value}"
  budget_type       = "RI_UTILIZATION"
  time_unit         = var.time_unit
  time_period_start = var.time_period_start

  cost_filter {
    name = "Service"
    values = [
      each.value,
    ]
  }

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


