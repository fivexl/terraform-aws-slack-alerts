# Standartized and simplified budget alert

This module allows you to create a budget alert with a single line of code. It also allows you to specify the percentage of the budget threshold to notify. With default values, notifications will be sent at 100%, 150%, and 200% of the budget `limit_amount`.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.64 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.33.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_budgets_budget.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/budgets_budget) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | (Optional) Controls if budget should be created. | `bool` | `true` | no |
| <a name="input_limit_amount"></a> [limit\_amount](#input\_limit\_amount) | (Required) The amount of cost or usage being measured for a budget. | `string` | n/a | yes |
| <a name="input_limit_unit"></a> [limit\_unit](#input\_limit\_unit) | (Optional) The unit of measurement used for the budget forecast, actual spend, or budget threshold, such as dollars or GB. | `string` | `"USD"` | no |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The name of a budget. Unique within accounts. | `string` | `"cost-budget-alerts"` | no |
| <a name="input_notification_on_threshold_percentage"></a> [notification\_on\_threshold\_percentage](#input\_notification\_on\_threshold\_percentage) | (Optional) The percentage of the budget threshold to notify. With default values, notifications will be sent at 100%, 150%, and 200% of the budget `limit_amount`. | `list(number)` | <pre>[<br>  100,<br>  150,<br>  200<br>]</pre> | no |
| <a name="input_subscriber_email_addresses"></a> [subscriber\_email\_addresses](#input\_subscriber\_email\_addresses) | (Optional) E-Mail addresses to notify. Either this or subscriber\_sns\_topic\_arns is required. | `list(string)` | `[]` | no |
| <a name="input_subscriber_sns_topic_arns"></a> [subscriber\_sns\_topic\_arns](#input\_subscriber\_sns\_topic\_arns) | (Optional) SNS topics to notify. Either this or subscriber\_email\_addresses is required. | `list(string)` | `[]` | no |
| <a name="input_time_period_start"></a> [time\_period\_start](#input\_time\_period\_start) | (Optional) The start of the time period covered by the budget. If you don't specify a start date, AWS defaults to the start of your chosen time period. The start date must come before the end date. Format: 2023-01-01\_00:00. | `string` | `"2023-01-01_00:00"` | no |
| <a name="input_time_unit"></a> [time\_unit](#input\_time\_unit) | (Required) The length of time until a budget resets the actual and forecasted spend. Valid values: MONTHLY, QUARTERLY, ANNUALLY, and DAILY. | `string` | `"MONTHLY"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
