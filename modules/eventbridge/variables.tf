variable "create" {
  description = "(Optional) Controls if the resources in this module should be created."
    type        = bool
    default     = true
}

variable "sns_topic_arn" {
  description = "(Required) The ARN of the SNS topic to send notifications to."
    type        = string
}

variable "create_guardduty_findings_rule" {
  description = "(Optional) Whether to create the GuardDuty findings rule."
    type        = bool
    default     = true
}

variable "create_aws_health_rule" {
  description = "(Optional) Whether to create the AWS Health rule."
    type        = bool
    default     = true
}
