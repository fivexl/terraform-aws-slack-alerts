# AWS Alerts to Slack Terraform Module

## Overview

The `aws-alerts-to-slack` Terraform module offers a seamless method to monitor critical AWS alerts and relay them directly to your Slack workspace. By encapsulating the complexities of AWS services and configurations, this module delivers a straightforward deployment process, allowing quick integration of comprehensive monitoring and alerting into your infrastructure.

## Alerting Flow:

1. **AWS Service Alert:** Utilizes native AWS alerts based on your preferences, from AWS cost anomaly detections to AWS Health events.

2. **AWS SNS Topic:** When an alert is activated, it's sent to a designated SNS topic. This centralizes alert messages, enabling delivery to multiple subscribers when required.

3. **AWS Chatbot:** AWS Chatbot processes these SNS messages, serving as a conduit between AWS and Slack, and transforms the SNS messages into a Slack-friendly format.

4. **Slack:** The alert is then dispatched to your specified Slack channel, ensuring prompt responses to potential issues or anomalies.

## Features

- **Easy Deployment:** By simplifying AWS configurations, the module allows for a swift deployment of a potent alerting system.
  
- **Standardized Alerts:** Provides a uniform alerting mechanism across various AWS services.

- **Modularity:** Each AWS service alert is structured as an individual module, enhancing code maintainability and offering users the freedom to select alerts pertinent to their infrastructure.

## Implemented Alerts

- **Reservations Utilization Alert:** Activates when Reserved Instance utilization drops below a certain threshold.

- **Savings Plans Utilization Alert:** Notifies when Savings Plans utilization decreases below a specified threshold.

- **Budget Alerts:** Observes forecasted or actual costs. An alert is sent if costs exceed a certain percentage of a set limit. The system auto-generates a budget with notifications at 100%, 150%, and 200% of the limit amount for both forecasted and actual costs.

- **EventBridge Alerts:**
  - **GuardDuty Findings:** Directs any AWS GuardDuty discoveries straight to Slack.
  - **AWS Health Events:** Monitors AWS Health-related events.

- **Cost Anomaly Detection:** Implements AWS Cost Explorer's Cost Anomaly Detection alerts.

For further details on each alert, refer to the `/modules` directory.

## Configuration Guide

Before deploying this module, you must set up the Slack workspace. Follow the steps below or consult the [official documentation](https://docs.aws.amazon.com/chatbot/latest/adminguide/slack-setup.html#:~:text=To%20configure%20a%20Slack%20client).

### Setting Up AWS Chatbot in Slack

1. In Slack's left navigation pane, select **Apps**.
    > Note: If **Apps** isn't visible, click on **More**, then choose **Apps**.
2. If AWS Chatbot isn't listed, click on **Browse Apps Directory**.
3. Search for the AWS Chatbot app and click **Add** to integrate it into your workspace.
4. Navigate to the [AWS Chatbot console](https://console.aws.amazon.com/chatbot/).
5. Under "Configure a chat client", select **Slack**, then **Configure client**.
6. From the dropdown list, choose the Slack workspace you wish to use with AWS Chatbot.
7. Click **Allow**.

### Configuring Slack Channel to SNS Topic

Configure the Slack channel to SNS topic mapping using `/modules/slack-workspace`.

```hcl
module "chatbot_slack_workspace" {
  source = "./modules/slack_workspace"

  workspace_id = local.slack.workspace_id
  default_iam_role_arn = module.chatbot_role.iam_role_arn

  channels_config = {
    test = {
      slack_channel_id = local.slack.channel["dev-alerts"]
      sns_topic_arns   = prod_sns_topic_arn
    }
  }
  tags = module.tags.result
}
```

Afterward, create an SNS topic and link it to the Slack channel:
    
```hcl
# SNS topic for Chatbot
resource "aws_sns_topic" "chatbot" {
  name = "test_chatbot_topic"
}

# SNS topic policy for Chatbot
resource "aws_sns_topic_policy" "chatbot_topic" {
  arn    = aws_sns_topic.chatbot.arn
  policy = jsonencode({
    // policy details
  })
}
```
Subsequently, you can leverage any alert module from the /modules directory or devise your custom alert, then subscribe it to the SNS topic. Here's an example of the budget alert:

```hcl
# This automatically establishes a budget with notifications for 100%, 150%, and 200% of the limit amount for both forecasted and actual costs
module "budget_alerts" {
  source = "./modules/budget_alerts"

  limit_amount                = "10000"
  subscriber_sns_topic_arns   = local.prod_sns_topic_arn
  subscriber_email_addresses  = local.budget_subscriber_email_addresses
}
```

For additional usage examples, consult the /examples directory.

# Conclusion
Stay proactive and enhance your alerting system with the aws-alerts-to-slack Terraform module. By channeling AWS alerts directly into Slack, your team remains informed and ready to act, ensuring the resilience and observability of your AWS infrastructure.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.64 |
| <a name="requirement_awscc"></a> [awscc](#requirement\_awscc) | 0.58.0 |

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->