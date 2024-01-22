# Reservations utilization alert

This module creates a budget alert for Reserved Instance utilization. It will send notifications when utilization falls below a specified threshold.

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
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.33.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_budgets_budget.reservations_utilization](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/budgets_budget) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | (Optional) Controls if budget should be created. | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The name of a budget. Unique within accounts. | `string` | `"ri-utilization-budget-alerts"` | no |
| <a name="input_services"></a> [services](#input\_services) | (Optional) List of services to send alerts for. Defaults to all services. | `list(string)` | <pre>[<br>  "Amazon Elasticsearch Service",<br>  "Amazon Relational Database Service",<br>  "Amazon Redshift",<br>  "Amazon Elastic Compute Cloud - Compute",<br>  "Amazon ElastiCache",<br>  "Amazon OpenSearch Service"<br>]</pre> | no |
| <a name="input_subscriber_email_addresses"></a> [subscriber\_email\_addresses](#input\_subscriber\_email\_addresses) | (Optional) E-Mail addresses to notify. Either this or subscriber\_sns\_topic\_arns is required. | `list(string)` | `[]` | no |
| <a name="input_subscriber_sns_topic_arns"></a> [subscriber\_sns\_topic\_arns](#input\_subscriber\_sns\_topic\_arns) | (Optional) SNS topics to notify. Either this or subscriber\_email\_addresses is required. | `list(string)` | `[]` | no |
| <a name="input_threshold"></a> [threshold](#input\_threshold) | (Optional) Threshold when the notification should be sent. | `number` | `90` | no |
| <a name="input_time_period_start"></a> [time\_period\_start](#input\_time\_period\_start) | (Optional) The start of the time period covered by the budget. If you don't specify a start date, AWS defaults to the start of your chosen time period. The start date must come before the end date. Format: 2023-01-01\_00:00. | `string` | `"2023-01-01_00:00"` | no |
| <a name="input_time_unit"></a> [time\_unit](#input\_time\_unit) | (Required) The length of time until a budget resets the actual and forecasted spend. Valid values: MONTHLY, QUARTERLY, ANNUALLY, and DAILY. | `string` | `"MONTHLY"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->