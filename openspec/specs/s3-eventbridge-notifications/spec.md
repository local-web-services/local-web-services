# s3-eventbridge-notifications Specification

## Purpose
TBD - created by archiving change add-cross-service-dispatch-phase2. Update Purpose after archive.
## Requirements
### Requirement: S3 EventBridge Notification SDK Configuration
The SDK step definitions SHALL support configuring an S3 bucket to send notification events to EventBridge by calling `put_bucket_notification_configuration()` with an `EventBridgeConfiguration: {}` block.

#### Scenario: Bucket notification configured to EventBridge
- **GIVEN** an S3 bucket exists
- **WHEN** `put_bucket_notification_configuration` is called with `EventBridgeConfiguration: {}`
- **THEN** the bucket notification configuration is stored and subsequent object PUTs emit events to the default EventBridge bus

#### Scenario: EventBridge notification configuration is idempotent
- **GIVEN** an S3 bucket already has an EventBridge notification configured
- **WHEN** `put_bucket_notification_configuration` is called again with the same configuration
- **THEN** the request succeeds and no duplicate events are emitted

### Requirement: S3 EventBridge Notification Target Deletion Error Handling
The system SHALL return a descriptive error when an object is PUT into a bucket whose EventBridge notification target bus has been deleted.

#### Scenario: Target bus deleted before object PUT
- **GIVEN** a bucket has an EventBridge notification configured for a custom bus
- **WHEN** the target bus is deleted and an object is then PUT into the bucket
- **THEN** the PUT request succeeds (S3 does not fail on notification delivery errors) and the notification delivery failure is recorded

