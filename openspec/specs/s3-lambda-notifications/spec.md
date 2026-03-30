# s3-lambda-notifications Specification

## Purpose
TBD - created by archiving change add-cross-service-dispatch-phase2. Update Purpose after archive.
## Requirements
### Requirement: S3 Lambda Notification Configuration
The system SHALL accept `LambdaFunctionConfigurations` blocks in `put_bucket_notification_configuration` and validate that the referenced Lambda function exists before storing the configuration.

#### Scenario: Lambda notification configured successfully
- **GIVEN** a Lambda function exists
- **WHEN** `put_bucket_notification_configuration` is called with a `LambdaFunctionConfigurations` block referencing that function
- **THEN** the notification configuration is stored and HTTP 200 is returned

#### Scenario: Lambda notification rejected for unknown function
- **GIVEN** no Lambda function exists with the referenced ARN
- **WHEN** `put_bucket_notification_configuration` is called with a `LambdaFunctionConfigurations` block
- **THEN** HTTP 400 is returned with an appropriate error

#### Scenario: Lambda notification rejected when compute provider unavailable
- **GIVEN** S3 is running without a Lambda/compute provider
- **WHEN** `put_bucket_notification_configuration` is called with a `LambdaFunctionConfigurations` block
- **THEN** HTTP 400 is returned

### Requirement: S3 Lambda Object Event Dispatch
The system SHALL invoke the configured Lambda function when an object is PUT into a bucket that has a `LambdaFunctionConfigurations` notification configured and the event matches the configured filter.

#### Scenario: Object PUT triggers Lambda invocation
- **GIVEN** a bucket has a Lambda notification configured for `s3:ObjectCreated:*`
- **WHEN** an object is PUT into the bucket
- **THEN** the configured Lambda function is invoked asynchronously with an S3 event record payload

#### Scenario: Invocation uses correct S3 event envelope
- **GIVEN** a bucket has a Lambda notification configured
- **WHEN** an object is PUT and Lambda is invoked
- **THEN** the invocation payload MUST include `eventSource: "aws:s3"`, the bucket name, and the object key

#### Scenario: Notification not dispatched when event type does not match filter
- **GIVEN** a bucket has a Lambda notification configured for `s3:ObjectRemoved:*`
- **WHEN** an object is PUT (ObjectCreated event)
- **THEN** the Lambda function is NOT invoked

### Requirement: S3 Lambda Notification Function Validation at Configuration Time
The system SHALL validate that the Lambda function referenced in a `LambdaFunctionConfigurations` block is in ACTIVE status before accepting the notification configuration.

#### Scenario: Inactive function rejected
- **GIVEN** a Lambda function exists but is not in ACTIVE status
- **WHEN** `put_bucket_notification_configuration` is called referencing that function
- **THEN** HTTP 400 is returned

