## ADDED Requirements

### Requirement: CloudTrail to EventBridge Forwarding
The system SHALL forward captured CloudTrail events to an EventBridge event bus when
the trail has a `CloudWatchLogsLogGroupArn` field set to an EventBridge bus ARN (using
the `arn:aws:events:` prefix as the discriminator). Events SHALL be published as
EventBridge `PutEvents` entries with `Source: aws.cloudtrail`, `DetailType: AWS API Call via CloudTrail`,
and `Detail` containing the full CloudTrail event JSON. Forwarding SHALL occur
synchronously on each event capture (not batched) to preserve real-time reactivity
for EventBridge rules.

#### Scenario: CloudTrail event forwarded to EventBridge bus
- **WHEN** a trail is LOGGING with `EventBridgeEventBusArn` set and a caller invokes any service API
- **THEN** an EventBridge event with `Source: aws.cloudtrail` and the CloudTrail event in `Detail` is delivered to the named bus

#### Scenario: EventBridge rules react to CloudTrail events
- **WHEN** an EventBridge rule matches on `source: aws.cloudtrail` and `detail.eventName: CreateBucket`
- **THEN** the rule target (Lambda, SQS, etc.) is invoked when a `CreateBucket` call is captured

#### Scenario: Missing EventBridge bus silently skipped
- **WHEN** the trail's `EventBridgeEventBusArn` references a bus that does not exist in the EventBridge provider
- **THEN** a warning is logged but no error is raised and event capture continues

### Requirement: EventBridge Forwarding Opt-In
EventBridge forwarding SHALL be disabled by default. It SHALL be enabled by setting
`EventBridgeEventBusArn` via `CreateTrail` or `UpdateTrail`. Removing the ARN (setting
it to empty string) via `UpdateTrail` SHALL disable forwarding.

#### Scenario: Forwarding disabled when no bus ARN set
- **WHEN** a trail is created without `EventBridgeEventBusArn`
- **THEN** captured events are buffered and delivered to S3 only; no EventBridge `PutEvents` calls are made

#### Scenario: Forwarding enabled via UpdateTrail
- **WHEN** `UpdateTrail` sets `EventBridgeEventBusArn` on an existing trail
- **THEN** subsequent captured events are forwarded to EventBridge
