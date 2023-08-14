variable "anomaly_monitor_name" {
  type        = string
  default     = "AWSServiceMonitor"
  description = "(Optional) The name of the anomaly monitor."
}

variable "anomaly_subscription_name" {
  type        = string
  default     = "AWSServiceSubscription"
  description = "(Optional) The name of the anomaly subscription."
}

variable "frequency" {
  description = <<EOT
    (Optional) The frequency that anomaly reports are sent. Valid Values: DAILY | IMMEDIATE | WEEKLY.
    Daily or weekly frequencies only support Email subscriptions
    Immediate frequencies support a max of one subscriber
    EOT
  type        = string
  default     = "DAILY"
}

variable "threshold" {
  description = "(Required) The dollar value that triggers a notification if the threshold is exceeded."
  type        = string
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
