# Savings plans utilization alert

This module creates a budget alert for Savings Plans utilization. It will send notifications when utilization falls below a specified threshold.

Required only 2 values:
- `threshold` - percentage of utilization
- `subscriber_sns_topic_arns` or `subscriber_email_addresses` 


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.64 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.76.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_budgets_budget.savings_plan_utilization](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/budgets_budget) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_budget_name"></a> [budget\_name](#input\_budget\_name) | (Optional) The name of the savings\_plans\_budget. Defaults to 'Savings Plans Utilization'. | `string` | `"Savings Plans Utilization"` | no |
| <a name="input_budget_time_period_start"></a> [budget\_time\_period\_start](#input\_budget\_time\_period\_start) | (Optional) The time\_period\_start of the alert. Defaults to '2023-01-01\_00:00'. | `string` | `"2023-01-01_00:00"` | no |
| <a name="input_create_utilization_alert"></a> [create\_utilization\_alert](#input\_create\_utilization\_alert) | (Optional) Whether to create a savings plan utilization budget. Defaults to true. | `bool` | `true` | no |
| <a name="input_subscriber_email_addresses"></a> [subscriber\_email\_addresses](#input\_subscriber\_email\_addresses) | (Optional) E-Mail addresses to notify. Either this or subscriber\_sns\_topic\_arns is required. | `list(string)` | `[]` | no |
| <a name="input_subscriber_sns_topic_arns"></a> [subscriber\_sns\_topic\_arns](#input\_subscriber\_sns\_topic\_arns) | (Optional) SNS topics to notify. Either this or subscriber\_email\_addresses is required. | `list(string)` | `[]` | no |
| <a name="input_threshold"></a> [threshold](#input\_threshold) | (Optional) Threshold when the notification should be sent. | `number` | `90` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
