# ---------------------------------------- Utilization_alert ----------------------------------------
variable "budget_name" {
  type        = string
  default     = "Savings Plans Utilization"
  description = "(Optional) The name of the savings_plans_budget. Defaults to 'Savings Plans Utilization'."
}

variable "threshold" {
  type        = number
  default     = 90
  description = "(Optional) Threshold when the notification should be sent."
}

variable "budget_time_period_start" {
  type        = string
  default     = "2023-01-01_00:00"
  description = "(Optional) The time_period_start of the alert. Defaults to '2023-01-01_00:00'."
}

variable "subscriber_sns_topic_arns" {
  type        = list(string)
  default     = []
  description = "(Optional) SNS topics to notify. Either this or subscriber_email_addresses is required."
}

variable "subscriber_email_addresses" {
  type        = list(string)
  default     = []
  description = "(Optional) E-Mail addresses to notify. Either this or subscriber_sns_topic_arns is required."
}

variable "create_utilization_alert" {
  type        = bool
  default     = true
  description = "(Optional) Whether to create a savings plan utilization budget. Defaults to true."
}
