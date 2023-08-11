variable "create" {
  type        = bool
  default     = true
  description = "(Optional) Controls if budget should be created."
}

variable "name" {
  description = "(Optional) The name of a budget. Unique within accounts."
  type        = string
  default     = "ri-utilization-budget-alerts"
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

variable "time_unit" {
  description = "(Required) The length of time until a budget resets the actual and forecasted spend. Valid values: MONTHLY, QUARTERLY, ANNUALLY, and DAILY."
  type        = string
  default     = "MONTHLY"
}

variable "threshold" {
  type        = number
  default     = 90
  description = "(Optional) Threshold when the notification should be sent."
}

variable "services" {
  type       = list(string)
  default = [
    "Amazon Elasticsearch Service",
    "Amazon Relational Database Service",
    "Amazon Redshift",
    "Amazon Elastic Compute Cloud - Compute",
    "Amazon ElastiCache",
    "Amazon OpenSearch Service",
    ]
  description = "(Optional) List of services to send alerts for. Defaults to all services."
}
