variable "create" {
  type        = bool
  default     = true
  description = "(Optional) Controls if budget should be created."
}

variable "name" {
  description = "(Optional) The name of a budget. Unique within accounts."
  type        = string
  default     = "cost-budget-alerts"
}

variable "subscriber_sns_topic_arns" {
  type        = list(string)
  description = "(Optional) SNS topics to notify. Either this or subscriber_email_addresses is required."
  default     = []
}

variable "subscriber_email_addresses" {
  type        = list(string)
  description = "(Optional) E-Mail addresses to notify. Either this or subscriber_sns_topic_arns is required."
  default     = []
}

variable "time_period_start" {
  type        = string
  description = "(Optional) The start of the time period covered by the budget. If you don't specify a start date, AWS defaults to the start of your chosen time period. The start date must come before the end date. Format: 2023-01-01_00:00."
  default     = "2023-01-01_00:00"
}

variable "limit_amount" {
  type        = string
  description = "(Required) The amount of cost or usage being measured for a budget."
}

variable "limit_unit" {
  type        = string
  description = "(Optional) The unit of measurement used for the budget forecast, actual spend, or budget threshold, such as dollars or GB."
  default     = "USD"
}

variable "time_unit" {
  description = "(Required) The length of time until a budget resets the actual and forecasted spend. Valid values: MONTHLY, QUARTERLY, ANNUALLY, and DAILY."
  type        = string
  default     = "MONTHLY"
}

variable "notification_on_threshold_percentage" {
  type        = list(number)
  default     = [100, 150, 200]
  description = "(Optional) The percentage of the budget threshold to notify. With default values, notifications will be sent at 100%, 150%, and 200% of the budget `limit_amount`."
}

variable "auto_adjust" {
  type        = bool
  default     = true
  description = "Auto adjust budget based on historical values"
}

variable "budget_adjustment_period" {
  type        = number
  default     = 6
  description = "Number of month to look back for historical values"
}
