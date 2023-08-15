# Cost anomaly detection alert


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.64 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.64 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ce_anomaly_monitor.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ce_anomaly_monitor) | resource |
| [aws_ce_anomaly_subscription.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ce_anomaly_subscription) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_anomaly_monitor_name"></a> [anomaly\_monitor\_name](#input\_anomaly\_monitor\_name) | (Optional) The name of the anomaly monitor. | `string` | `"AWSServiceMonitor"` | no |
| <a name="input_anomaly_subscription_name"></a> [anomaly\_subscription\_name](#input\_anomaly\_subscription\_name) | (Optional) The name of the anomaly subscription. | `string` | `"AWSServiceSubscription"` | no |
| <a name="input_frequency"></a> [frequency](#input\_frequency) | (Optional) The frequency that anomaly reports are sent. Valid Values: DAILY \| IMMEDIATE \| WEEKLY.<br>    Daily or weekly frequencies only support Email subscriptions<br>    Immediate frequencies support a max of one subscriber | `string` | `"DAILY"` | no |
| <a name="input_subscriber_email_addresses"></a> [subscriber\_email\_addresses](#input\_subscriber\_email\_addresses) | (Optional) E-Mail addresses to notify. Either this or subscriber\_sns\_topic\_arns is required. | `list(string)` | `[]` | no |
| <a name="input_subscriber_sns_topic_arns"></a> [subscriber\_sns\_topic\_arns](#input\_subscriber\_sns\_topic\_arns) | (Optional) SNS topics to notify. Either this or subscriber\_email\_addresses is required. | `list(string)` | `[]` | no |
| <a name="input_threshold"></a> [threshold](#input\_threshold) | (Required) The dollar value that triggers a notification if the threshold is exceeded. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->