## ADDED Requirements

### Requirement: Publish and Subscribe
The SNS provider SHALL support Publish operations with fan-out to all subscribed Lambda handlers.

#### Scenario: Publish fans out to Lambda subscribers
- **WHEN** a handler publishes a message to an SNS topic with two Lambda subscribers
- **THEN** both Lambda handlers SHALL be invoked with the SNS event containing the message

### Requirement: SQS Subscriptions
The provider SHALL route SNS messages to subscribed SQS queues when the CDK defines an SNS-to-SQS subscription.

#### Scenario: SNS publish delivers to SQS
- **WHEN** a handler publishes a message to an SNS topic that has an SQS queue subscription
- **THEN** the message SHALL appear in the subscribed SQS queue

### Requirement: Message Filtering
The provider SHALL support SNS subscription filter policies so that messages are only delivered to subscribers whose filters match.

#### Scenario: Filtered subscription
- **WHEN** a subscriber has a filter policy `{"status": ["critical"]}` and a message is published with `MessageAttributes` where `status = "info"`
- **THEN** the subscriber SHALL NOT receive the message

#### Scenario: Matching filter
- **WHEN** a subscriber has a filter policy `{"status": ["critical"]}` and a message is published with `MessageAttributes` where `status = "critical"`
- **THEN** the subscriber SHALL receive the message
